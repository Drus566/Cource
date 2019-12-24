require 'rails_helper'
RSpec.describe ApplicationController, type: :controller do
    render_views

    describe '#home' do
        it 'has a 200 status code' do
            get :home
            expect(response.status).to eq(200)
        end

        it 'render cource' do
            get :home
            expect(response.body).to match /id='cource'>\d+/
        end
    end

    describe '#admin' do
        it 'has a 200 status code' do
            get :admin
            expect(response.status).to eq(200)
        end

        it 'render form' do
            get :admin
            expect(response.body).to match /admin-form/
        end

        it 'remember previous values' do
            get :admin
            post :force_update, xhr: true, :params => {'cource':{'cource':{'value':'12','date':'12/12/2020','time':'12:12'}}}
            get :admin 
            expect(response.body).to match /value="12:12"/
        end
    end

    describe '#force_update' do
        it 'has a 200 status code' do
            post :force_update, xhr: true, :params => {'cource':{'cource':{'value':'12','date':'12/12/2020','time':'12:12'}}}
            expect(response.status).to eq(200)
        end

        it 'render without errors' do
            post :force_update, xhr: true, :params => {'cource':{'cource':{'value':'12','date':'12/12/3020','time':'12:12'}}}
            expect(response.body).to match /var flash_error = ""/
        end
        
        it 'render with errors' do
            post :force_update, xhr: true, :params => {'cource':{'cource':{'value':'12','date':'12/12/20','time':'12:12'}}}
            expect(response.body).to match /var flash_error = "Date is not correct"/
        end
    end
end
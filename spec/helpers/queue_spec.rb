RSpec.describe QueueHelper, :type => :helper do
    before(:context) do
        @hash = {"queue_step":0,"queue":[]}
        @job = {'date':'20/20/2019', 'time':'01:00'}
    end

    describe '#add_job' do
        it 'add job to hash' do
            expect(helper.add_job(@hash, @job)).to eq([{:date=>"20/20/2019", :time=>"01:00"}])
        end

        it 'add another job to hash' do
            another_job = {'date':'21/20/2019', 'time':'24:23'}
            expect(helper.add_job(@hash, another_job)).to eq([{:date=>"20/20/2019", :time=>"01:00"}, {:date=>"21/20/2019", :time=>"24:23"}])
        end
    end

    describe '#delete_job' do
        it 'delete job from hash' do
            another_job = {'date':'21/20/2019', 'time':'24:23'}
            expect(helper.delete_job(@hash, another_job)).to eq([{:date=>"20/20/2019", :time=>"01:00"}, {:date=>"21/20/2019", :time=>"24:23"}])
        end
    end
end
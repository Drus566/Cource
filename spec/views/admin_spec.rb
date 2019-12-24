require "rails_helper"

RSpec.describe "application/admin" do
  it "display admin page" do
    @forced_cource = {:cource => {:value => '2.32', :date => '12/12/2019', :time => '12:12', :force => 'true'}}
    ProcessJson.write_data('app/data/cource_data.json', @forced_cource)
    @forced_cource = ProcessJson.read_data('app/data/cource_data.json')
    assign(:forced_cource, @forced_cource)
    render
    expect(rendered).to match /2.32/
  end
end
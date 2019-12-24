require "rails_helper"

RSpec.describe ForceUpdateCourceJob, :type => :job do
  describe "#perform_later" do
    it "enqueued job" do
      @forced_cource = {:cource => {:value => '2', :date => '12/12/2019', :time => '12:12', :force => 'true'}}
      ProcessJson.write_data('app/data/cource_data.json', @forced_cource)
      @forced_cource = ProcessJson.read_data('app/data/cource_data.json')
      ActiveJob::Base.queue_adapter = :test
      ForceUpdateCourceJob.set(wait: 1).perform_later(@forced_cource)
      expect(ForceUpdateCourceJob).to have_been_enqueued
    end
  end
end
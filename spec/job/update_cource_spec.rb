require "rails_helper"

RSpec.describe UpdateCourceJob, :type => :job do
  describe "#perform_later" do
    it "enqueued job" do
      ActiveJob::Base.queue_adapter = :test
      UpdateCourceJob.set(wait: 1).perform_later
      expect(UpdateCourceJob).to have_been_enqueued
    end
  end
end
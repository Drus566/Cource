# Load the Rails application.
require_relative 'application'
require 'process_json'
# Initialize the Rails application.
Rails.application.initialize!

forced_cource = { "cource": { "value": "", "date": "", "time": "", "forced": false} }
ProcessJson.write_data('app/data/cource_data.json', forced_cource)

queue_data = {"queue_step":"0","queue":[]}
ProcessJson.write_data('app/data/queue_data.json', queue_data)

# UpdateCourceJob.perform_now


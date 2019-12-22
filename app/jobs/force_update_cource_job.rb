class ForceUpdateCourceJob < ApplicationJob
    include QueueHelper

    queue_as :high_priority
    
    before_enqueue do |job|
        cource = job.arguments.first
        process_json = ProcessJson.write_data('app/data/cource_data.json', cource)
        ActionCable.server.broadcast 'cource_channel', cource: cource['cource']['value']
    end

    def perform(cource)
        cource['cource']['forced'] = false
        ProcessJson.write_data('app/data/cource_data.json', cource)
        cource = ParseCource.get_cource('https://cbr.ru/')
        ActionCable.server.broadcast 'cource_channel', cource: cource
        logger.info 'Perform force_update_cource_job'
    end

    private 
        def set_queue_data
            queue_data = ProcessJson.read_data('app/data/queue_data.json')
            queue_data['queue_step'] = get_queue_step(queue_data)
            job_data = { "date":"#{cource['cource']['date']}", "time":"#{cource['cource']['time']}"}
            add_job(queue_data, job_data)
            ProcessJson.write_data('app/data/queue_data.json')
        end

        def check_queue_step
            
        end

        # def get_queue_step(hash, new_job)
        # def delete_job(hash, remove_job)
        # def add_job(hash, new_job)
end
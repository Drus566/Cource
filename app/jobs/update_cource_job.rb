class UpdateCourceJob < ApplicationJob

    queue_as :low_priority
    after_perform :after_cource

    DELAY = 10.seconds
 
    def perform(*args)
        hash = ProcessJson.read_data('app/data/cource_data.json')
        
        if hash != nil
            if hash['cource'] != nil && hash['cource']['forced'] == false
                cource = ParseCource.get_cource('https://cbr.ru/')
                ActionCable.server.broadcast 'cource_channel', cource: cource
                puts "\n ~~~~~~~~~~~~~~~~~~~ UPDATE COURCE ~~~~~~~~~~~~~~~~~~~~~~\n\n"
            else 
                puts "\n ~~~~~~~~~~~~~~~~~~~ COURCE NOT UPDATE BECAUSE FORCED COURCE IS ACTIVE ~~~~~~~~~~~~~~~~~~\n\n"
            end
        end
    end

    private 
        def after_cource
            self.class.set(wait: DELAY).perform_later
        end
end
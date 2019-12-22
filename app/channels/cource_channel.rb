class CourceChannel < ApplicationCable::Channel
    def subscribed
       stream_from 'cource_channel'
    end

    def unsubscribed
    
    end
end
class ApplicationController < ActionController::Base
    require 'get_cource'
    
    protect_from_forgery with: :exception
    include DataHelper

    def home
        unless forced?
            get_cource 
        else
            forced_cource = ProcessJson.read_data('app/data/cource_data.json')
            @cource = forced_cource['cource']['value']
        end
    end

    def admin
        @forced_cource = ProcessJson.read_data('app/data/cource_data.json')
    end

    def force_update
        @forced_cource = cource_params
        if valid_value? && valid_date? && valid_time? 
            flash[:error] = ''
            flash.discard(:error)
            puts "~~~~~~~~~~~FLASH #{flash[:error].inspect}"
            time = Time.strptime(@forced_cource['cource']['time'], "%k:%M") 
            date = Date.strptime(@forced_cource['cource']['date'], '%d/%m/%Y')
            delay = get_wait_time(date, time)
            ForceUpdateCourceJob.set(wait: delay.seconds).perform_later(@forced_cource)
        end
    end

    private
        def get_cource
            @cource = ParseCource.get_cource('https://cbr.ru/')
        end

        def cource_params
            params.require(:cource).permit(cource: [:value, :date, :time, :forced])
        end     
end

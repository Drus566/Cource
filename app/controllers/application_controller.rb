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
        forced_value = @forced_cource['cource']['value']
        forced_date = @forced_cource['cource']['date']
        forced_time = @forced_cource['cource']['time']
        if valid_value?(forced_value) && valid_date?(forced_date) && valid_time?(forced_time, forced_date) 
            flash[:error] = ''
            flash.discard(:error)
            time = Time.strptime(forced_time, "%k:%M") 
            date = Date.strptime(forced_date, '%d/%m/%Y')
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

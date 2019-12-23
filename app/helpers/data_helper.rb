module DataHelper
    require 'process_json'

    def forced?
        forced = ProcessJson.read_data('app/data/cource_data.json') 
        forced['cource']['forced'] if forced != nil && forced['cource'] != nil  
    end

    def valid_value?
        value = @forced_cource['cource']['value'].to_s
        if value.empty? 
            flash[:error] = 'Value is empty' 
            false
        elsif value.size > 1 && value[0] == '0'  
            flash[:error] = 'Value is zero' 
            false
        elsif value.size == 1 && value[0] == '0'
            true
        elsif (value =~ /\A[0-9]+\.{0,1}\d{1,4}\z/) != 0
            flash[:error] = 'Value is not numeric' 
            false
        else
            true
        end
    end

    def valid_date? 
        date = @forced_cource['cource']['date'].to_s
        if date.empty?
            flash[:error] = 'Date is empty'
            false
        else 
            begin 
                valid_date = Date.strptime(date, "%d/%m/%Y")
                unless valid_date >= Date.today
                    flash[:error] = 'Date is not correct'
                    false
                else
                    true
                end
            rescue ArgumentError
                flash[:error] = 'Date is not valid'
                false
            end
        end
    end

    def valid_time?
        time = @forced_cource['cource']['time'].to_s
        date = @forced_cource['cource']['date'].to_s
        if time.empty?
            flash[:error] = 'Time is empty' 
            false
        else
            begin 
                valid_time = Time.strptime(time, "%k:%M")
                puts valid_time
                if Date.strptime(date, "%d/%m/%Y") == Date.today
                    unless valid_time > Time.now
                        flash[:error] = 'Time is not correct'
                        false
                    else
                        true
                    end
                else
                    true
                end
            rescue ArgumentError
                flash[:error] = 'Time is not valid'
                false
            end
        end
    end

    

    def get_wait_time(date, time)
        if date == Date.today
            delta_time = (time.to_i - Time.now.to_i)
        else
            delta_date = (date - Date.today).to_i * 24 * 60 * 60
            delta_time = (time.to_i - Time.now.to_i)
            delta = delta_date + delta_time
        end
    end    
end
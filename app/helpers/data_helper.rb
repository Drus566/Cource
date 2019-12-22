module DataHelper
    require 'process_json'

    # def write_json(path, temp_hash)
    #     ProcessJson.write_data(path, temp_hash)
    # end

    # def read_json(path)
    #     ProcessJson.read_data(path)
    # end

    def forced?
        forced = ProcessJson.read_data('app/data/cource_data.json') 
        forced['cource']['forced'] if forced != nil && forced['cource'] != nil  
    end

    def valid_date? 
        date = @forced_cource['cource']['date'].to_s
        unless date.empty?
            begin 
                Date.strptime(date, "%d/%m/%Y") >= Date.today
            rescue ArgumentError
                puts 'Date is not valid'
                # flash[:error] += "Date is not valid\n"
            end
        end
    end

    def valid_time?
        time = @forced_cource['cource']['time'].to_s
        date = @forced_cource['cource']['date']
        unless time.empty?
            if Date.strptime(date, "%d/%m/%Y") == Date.today
                Time.strptime(time, "%k:%M") > Time.now
            else
                begin
                    Time.strptime(time, "%k:%M") 
                rescue ArgumentError
                    puts 'Time is not valid'
                    # flash[:error] += "Time is not valid\n"
                end
            end
        end
    end

    def valid_value?
        value = @forced_cource['cource']['value'].to_s
        unless value.empty?
            value.delete(' ')
            regexp = value =~ /^\d+\.{0,1}\d{0,4}$/
            if regexp == 0 && value[0] == '0'
                (value.size == 1 && value[0] == '0') || (value[0] == '0' && value[1] == '.')
            elsif regexp == 0
                regexp
            else
                puts 'Value is not valid'
                # ошибка последовательность нулей не отлавливается
                # flash[:error] += "Value is not valid\n"
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
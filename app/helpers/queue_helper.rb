module QueueHelper
    # добавляем задание в очередь
    def add_job(hash, new_job)
        if hash["queue"] != nil
            hash["queue"] << new_job
        else
            hash["queue"] = [new_job]
        end
    end
    
    # удаляем задание из очереди
    def delete_job(hash, remove_job)
        if hash["queue"] != nil
            hash["queue"].each_with_index do |job, index|
                if job['date'] == remove_job[:date] && job['time'] == remove_job[:time]
                    hash["queue"].delete_at(index)
                end
            end
        end
    end

    # получаем необходимые шаги очереди для корректного выполнения задания force_update_cource
    def get_queue_step(hash, new_job)
        new_job_date = Date.strptime(new_job[:date], "%d/%m/%Y") 
        new_job_time = Time.strptime(new_job[:time], "%k:%M")
        queue_step = 0
        if hash["queue"] != nil && hash["queue"].size > 0
            hash["queue"].each do |job|
                job_time = Time.strptime(job['time'], "%k:%M")
                job_date = Date.strptime(job['date'], "%d/%m/%Y") 
                if new_job_date == job_date
                    queue_step = queue_step + 1 if new_job_time > job_time 
                elsif new_job_date > job_date
                    queue_step = queue_step + 1 
                end
            end
        end  
        queue_step
    end
end
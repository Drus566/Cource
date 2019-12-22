module QueueHelper
    def add_job(hash, new_job)
        if hash["queue"] != nil
            hash["queue"] << new_job
        else
            hash["queue"] = [new_job]
        end
    end

    def delete_job(hash, remove_job)
        if hash["queue"] != nil
            hash["queue"].each_with_index do |job, index|
                if job['date'] == remove_job[:date] && job['time'] == remove_job[:time]
                    hash["queue"].delete_at(index)
                    return "#{job} has been deleted"
                end
            end
            return "#{remove_job} not found"
        end
    end

    def get_queue_step(hash, new_job)
        new_job_date = Date.strptime(new_job[:date], "%d/%m/%Y") 
        new_job_time = Time.strptime(new_job[:time], "%k:%M")
        queue_step = 0
        if hash["queue"] != nil && hash["queue"].size > 0
            hash["queue"].each do |job|
                job_time = Time.strptime(job['time'], "%k:%M")
                job_date = Date.strptime(job['data'], "%d/%m/%Y") 
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
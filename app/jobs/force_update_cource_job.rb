class ForceUpdateCourceJob < ApplicationJob
    include QueueHelper

    queue_as :high_priority
    
    before_enqueue do |job|
        # получаем форсированный курс из аргументов задания
        cource = job.arguments.first
        puts "Forced cource in before_enqueue #{cource}"
        # записываем данные об очереди
        puts cource 
        set_queue_data(cource)
        # записываем форсированный курс
        ProcessJson.write_data('app/data/cource_data.json', cource)
        # делаем рассылку форсированного курса 
        ActionCable.server.broadcast 'cource_channel', cource: cource['cource']['value']
    end

    def perform(cource)
        queue_data = ProcessJson.read_data('app/data/queue_data.json')
        if queue_data['queue_step'].to_i > 0
            queue_data['queue_step'] = queue_data['queue_step'] - 1
        else
            # устанавливаем forced в false, чтобы фоновый скрипт смог периодически парсить курс
            cource['cource']['forced'] = false
            # записываем cource forced
            ProcessJson.write_data('app/data/cource_data.json', cource)
            # парсим курс
            parse_cource = ParseCource.get_cource('https://cbr.ru/')
            # делаем рассылку курса
            ActionCable.server.broadcast 'cource_channel', cource: parse_cource
        end
        data_job = job_data(cource)
        # data_job = job_data(cource)
        delete_job(queue_data, data_job)
        ProcessJson.write_data('app/data/queue_data.json', queue_data)
    end

    private 
        def set_queue_data(cource)
            # читаем очередь
            data_job = job_data(cource)
            queue_data = ProcessJson.read_data('app/data/queue_data.json')
            # устанавливаем шаг очереди для последнего задания
            queue_data['queue_step'] = get_queue_step(queue_data, data_job)
            # добавляем последнее задание в очередь
            add_job(queue_data, data_job)
            # записываем очередь в файл
            ProcessJson.write_data('app/data/queue_data.json', queue_data)
        end

        def job_data(cource)
            date = cource['cource']['date']
            time = cource['cource']['time']
            {"date": date, "time": time}
        end
end
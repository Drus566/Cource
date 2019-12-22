require 'json'

class ProcessJson
    def self.write_data(file_path, tempHash)
        data = tempHash.to_json
        File.write(file_path, data, mode: 'w')
    end

    def self.read_data(file_path)
        begin 
            JSON.parse(IO.read(file_path, encoding: 'utf-8'))
        rescue JSON::ParserError
            puts "JSON::ParserError, file path: '#{file_path}' not content json"
        rescue Errno::ENOENT
            puts "Errno::ENOENT, file path: '#{file_path}' not exist"
        end
    end
end
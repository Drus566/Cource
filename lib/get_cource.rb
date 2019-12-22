require 'nokogiri'
require 'open-uri'

class ParseCource
    def self.get_cource(url)
        doc = Nokogiri::HTML(open(url))
        cource = doc.css('.w_data_wrap')[0].text.strip
        cute_index = cource =~ /[0-9]/
        cource[0..cute_index - 1] = ''
        cource 
    end
end
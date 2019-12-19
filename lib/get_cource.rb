#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

class ParseCource
    
    doc = Nokogiri::HTML(open('https://cbr.ru/'))

    def self.get_cource 
        cource = doc.css('.w_data_wrap')[0].text.strip
        cute_index = cource =~ /[0-9]/
        cource[0..cute_index - 1] = ''
        cource 
    end
end
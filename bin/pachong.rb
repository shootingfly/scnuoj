require 'nokogiri'
require 'open-uri'

url = "http://poj.org/problem?id=1000"
doc = Nokogiri::HTML(open(url))
@time = doc.css(".plm td")[0].text[/\d+/] # time
@memory = doc.css(".plm td")[2].text[/\d+/] # memory
@description = doc.css(".pst")[0].next_element.text #description index
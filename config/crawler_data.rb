#encoding:utf-8
require File.expand_path('../environment.rb',__FILE__)
require File.expand_path('../../app/models/crawler',__FILE__)
require File.expand_path('../../app/models/lei_crawler',__FILE__)
require_relative '../app/models/crawler.rb'
require_relative '../app/models/lei_crawler.rb'
if r_index = $*.index("-r")
  $*.delete_at(r_index)
  curr_rtb = $*.delete_at(r_index)
else
  curr_rtb = 'false'
end

case curr_rtb
when "youku"
	Crawler.save_datas
when "leida"
	LeiCrawler.save_leida_data
else
	puts "please enter spider web ‘youku’、'leida' ....."
end
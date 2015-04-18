#! /usr/bin/env ruby

require 'simple-rss'
# require 'rss'
require 'open-uri'

puts '=== get appstore rank ==='

countries = [ 'kr', 'us', 'jp', 'uk', 'cn', 'hk' ]
feed_types = [ 'topfreeapplications', 'topmacapps', 'topfreemacapps', 'toppaidmacapps' ]
# 10,25,50,100
limit = 100

url_prefix = 'https://itunes.apple.com/'
date = Time.new.strftime("%Y-%m-%d")

countries.each do |country|

  url = "#{url_prefix}/#{country}/rss/#{feed_types[0]}/limit=#{limit}/xml"
  # rss = RSS::Parser.parse(url)
  rss = SimpleRSS.parse open(url)
  # puts rss
  output = File.open("output_#{country}_#{date}.md", "w")

  puts "Title: #{rss.title}" 
  output << "### #{rss.title} \n"
  cnt = 0

  rss.entries.each do |entry|
    cnt = cnt + 1
    puts "#{cnt.to_s.rjust(3)} #{entry.title}"
    output << "#{cnt.to_s}. [#{entry.title}](#{entry.link})\n"
  end

  output.close

end


puts '=== end ==='

MINE_NAME_KEYWORDS = ["project","mine","deposit","gold","area","ore","body"]


require 'rubygems'
require  'safe_attributes/base'
gem 'activerecord'
require 'yaml'
require 'active_record'
require 'csv'


require File.join('.', 'connection.rb')
require File.join('./lib', 'minerals_entity_attribute.rb')
require File.join('./lib', 'entity.rb')
require File.join('./lib', 'drillhole.rb')
require File.join('./lib', 'sample.rb')

def read_borehole_attributes
  borehole_atrributes = MineralsEntityAttribute.deposit_find

  borehole_atrributes.each do |ba|
    name = ba.text_value
    check_deposit_name(name)
  end
  
end

def check_deposit_name(name)
  ACRONYMS.keys.include?(name) ? name = ACRONYMS[name] : 
  if name.length < 3
    puts "Name '#{name}' too short to query"
    return 
  end
  if GENERIC_KEYWORDS.include?(name)
    puts "Name '#{name}' too generic to query"
    return 
  end
  puts "Looking for company with name \"#{name}\" ..."
  companies=Company.by_name(name)
  case companies.size
  when 0
    companies = Array.new
    if name.include?("JV")
      puts "Company #{name} is a joint venture"
      name = name.split(/JV/).map{|s| s.strip}
    else
      name = name.split(/ /) 
    end
    if name.size > 1
      name.each do |n|
        companies << check_company_name(n)
      end
    else
      puts "No companies found"
      return companies
    end
    return companies.compact # compact removes nils returned from recursive searches
  when 1
    puts "Found #{companies.first.company_name} for #{name}"
    return companies
  else
    puts "Company: #{name} returns two or more companies"
    companies.each_with_index do |company,i|
      puts "(#{i}) #{company.company_name}"
    end
    return companies
  end
  
end
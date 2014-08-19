MINE_NAME_KEYWORDS = ["project","mine","deposit","gold","area","ore","body","wall"]

require 'irb/completion'

require 'rubygems'
require  'safe_attributes/base'
gem 'activerecord'
require 'yaml'
require 'ruby_nlp/ngram'
require 'active_record'
require 'csv'


require File.join('.', 'connection.rb')
require File.join('./lib', 'minerals_entity_attribute.rb')
require File.join('./lib', 'entity.rb')
require File.join('./lib', 'deposit.rb')
require File.join('./lib', 'drillhole.rb')
require File.join('./lib', 'sample.rb')

def read_borehole_attributes
  borehole_atrributes = MineralsEntityAttribute.deposit_find
  attr_list = borehole_atrributes.pluck(:text_value).uniq
  attr_list.each do |al|
    puts "Searching string '#{al}' ..."
    text=al.gsub(/\W+/,' ').strip
    ngram = Ngram.new(al.gsub /'/, "''") #ORACLE ESCAPE SINGLE QUOTE
    deposit = check_deposit_name(ngram)
	  unless deposit.nil?
	    puts "#{al} ::: #{deposit.inspect}"
	  end
  end  
end

def check_deposit_name(text,n=1)
  ngrams = text.ngrams(n)
  ngrams.each do |ng|
    case n
    when 1
      name = ng[0]
	  puts name
    when 2
      name = "#{ng[0]} #{ng[1]}"
    else
	  puts "Am i Here?"
      return nil
    end
    deposits=Deposit.by_name(name)
	  puts "Found #{deposits.size} deposit(s)"
    case deposits.size
    when 1
      return deposits.first.eno
    else 
	     puts n
      check_deposit_name(text,n+1)
    end  
  end
  
end
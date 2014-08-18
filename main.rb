MINE_NAME_KEYWORDS = ["project","mine","deposit","gold","area","ore","body","wall"]


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
    puts al
    text = Ngram.new(al.gsub /'/, "\\\\'")
    check_deposit_name(text)
  end
  
end

def check_deposit_name(text,n=1)

  ngrams = text.ngrams(n)
  
  ngrams.each do |ng|
    case n
    when 1
      name = ng[0]
      deposits=Deposit.by_name(name)
      case deposits.size
      when 1
      else 
        check_deposit_name(text,2)
      end  
    when 2
      name = "#{ng[0]} #{ng[1]}"
      deposits=Deposit.by_name(name)
    end
  end
  
end
class Sample < ActiveRecord::Base
    self.table_name = "a.samples"
  
  belongs_to :drillhole, :foreign_key => :eno
	
end
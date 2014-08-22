class Drillhole < Entity

  has_many :mineral_entity_attributes, :foreign_key => :eno



  def self.default_scope
    where(:entity_type => 'DRILLHOLE')
  end
  
  def self.by_name(name)
    #return self.joins(:deposit_status).where("upper (entityid) like upper('%#{name}%') or upper(synonyms) like upper('%#{name}%')")
	where("upper (entityid) like upper('%#{name}%')")
  end
  
  def self.find_duplicates
  
  end
	
end
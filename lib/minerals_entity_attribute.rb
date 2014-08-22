class MineralsEntityAttribute < ActiveRecord::Base
  include SafeAttributes::Base
  self.table_name = "mgd.entity_attribs"
  self.primary_key = :eno
  
  belongs_to :drillhole, :foreign_key => :eno

  set_date_columns :entrydate, :qadate, :lastupdate, :effective_date, :acquisition_date, :expiry_date
  
  def self.deposit_find
    return self.bring_me_the_head_of_paul_mccartney_on_heather_mills_wooden_peg
  end
  
  def self.bring_me_the_head_of_paul_mccartney_on_heather_mills_wooden_peg
    where("text_value in ('CALLIE GOLD MINE','Callie deposit','Callie gold mine','Dead Bullock Soak','Ellendale',
'Endeavour 39','Endeavour 42 (Lake Cowal)','Endeavour 43','Endeavour 46','Endeavour-42 (Lake Cowal)',
'Endeavour-42 (Lake Coweal)','Endeavour-42 gold prospect','Endeavour-46 (Lake Cowal)',
'Que River Mine','Vicinity of Endeavour-39',
'Wilcherry Hill Prospect - Weednanna 00WDDH5','0.5 km E of Ranger 63 mine','0.5 km W of Faded Lily mine',
'200 m NE Anchor mine','Aberfoyle mine','Anchor mine','Boddington gold mine','Evelyn mine','Moonta mine',
'Moonta mines','Mount Diamond mine','Mount Todd mine','Ranger mine',
'Withnell deposit','Bullakitchee deposit','Callie deposit','Carbine deposit','Century deposit, Mitten Creek Prospect',
'Coyote deposit','Dogbolter deposit','Earnest Henry deposit','Gold Reef deposit',
'Goldrush deposit','Groundrush deposit','Huntswoman deposit',
'Shoe deposit','near Namarlangi U deposit')
or text_value like 'Tanami %'
or text_value like 'Olympic Dam%'
or text_value like 'Menninnie Dam%'
or text_value like 'The Granite%district'
or text_value like 'Woodlawn mine%'
or text_value like 'Nabarlek mine%'
or text_value like 'Gold Reef deposit%'
or text_value like 'Jim%Find deposit'")
  end
end

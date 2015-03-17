class Recipe < ActiveRecord::Base
  belongs_to :user

  def self.ricette_settimanali
#   inizio_settimana = Date.new(2015,03,16)
#   fine_settimana = Date.new(2015,03,23)
    ricette_settimanali = Recipe.where("created_at <= ?", 1.hour.ago)
#    ricette_settimanali = Recipe.where("created_at >= :inizio and created_at <= :fine", {inizio: inizio_settimana, fine: fine_settimana}).all
    ricette_settimanali = ricette_settimanali.shuffle[0..2]
  end

  def self.ricetta_della_settimana
    Recipe.last
  end

end

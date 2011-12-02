#Relationship model and associated information
class Relationship < ActiveRecord::Base
	#Model for the relationship class
  attr_accessible :cheqed_id
  attr_accessible :match

  belongs_to :cheqer, :class_name => "User"
  belongs_to :cheqed, :class_name => "User"

  #Validates both cheqer and cheqed id
  validates :cheqer_id, :presence => true
  validates :cheqed_id, :presence => true
end
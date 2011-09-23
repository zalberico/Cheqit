class Relationship < ActiveRecord::Base
  attr_accessible :cheqed_id

  belongs_to :cheqer, :class_name => "User"
  belongs_to :cheqed, :class_name => "User"

  validates :cheqer_id, :presence => true
  validates :cheqed_id, :presence => true
end

class Relationship < ActiveRecord::Base
  attr_accessible :cheqed_id

  belongs_to :cheqer, :class_name => "User"
  belongs_to :cheqed, :class_name => "User"
  belongs_to :match,  :class_name => "User" #Added for matching

  validates :cheqer_id, :presence => true
  validates :cheqed_id, :presence => true
  validates :match,     :presence => true #Added to validate matching
end

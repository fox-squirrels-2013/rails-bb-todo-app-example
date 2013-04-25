class List < ActiveRecord::Base

  # Cascading delete is handled at the db level
  has_many :todos

  # ---

  attr_accessible :name
  validates :name,
    :presence => { :message => 'cant_be_blank' }

end

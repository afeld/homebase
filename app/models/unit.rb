class Unit < ActiveRecord::Base
  attr_accessible :building_id, :number
  has_many :users
  belongs_to :building
end

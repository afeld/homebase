class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile_number, :unit_id
  belongs_to :building
  has_many :units
end

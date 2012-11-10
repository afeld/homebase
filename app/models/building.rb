class Building < ActiveRecord::Base
  attr_accessible :city, :country, :lat, :lng, :name, :state, :street, :street_number, :zip
  has_many :units
  has_many :users, through: :users 
end

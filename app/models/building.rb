# == Schema Information
#
# Table name: buildings
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  street_number :string(255)
#  street        :string(255)
#  city          :string(255)
#  state         :string(255)
#  zip           :integer
#  country       :string(255)
#  lat           :float
#  lng           :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Building < ActiveRecord::Base
  attr_accessible :city, :country, :lat, :lng, :name, :state, :street, :street_number, :zip
  has_many :units
  has_many :users, through: :users 
end

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
#  zip           :string(255)
#  country       :string(255)
#  lat           :float
#  lng           :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Building < ActiveRecord::Base
  attr_accessible :city, :country, :lat, :lng, :name, :state, :street, :street_number, :zip

  has_many :units, dependent: :destroy
  has_many :users, through: :units

  validate :state, length: 2

  geocoded_by :address
  reverse_geocoded_by :lat, :lng
  after_validation :geocode, :reverse_geocode


  def address
    # match Geocoder::Result::Google#formatted_address
    "#{street_number} #{street}, #{city}, #{state} #{zip}, #{country}"
  end

  def message_all text, from
    self.users.without(from).each do |user|
      Telapi::Message.create(user.mobile_number, TEL_NUMBER, text)
    end
  end

  class << self
    def new_from_text text
      result = Geocoder.search(text).first

      if result
        Building.new(
          street_number: result.address_components_of_type(:street_number).first['short_name'],
          street: result.address_components_of_type(:route).first['short_name'],
          city: result.city,
          state: result.state_code,
          zip: result.postal_code,
          country: result.country_code,
          lat: result.latitude,
          lng: result.longitude
        )
      else
        nil
      end
    end
  end
end

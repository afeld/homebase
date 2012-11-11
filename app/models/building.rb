# == Schema Information
#
# Table name: buildings
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  street     :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  country    :string(255)
#  lat        :float
#  lng        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Building < ActiveRecord::Base
  attr_accessible :city, :country, :lat, :lng, :name, :state, :street, :zip

  has_many :units, dependent: :destroy
  has_many :users, through: :units

  validates_presence_of :street, :city, :state, :zip, :country, :lat, :lng

  # geocoded_by :address
  # reverse_geocoded_by :lat, :lng
  # after_validation :geocode, :reverse_geocode


  def address
    # match Geocoder::Result::Google#formatted_address
    "#{street}, #{city}, #{state} #{zip}, #{country}"
  end

  class << self
    def new_from_result result
      # find existing building by street+zip
      building = self.find_or_initialize_by_street_and_zip(
        result.address_data['addressLine'], # Bing-specific
        result.postal_code
      )

      building.update_attributes(
        city: result.city,
        state: result.state_code,
        country: result.country_code,
        lat: result.latitude,
        lng: result.longitude
      )

      building
    end
  end
end

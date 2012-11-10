# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  building_id :integer
#  number      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Unit < ActiveRecord::Base
  attr_accessible :building_id, :number
  has_many :users, dependent: :nullify
  belongs_to :building
  
  
  class << self
    def create_from_result result
      unit_num = result.address_components_of_type(:subpremise).first['short_name']
      if unit_num
        building = Building.create_from_result(result)
        Unit.create!(
          building: building,
          number: unit_num
        )
      else
        nil
      end
    end
  end
end

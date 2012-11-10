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
end

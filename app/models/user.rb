# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  unit_id       :integer
#  first_name    :string(255)
#  last_name     :string(255)
#  mobile_number :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  active        :boolean
#

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile_number, :unit_id
  belongs_to :unit
  has_one :building, through: :unit

  scope :without, lambda { |user| where('id <> ?', user.id) }


  def disable!
    self.active = false
    self.save
  end
  
  def enable!
    self.active = true
    self.save
  end
  
  def active?
    self.active = true
    self.save
  end
  
  def message_building text
    Telapi::InboundXml.new do
      self.building.users.without(self).each do |user|
        Sms(
          text,
          from: TEL_NUMBER,
          to: user.mobile_number
        )
      end
    end
  end
  
  def message_unit unit_num, text
    # TODO fuzzy match?
    unit = self.building.units.where(number: unit_num).first
    # TODO handle no match

    Telapi::InboundXml.new do
      unit.users.without(self).each do |user|
        puts user.mobile_number
        puts user.mobile_number.class
        Sms(
          text,
          from: TEL_NUMBER,
          to: user.mobile_number
        )
      end
    end
  end
    
end

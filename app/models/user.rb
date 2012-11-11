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
  belongs_to :last_message_dm_from, class_name: 'User'

  scope :without, lambda { |user| where('users.id <> ?', user.id) }


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
    text = "##{self.unit.number}: #{text}"
    users = self.building.users.without(self)
    Telapi::InboundXml.new do
      users.each do |u|
        u.last_message_dm_from = nil
        u.save!

        Sms(
          text,
          from: TEL_NUMBER,
          to: u.mobile_number
        )
      end
    end
  end
  
  def message_unit unit_num, text
    # TODO fuzzy match?
    unit = self.building.units.find_by_number(unit_num)
    # TODO handle no match

    text = "DM ##{self.unit.number}: #{text}"

    me = self
    users = unit.users.without(self)
    Telapi::InboundXml.new do
      users.each do |u|
        u.last_message_dm_from = me
        u.save!

        Sms(
          text,
          from: TEL_NUMBER,
          to: u.mobile_number
        )
      end
    end
  end
    
end

# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  unit_id                 :integer
#  first_name              :string(255)
#  last_name               :string(255)
#  mobile_number           :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  active                  :boolean
#  last_message_dm_from_id :integer
#

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile_number, :unit_id, :last_message_dm_from, :last_message_dm_from_id
  belongs_to :unit
  has_one :building, through: :unit
  belongs_to :last_message_dm_from, class_name: 'User'

  scope :without, lambda { |user| where('users.id <> ?', user.id) }


  def full_name
    # handles where one is missing
    [self.first_name, self.last_name].join(' ')
  end

  def full_name=(full)
    split_name = full.split
    self.last_name = split_name.pop
    self.first_name = split_name.join(' ')
  end

  def name_with_initial
    initial = self.last_name.to_s[0]
    if initial
      "#{self.first_name} #{initial}."
    else
      self.first_name
    end
  end

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
    text = "#{self.name_with_initial} (##{self.unit.number}): #{text}"

    users = self.building.users.without(self)
    users.update_all last_message_dm_from_id: nil

    Telapi::InboundXml.new do
      users.each do |u|
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

    text = "DM from #{self.name_with_initial} (##{self.unit.number}): #{text}"

    users = unit.users.without(self)
    users.update_all last_message_dm_from_id: self.id

    Telapi::InboundXml.new do
      users.each do |u|
        Sms(
          text,
          from: TEL_NUMBER,
          to: u.mobile_number
        )
      end
    end
  end
    
end

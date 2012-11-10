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

end

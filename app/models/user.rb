class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile_number, :unit_id, :active
  belongs_to :building
  has_many :units
  
  def self.active_users
    find :all, :conditions => ['active = ?', true]
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
  
end

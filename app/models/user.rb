class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :mobile_number, :unit_id
end

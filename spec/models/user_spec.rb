# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  unit_id       :integer
#  first_name    :string(255)
#  last_name     :string(255)
#  mobile_number :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end

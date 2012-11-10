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

require 'spec_helper'

describe Unit do
  pending "add some examples to (or delete) #{__FILE__}"
end

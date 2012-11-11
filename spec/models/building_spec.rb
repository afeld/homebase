# == Schema Information
#
# Table name: buildings
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  street     :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  country    :string(255)
#  lat        :float
#  lng        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Building do
  pending "add some examples to (or delete) #{__FILE__}"
end

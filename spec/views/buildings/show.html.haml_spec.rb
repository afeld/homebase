require 'spec_helper'

describe "buildings/show" do
  before(:each) do
    @building = assign(:building, stub_model(Building,
      :name => "Name",
      :street_number => "Street Number",
      :street => "Street",
      :city => "City",
      :state => "State",
      :zip => 1,
      :country => "Country",
      :lat => 1.5,
      :lng => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Street Number/)
    rendered.should match(/Street/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/1/)
    rendered.should match(/Country/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
  end
end

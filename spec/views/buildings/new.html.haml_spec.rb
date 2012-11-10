require 'spec_helper'

describe "buildings/new" do
  before(:each) do
    assign(:building, stub_model(Building,
      :name => "MyString",
      :street_number => "MyString",
      :street => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => 1,
      :country => "MyString",
      :lat => 1.5,
      :lng => 1.5
    ).as_new_record)
  end

  it "renders new building form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => buildings_path, :method => "post" do
      assert_select "input#building_name", :name => "building[name]"
      assert_select "input#building_street_number", :name => "building[street_number]"
      assert_select "input#building_street", :name => "building[street]"
      assert_select "input#building_city", :name => "building[city]"
      assert_select "input#building_state", :name => "building[state]"
      assert_select "input#building_zip", :name => "building[zip]"
      assert_select "input#building_country", :name => "building[country]"
      assert_select "input#building_lat", :name => "building[lat]"
      assert_select "input#building_lng", :name => "building[lng]"
    end
  end
end

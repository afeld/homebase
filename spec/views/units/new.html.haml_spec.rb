require 'spec_helper'

describe "units/new" do
  before(:each) do
    assign(:unit, stub_model(Unit,
      :building_id => 1,
      :number => "MyString"
    ).as_new_record)
  end

  it "renders new unit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => units_path, :method => "post" do
      assert_select "input#unit_building_id", :name => "unit[building_id]"
      assert_select "input#unit_number", :name => "unit[number]"
    end
  end
end

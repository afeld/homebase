require 'spec_helper'

describe "units/index" do
  before(:each) do
    assign(:units, [
      stub_model(Unit,
        :building_id => 1,
        :number => "Number"
      ),
      stub_model(Unit,
        :building_id => 1,
        :number => "Number"
      )
    ])
  end

  it "renders a list of units" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
  end
end

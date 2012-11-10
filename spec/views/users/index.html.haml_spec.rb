require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :unit_id => 1,
        :first_name => "First Name",
        :last_name => "Last Name",
        :mobile_number => 2
      ),
      stub_model(User,
        :unit_id => 1,
        :first_name => "First Name",
        :last_name => "Last Name",
        :mobile_number => 2
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

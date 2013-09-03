require 'spec_helper'

describe "repositories/show" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end

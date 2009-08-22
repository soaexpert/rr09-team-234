require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Event do
  before(:each) do
    @valid_attributes = {
      :label => "",
      :name => "",
      :description => "",
      :date => Time.now,
      :hits => 0
    }
  end


end

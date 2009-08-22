require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do

  before(:each) do
    @event = mock_model(Event)
    @date = Time.now
    Time.stub!(:now).and_return(@date)
  end

  it "should show the next and past events when at home" do
    Event.should_receive(:find).with(:all, {:limit=>7, :order=>"date ASC", :conditions=>["date >= ?", @date]}).and_return([@event])
    Event.should_receive(:find).with(:all, {:limit=>7, :order=>"date DESC", :conditions=>["date < ?", @date]}).and_return([@event])
    get 'index'
  end

end

require 'spec_helper'

describe Relationship do
  
  before(:each) do
    @cheqer = Factory(:user)
    @cheqed = Factory(:user, :email => Factory.next(:email))

    @relationship = @cheqer.relationships.build(:cheqed_id => @cheqed.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end
  

  describe "cheq methods" do
    
    before(:each) do
      @relationship.save
    end
    
    it "should have a cheqer attribute" do
      @relationship.should respond_to(:cheqer)
    end
    
    it "should have the right cheqer" do
      @relationship.cheqer.should == @cheqer
    end
    
    it "should have a cheqed attribute" do
      @relationship.should respond_to(:cheqed)
    end
    
    it "should have the right followed user" do
      @relationship.cheqed.should == @cheqed
    end
  end

  describe "validations" do
    
    it "should require a cheqer_id" do
      @relationship.cheqer_id = nil
      @relationship.should_not be_valid
    end

    it "should require a cheqed_id" do
      @relationship.cheqed_id = nil
      @relationship.should_not be_valid
    end
  end
end

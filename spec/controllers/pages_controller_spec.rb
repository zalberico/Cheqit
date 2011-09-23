require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Cheqit"
  end

  describe "GET 'home'" do

    describe "when not signed in" do
     
      before(:each) do
        get :home
      end
      
      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector("title", 
                                      :content => @base_title)
      end
    end

    describe "when signed in" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.cheq!(@user)
      end
      
      it "should have the right cheqed counts" do
        get :home
        response.should have_selector("a", :href => cheqeds_user_path(@user),
                                           :content => "0 cheqs")
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", 
                                    :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title", 
                                    :content => @base_title + " | About")
    end
  end

  describe "Get 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", 
                                    :content => @base_title + " | Help")
    end
  end
end

class PagesController < ApplicationController
  #Defines titles for static pages.
  def home
  end

  def contact
    @title = "contact us"
  end

  def about
    @title = "about us"
  end

  def help
    @title = "help"
  end
end

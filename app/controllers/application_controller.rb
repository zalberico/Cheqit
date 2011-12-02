class ApplicationController < ActionController::Base
   #Protects from forgery
  protect_from_forgery
  include SessionsHelper
end

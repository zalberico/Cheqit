class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:cheqed_id])
    current_user.cheq!(@user)
    if(@user.match?(current_user))
      current_user.match!(@user)
    end
    @user.match!(current_user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    #Need code here to check for a match and update match value in table
    #if current_user.cheqed?(@user)
      #match!(@user)
      #usermatch = User.find(params[:relationship][:cheqed_id])
      #usermatch.update_attributes( match => true )
  end

  def destroy
    @user = Relationship.find(params[:id]).cheqed
    current_user.uncheq!(@user)
    if(@user.match?(current_user))
      @user.unmatch!(current_user)
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  #Need code here to set remove match value or set it to zero.
  #unmatch!(@user)
end
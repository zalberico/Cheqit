class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:cheqed_id])
    current_user.cheq!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    #Need code here to check for a match and update match value in table
  end

  def destroy
    @user = Relationship.find(params[:id]).cheqed
    current_user.uncheq!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  #Need code here to set remove match value or set it to zero.
end
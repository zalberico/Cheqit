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
  end

  def destroy
    @user = Relationship.find(params[:id]).cheqed
    current_user.uncheq!(@user)
    @user.unmatch!(current_user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
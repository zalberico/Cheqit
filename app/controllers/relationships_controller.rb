class RelationshipsController < ApplicationController
  before_filter :authenticate

#When relationships are created check to see if it makes a match
  def create
    @user = User.find(params[:relationship][:cheqed_id])
    current_user.cheq!(@user)
    @user.match!(current_user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
  end
    if(@user.match?(current_user))
      current_user.match!(@user)
      UserMailer.match_email(@user, current_user).deliver
      UserMailer.match_email(current_user, @user).deliver
    end
  end

#Destroy the relationship in the database and unmatch an associated relationships.
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
end
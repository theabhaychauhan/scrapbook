class FriendshipsController < ApplicationController
  def create
    member = Member.find_by(id: params["member"])
    @friendship = member.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      member = Member.find_by(id: params["friend_id"])
      @friendship = member.friendships.build(:friend_id => params[:member])
      @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Error occurred when adding friend."
    end
  end

  def destroy
    member = Member.find_by(id: params["member"])
    @friendship = member.friendships.find(params[:friendship])
    friend = member.friendships.find(params[:friendship]).friend_id
    @friendship.destroy
    flash[:notice] = "Successfully destroyed friendship."
    redirect_to root_url
  end
end

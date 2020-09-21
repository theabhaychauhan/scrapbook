class FriendshipsController < ApplicationController
  def create
    byebug
    member = Member.find_by(id: params["member"])
    @friendship = member.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      member = Member.find_by(id: params["friend_id"])
      @friendship = member.friendships.build(:friend_id => params[:member])
      @friendship.save
      flash[:notice] = "Friend Added."
      redirect_back(fallback_location: "show")
    else
      flash[:error] = "Error occurred when adding Friend."
    end
  end

  def destroy
    member = Member.find_by(id: params["member"])
    @friendship = member.friendships.find(params[:friendship])
    friend = member.friendships.find(params[:friendship]).friend_id
    @friendship.destroy
    flash[:notice] = "Unfriended."
    redirect_back(fallback_location: "show")
  end
end

class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[accept_request decline_request block_request destroy]

  def index
    @user = current_user
    @friendships = Friendship.where(user: @user)
  end

  def send_request
    @user = current_user
    @friend = User.find(params[:friend_id])
    @friendship = Friendship.new(user: @user, friend_of: @friend)
    if @friendship.save
      flash[:notice] = "Une demande d'ami a été envoyée à #{@friend.first_name} #{@friend.last_name}"
    else
      flash[:alert] = "La demande d'ami n'a pas pu être envoyée"
    end
  end

  def accept_request
    @friendship.status = "accepted"
    if @friendship.save
      flash[:notice] = "La demande d'ami a été acceptée"
    else
      flash[:alert] = "La demande d'ami n'a pas pu être acceptée"
    end
  end

  def decline_request
    @friendship.status = "declined"
    if @friendship.save
      flash[:notice] = "La demande d'ami a été refusée"
    else
      flash[:alert] = "La demande d'ami n'a pas pu être refusée"
    end
  end

  def block_request
    @friendship.status = "blocked"
    if @friendship.save
      flash[:notice] = "La demande d'ami a été bloquée"
    else
      flash[:alert] = "La demande d'ami n'a pas pu être bloquée"
    end
  end

  def destroy
    if @friendship.destroy
      flash[:notice] = "La demande d'ami a été supprimée"
    else
      flash[:alert] = "La demande d'ami n'a pas pu être supprimée"
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_of_id, :status)
  end
end

class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[accept_request decline_request block_request destroy]

  def index
    @user = current_user
    # Requête pour récupérer les identifiants des utilisateurs avec lesquels current_user a une relation d'amitié

    @friends = @user.friends
    @not_friends = @user.not_friends

    @pending_friendships = @user.pending_friendships
    @pending_requests_sent = @user.pending_friendships_sent
    # @blocked_requests = Friendship.where(user: @user, status: "blocked")
  end

  def send_request
    @user = current_user
    @friend = User.find(params[:user_id])
    @friendship = Friendship.new(user: @user, friend_of: @friend)
    if @friendship.save
      redirect_to friendships_path, notice: "Une demande d'ami a été envoyée à #{@friend.first_name} #{@friend.last_name}"
    else
      redirect_to friendships_path, alert: "La demande d'ami n'a pas pu être envoyée"
    end
  end

  def accept_request
    @friendship.status = "accepted"
    if @friendship.save
      redirect_to friendships_path, notice: "La demande d'ami a été acceptée"
    else
      flash[:alert] = "La demande d'ami n'a pas pu être acceptée"
    end
  end

  def decline_request
    @friendship.status = "declined"
    if @friendship.save
      redirect_to friendships_path, notice: "La demande d'ami a été refusée"
    else
      redirect_to friendships_path, alert: "Erreur lors du refus de la demande d'ami"
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
      redirect_to friendships_path, notice: "La demande d'ami a été supprimée"
    else
      redirect_to friendships_path, alert: "La demande d'ami n'a pas pu être supprimée"
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

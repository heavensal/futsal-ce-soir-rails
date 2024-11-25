class PlayersController < ApplicationController

  def update
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:team_id])
    @user = current_user
    # si le joueur est déjà dans une équipe différente de @team, on le fait changer d'équipe
    # si il n'a pas d'équipe, il rejoint @team

    @player = Player.find_or_initialize_by(user_id: @user.id, event_id: @event.id)
    @player.team = @team
    if @player.save
      redirect_to event_path(@event), notice: "Vous avez bien rejoint l'équipe #{@team.name}."
    else
      render :edit, alert: "Erreur lors de la modification du joueur."
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @event = @player.event
    if @player.destroy
      redirect_to event_path(@event), notice: "Vous avez bien quitté l'équipe."
    else
      redirect_to event_path(@event), alert: "Erreur lors de la sortie de l'équipe."
    end
  end
end

class TeamsController < ApplicationController
  def edit
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to event_path(@team.event), notice: "L'équipe a bien été modifiée"
    else
      render :edit, alert: "Erreur lors de la modification de l'équipe."
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end

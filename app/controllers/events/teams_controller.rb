class Events::TeamsController < ApplicationController
  before_action :set_team, only: [ :edit, :update ]
  def edit
  end

  def update
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

  def set_team
    @team = Team.find(params[:id])
  end
end

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = Event.includes(:players).all
  end

  def show
    @team_1 = @event.teams.first
    @team_2 = @event.teams.second
    @bench = @event.teams.third
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = User.first # TODO: change this to current_user
    if @event.save
      redirect_to @event, notice: "L'événement a bien été créé"
    else
      render :new, alert: "Erreur lors de la création de l'événement."
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "L'événement a bien été modifié"
    else
      render :edit, alert: "Erreur lors de la modification de l'événement."
    end
  end

  def destroy # TODO: add a confirmation dialog
    if @event.destroy
      redirect_to events_path, notice: "L'événement a bien été supprimé"
    else
      redirect_to @event, alert: "L'événement n'a pas pu être supprimé."
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :start_time, :price_per_player, :privacy, :number_of_players)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end

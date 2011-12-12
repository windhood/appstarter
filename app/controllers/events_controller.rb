class EventsController < ApplicationController
  def index
    @events = Event.generate_test_data
  end

  def show
    @event = Event.find_test_data(params[:id])
  end

end

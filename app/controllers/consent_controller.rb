class ConsentController < ApplicationController

  def index
    if current_participant.nil?
      redirect_to "/login"
    end
  end
  
  def create
    if params[:consent].nil?
      current_participant.consent = true
    end

    if current_participant.save
      redirect_to current_participant
    else
      render :action => :index
    end
  end
end
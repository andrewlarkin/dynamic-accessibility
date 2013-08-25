class ParticipantSessionsController < ApplicationController

  def new
    @participant_session = ParticipantSession.new
  end
  
  def create
    @participant_session = ParticipantSession.new(params[:participant_session])
    if @participant_session.save
      flash[:notice] = "Login successful!"
      redirect_to @participant_session.participant
    else
      render :action => :new
    end
  end
  
  def destroy
    current_participant_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to "/login"
  end
end

class ParticipantSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @participant_session = ParticpantSession.new
  end
  
  def create
    @participant_session = ParticpantSession.new(params[:participant_session])
    if @participant_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_particpant_session_url
  end
end

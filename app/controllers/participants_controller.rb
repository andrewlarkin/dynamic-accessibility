class ParticipantsController < ApplicationController

  def index
    @participant = Participant.new
  end

  def show
    if current_participant.nil?
      redirect_to "/login"
    end

    begin
      @participant = Participant.find(params[:id])

      if @participant != current_participant
        redirect_to current_participant
      elsif !@participant.consent
        redirect_to edit_participant_path(@participant.id)
      end

      @tasks = Task.all
    rescue
      redirect_to current_participant
    end

  end

  def create
    participant_params

    begin
      @participant = Participant.new(params[:participant])

      respond_to do |format|
        if @participant.save
          format.html { redirect_to @participant, :notice => 'You have been successfully registered.' }
          format.js   {}
          format.json { render :json => @participant, :status => :created, :location => @participant }
        else
          format.html { render :action => "index" }
          format.json { render :json => @participant.errors, :status => :unprocessable_entity }
        end
      end
    rescue
      redirect_to "/register"
    end
  end

  def toggle_consent
    @participant = Participant.find(params[:id])
    @participant.toggle!(:consent)

    respond_to do |format|
      flash[:success] = "You have confirmed your consent."
      format.html { redirect_to @participant }
      format.js
    end
  end

  def edit
    if current_participant.nil?
      redirect_to "/login"
    elsif !current_participant.is_selected || current_participant.consent
      redirect_to current_participant
    end

    begin
      @participant = Participant.find(params[:id])

      if @participant != current_participant
        redirect_to edit_participant_path(current_participant.id)
      elsif !@participant.is_selected || @participant.consent
        redirect_to @participant
      end
    rescue
      redirect_to edit_participant_path(current_participant.id)
    end

  end

  private
  def participant_params
    params.require(:participant).permit!
  end
end

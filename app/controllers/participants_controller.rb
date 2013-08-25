class ParticipantsController < ApplicationController

  def index
    @participant = Participant.new
  end

  def show
    if current_participant.nil?
      redirect_to "/login"
    end

    @participant = Participant.find(params[:id])

    if @participant != current_participant
      redirect_to current_participant
    end

    @task_sets = TaskSet.all
  end

  def create
    participant_params

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
  end

  private
  def participant_params
    params.require(:participant).permit!
  end
end

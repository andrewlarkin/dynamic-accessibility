require 'yaml'

class TasksController < ApplicationController

  def show
    if current_participant.nil?
      redirect_to "/login"
    else
      @task = Task.find(params[:id])

      #TODO: get user's skill level
      @level = 4

      # complete = @task.completed_tasks.where( { :participant_id => current_participant.id } ).length
      @current_activity = 3

      @task_info = YAML.load_file('public/tasks/task_' + @task.id.to_s + '.yaml')

      @activity = @task_info['activities'][@current_activity]
    end
  end

  def update
   
    if !current_participant.nil?

       # call method to process results and update user's data

      completed_task = CompletedTask.new({ 
        :participant_id => current_participant.id,
        :task_id => params[:task_id],
        :activity_id => params[:activity_id],
        :error_rate => params[:error_rate],
        :success_rate => params[:success_rate],
        :time => params[:time]
      }) 

      respond_to do |format|
        if completed_task.save
          format.html { redirect_to completed_task.task, :notice =>'Task completed' }
        else
          format.html{ render '/tasks/' + params[:task_id] }
        end
      end
    end
  end

end

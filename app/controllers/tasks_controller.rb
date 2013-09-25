require 'yaml'

class TasksController < ApplicationController

  def show
    if current_participant.nil?
      redirect_to "/login"
    else
      @task = Task.find(params[:id])

      #TODO: get user's skill level
      @level = 0

      complete = @task.completed_tasks.where( { :participant_id => current_participant.id } ).length

      @task_info = YAML.load_file('public/tasks/task_' + @task.id.to_s + '.yaml')

      @activity = @task_info['activities'][complete]
    end
  end

  def update
    # call method to process results and update user's data
    # I will have: task_id, participant_id, activity_id, time, error_rate, subjective_rating and success_rate
    completed_task = CompletedTask.new(params) 

    if completed_task.save
      redirect_to completed_task.task
    end
  end

end

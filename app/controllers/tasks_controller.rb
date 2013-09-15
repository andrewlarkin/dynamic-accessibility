require 'yaml'

class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])

    @task_info = YAML.load_file('public/tasks/task_' + @task.id.to_s + '.yaml')

    @activity = @task_info['activities'][params[:activity].to_i]
  end

end

require 'yaml'

class TasksController < ApplicationController

  def show
    if current_participant.nil?
      redirect_to "/login"
    else
      @task = Task.find(params[:id])

      if !@task.prereq_id.nil? && @task.prereq.completed_tasks.by_participant(current_participant.id).length != @task.prereq.count
        redirect_to current_participant
      end

      @current_activity = @task.completed_tasks.by_participant(current_participant.id).length
      # @current_activity = 3

      puts @task.count
      puts @current_activity

      if @current_activity == @task.count
        redirect_to current_participant
      else
        @task_info = YAML.load_file('public/tasks/task_' + @task.id.to_s + '.yaml')

        @activity = @task_info['activities'][@current_activity]

        @level = current_participant.group == "A" ? 0 : current_participant.level(@activity['type'])
      end
    end
  end

  def update
   
    if !current_participant.nil?

      completed_task = CompletedTask.new({ 
        :participant_id => current_participant.id,
        :task_id => params[:task_id],
        :activity_id => params[:activity_id],
        :error_rate => params[:error_rate],
        :success_rate => params[:success_rate],
        :time => params[:time],
        :activity_type => params[:type]
      }) 

      respond_to do |format|
        if completed_task.save
          if (params[:task_id].to_i > 1)
            current_participant.set_level(params[:type])
          end
          format.html { redirect_to Task.find(params[:task_id]), :notice =>'Task completed' }
        else
          format.html{ render '/tasks/' + params[:task_id] }
        end
      end
    end
  end

end

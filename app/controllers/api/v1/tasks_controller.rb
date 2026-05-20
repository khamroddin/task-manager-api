class Api::V1::TasksController < ApplicationController

  before_action :authorize
  before_action :set_task , only: [:show, :update, :destroy]

  def index
    tasks = current_user.tasks
    if tasks.any?
    render json: tasks  
    else
      render json: {errors: "cccccccccccc"}
    end  
  end

  def create
    task = current_user.tasks.new(task_params)
    if task.save
    render json: task, status: :created
    else

      render json: {
        errors: task.error.full_message
      }, status: :unprocessable_content
    end
  
  end


  def show      
    render json: @task
  end

  def update
    if @task.update (task_params)
      render json: @task
    else
      render json: {
        errors: @task.errors.full_message
      },status: :unprocessable_content
    end
  end
  def destroy
    @task.destroy
    render json:{
      message: "Task deleted"
    }
  end



  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.permit(:title, :description, :status , :due_date)   
  end



end

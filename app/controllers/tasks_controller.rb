class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    # @tasks = Task.all
    if current_user == nil
      @tasks = Task.all
    else 
      @tasks = current_user.tasks.all
    end  
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    # @task = Task.new
    # added current user to fix "user must exist" error
    @task = current_user.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    # @task = Task.new(task_params)
    # added current user to fix "user must exist" error
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # def create
  #   # require columns in strong parameters list
  #   task_attributes = params.require(:task).permit(:title, :description)
    
  #   # mass assignment
  #   @task = Task.new(task_attributes)

  #   if @task.valid?
  #     @task.save
  #     # using helper method (use paths on the clients and urls on the server side)
  #     redirect_to tasks_url, notice: "Task created successfully."

  #   else
  #     render "new"
  #   end
  # end

  
  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :complete)
    end

    # def posts_params
    #   params.require(:post).permit(:your_posts_params, :user_id)
    # end
end

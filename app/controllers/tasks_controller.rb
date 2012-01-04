class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  before_filter :authenticate_user!
  
  def index
    logger.info params[:Search]
    if params[:Search]
      @tasks = Task.search(params[:Search], current_user)
      if @tasks.nil?
        @tasks = current_user.tasks
      end
    else
      @tasks = current_user.tasks
    end
    @tasks_by_date = @tasks.order("created_at DESC").group_by {|task| task.created_at.strftime("%B %d %Y")}
    @complete_tasks = current_user.tasks.complete
    @incomplete_tasks = current_user.tasks.incomplete
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks_by_date }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.update_attributes(:user_id => current_user.id)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :ok }
    end
  end
  
  def update_task
    @task = Task.find(params[:id])
    @task.update_attributes(:complete => params[:checked])
    @complete_tasks = Task.complete
    @incomplete_tasks = Task.incomplete
  end

end

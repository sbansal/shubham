class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  before_filter :authenticate_user!
  
  def index
    @user = User.find(session[:accessed_user])
    if params[:Search]
      @tasks = Task.search(params[:Search], @user)
      if @tasks.nil?
        @tasks = @user.tasks
      end
    else
      @tasks = @user.tasks
    end
    @tasks_by_date = @tasks.order("created_at DESC").group_by {|task| task.created_at.strftime("%B %d %Y")}
    @complete_tasks = @user.tasks.complete
    @incomplete_tasks = @user.tasks.incomplete
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
    unless authorize_access
      @task = Task.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @task }
      end
    end
  end

  # GET /tasks/1/edit
  def edit
    authorize_access
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    unless authorize_access
      @task = Task.new(params[:task])
      @task.update_attributes(:user_id => current_user.id)

      respond_to do |format|
        if @task.save
          format.html { redirect_to user_tasks_path, notice: 'Task was successfully created.' }
          format.json { render json: @task, status: :created, location: @task }
        else
          format.html { render action: "new" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    unless authorize_access
      @task = Task.find(params[:id])

      respond_to do |format|
        if @task.update_attributes(params[:task])
          format.html { redirect_to user_tasks_path, notice: 'Task was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    unless authorize_access
      @task = Task.find(params[:id])
      @task.destroy

      respond_to do |format|
        format.html { redirect_to user_tasks_path }
        format.json { head :ok }
      end
    end
  end
  
  def update_task
    authorize_access
    @task = Task.find(params[:id])
    @task.update_attributes(:complete => params[:checked])
    @complete_tasks = Task.complete
    @incomplete_tasks = Task.incomplete
  end

end

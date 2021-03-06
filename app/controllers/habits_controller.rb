class HabitsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /habits
  # GET /habits.json
  def index
    @user = User.find(session[:accessed_user])
    @habits = @user.habits.includes(:traces)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @habits }
    end
  end

  # GET /habits/1
  # GET /habits/1.json
  def show
    @habit = Habit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @habit }
    end
  end

  # GET /habits/new
  # GET /habits/new.json
  def new
    unless authorize_access
      @habit = Habit.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @habit }
      end
    end
  end

  # GET /habits/1/edit
  def edit
    authorize_access
    @habit = Habit.find(params[:id])
  end

  # POST /habits
  # POST /habits.json
  def create
    unless authorize_access
      @habit = Habit.new(params[:habit])
      @habit.update_attributes(:user_id => current_user.id)

      respond_to do |format|
        if @habit.save
          format.html { redirect_to user_habits_path, notice: 'Habit was successfully created.' }
          format.json { render json: @habit, status: :created, location: @habit }
        else
          format.html { render action: "new" }
          format.json { render json: @habit.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /habits/1
  # PUT /habits/1.json
  def update
    unless authorize_access
      @habit = Habit.find(params[:id])

      respond_to do |format|
        if @habit.update_attributes(params[:habit])
          format.html { redirect_to user_habits_path, notice: 'Habit was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @habit.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /habits/1
  # DELETE /habits/1.json
  def destroy
    unless authorize_access
      @habit = Habit.find(params[:id])
      @habit.destroy

      respond_to do |format|
        format.html { redirect_to user_habits_path }
        format.json { head :ok }
      end
    end
  end
end

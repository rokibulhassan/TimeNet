class TimeLogsController < ApplicationController
  before_action :set_time_log, only: [:show, :edit, :update, :destroy]
  before_action :resolve_prerequisite, only: [:new, :edit, :create, :update]
  load_and_authorize_resource

  def index
    if current_user.admin?
      @time_logs = TimeLog.scoped
    elsif current_user.client_admin?
      @time_logs = current_client.time_logs if params[:project].nil?
    else
      @time_logs = current_user.time_logs if params[:project].nil?
    end
    respond_to do |format|
      format.html
      format.csv { render text: TimeLog.to_csv(params[:project_ids]) }
    end
  end

  def show
  end

  def new
    @time_log = TimeLog.new
  end

  def edit
  end

  def create
    @time_log = TimeLog.new(time_log_params)

    respond_to do |format|
      if @time_log.save
        format.html { redirect_to @time_log, notice: 'Time log was successfully created.' }
        format.json { render action: 'show', status: :created, location: @time_log }
      else
        format.html { render action: 'new' }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @time_log.update(time_log_params)
        format.html { redirect_to @time_log, notice: 'Time log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @time_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @time_log.destroy
    respond_to do |format|
      format.html { redirect_to time_logs_url }
      format.json { head :no_content }
    end
  end

  private
  def set_time_log
    @time_log = TimeLog.find(params[:id])
  end

  def resolve_prerequisite
    @users = current_user.admin? ? User.scoped : current_client.users
    @projects = current_user.admin? ? Project.scoped : current_client.projects
  end

  def time_log_params
    params.require(:time_log).permit(:start_at, :end_at, :user_id, :project_id, :idle_time)
  end
end

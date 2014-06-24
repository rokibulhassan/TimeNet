class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :resolve_prerequisite, only: [:new, :edit, :create, :update]
  load_and_authorize_resource

  def index
    if current_user.admin?
      @users = User.all
    else
      @users = current_client.users
    end
  end

  def show
  end

  def new
    @user = User.new()
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_admin_path(@user), notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @client }
      else
        flash.now[:error] = @user.errors.full_messages
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_admin_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        flash.now[:error] = @user.errors.full_messages
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_admin_index_url }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
    @user.admin = true if current_user.admin?
  end

  def resolve_prerequisite
    @clients = current_user.admin? ? Client.scoped : Client.where(id: current_client.id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :office_phone, :billing_rate, :mobile_phone, :email, :password,
                                 :password_confirmation, {roles: []}, :roles_mask, :client_id, :password_change_required)
  end
end

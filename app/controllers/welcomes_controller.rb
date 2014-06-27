class WelcomesController < ApplicationController
  def index

  end

  def dashboard
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_client.projects.order('created_at DESC')
    end
  end

  def about
    respond_to do |format|
      format.html
    end
  end

  def download_manager
    respond_to do |format|
      format.html
    end
  end


  def load_state
    @states = State.by_country(params[:country])
    result = @states.collect do |state|
      {id: state.id, name: state.name}
    end
    render json: result
  end

  def load_contact
    @contacts = Contact.by_customer(params[:customer])
    result = @contacts.collect do |contact|
      {id: contact.id, name: contact.name}
    end
    render json: result
  end

  def load_user
    client = Client.find(params[:client_id])
    result = client.users.collect do |user|
      {id: user.id, name: user.name}
    end
    render json: result
  end

  def load_project
    user = User.find(params[:user_id])
    result = user.projects.collect do |project|
      {id: project.id, name: project.name}
    end
    render json: result
  end

end

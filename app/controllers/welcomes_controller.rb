class WelcomesController < ApplicationController
  def index

  end

  def dashboard
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.projects.order('created_at DESC')
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
end

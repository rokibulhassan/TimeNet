class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /contacts
  # GET /contacts.json
  def index
    if current_user.admin?
      @contacts = Contact.all
    else
      @contacts = current_client.contacts
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new()
    @contact.customer_id = params[:customer_id] if params[:customer_id].present?
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    begin
      response = Contact.import(params[:file], current_user, current_client)
      flash[:notice] = uploaded_notice('Contacts', response[:success], response[:failed])
      flash[:error] = response[:errors] if response[:errors].present?
    rescue Exception => ex
      flash[:error] = ex.message
    end
    redirect_to contacts_path
  end


  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :title, :office_phone, :mobile_phone, :contact_method, :customer_id, :created_by, :client_id)
  end
end

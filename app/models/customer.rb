class Customer < ActiveRecord::Base
  paranoid
  has_many :contacts
  has_many :projects
  belongs_to :client
  belongs_to :user, foreign_key: :created_by

  validates :business_name, presence: true, uniqueness: {scope: :client_id}
  validates :phone, presence: true
  validates :zip_code, numericality: true, :allow_blank => true

  attr_accessor :contact_ids

  after_save :associate_contacts

  scope :by_client, ->(client_id) { where(client_id: client_id) }

  def self.import(file, current_user, current_client)
    CSV.foreach(file.path, headers: true) do |row|
      customer=Customer.new(row.to_hash)
      customer.user=current_user
      customer.client=current_client
      customer.save!
    end
  end


  private

  def associate_contacts
    contacts = Contact.where(id: contact_ids)
    contacts.each do |contact|
      contact.update_column(:customer_id, self.id)
    end
  end
end

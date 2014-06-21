class Customer < ActiveRecord::Base
  paranoid
  has_many :contacts
  has_many :projects
  belongs_to :client
  belongs_to :user, foreign_key: :created_by

  validates :business_name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :zip_code, numericality: true, :allow_blank => true

  attr_accessor :contact_ids

  #before_save :associate_client
  after_save :associate_contacts

  scope :by_client, ->(client_id) { where(client_id: client_id) }

  private

  def associate_contacts
    contacts = Contact.where(id: contact_ids)
    contacts.each do |contact|
      contact.update_column(:customer_id, self.id)
    end
  end

  def associate_client
    self.client_id = self.user.client_id
  end
end

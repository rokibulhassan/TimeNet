class Contact < ActiveRecord::Base
  paranoid
  has_and_belongs_to_many :projects
  belongs_to :user, foreign_key: :created_by
  belongs_to :customer
  belongs_to :client

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :office_phone, presence: true
  validates :contact_method, presence: true
  #validates :customer_id, presence: true
  #validate :validate_customer

  scope :by_customer, ->(customer_id) { where(customer_id: customer_id) }
  scope :alphabetically, -> { order("last_name ASC") }

  def name
    [self.first_name, self.last_name].join(" ")
  end

  def self.import(file, current_user, current_client)
    errors=[]
    line, success, failed = 1, 0, 0

    CSV.foreach(file.path, headers: true) do |row|
      line+=1
      contact=Contact.new(row.to_hash)
      contact.user=current_user
      contact.client=current_client
      begin
        contact.save!
        success+=1
      rescue Exception => ex
        failed+=1
        errors << "Line##{line}::For #{contact.name} #{contact.errors.full_messages}"
      end
    end
    {:success => success, :failed => failed, :errors => errors}
  end


  private
  def validate_customer
    self.errors.add(:base, "Failed! Can not change customer.") if !new_record? && customer_id_changed?
  end

end

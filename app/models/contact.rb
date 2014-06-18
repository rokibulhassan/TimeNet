class Contact < ActiveRecord::Base
  paranoid
  has_and_belongs_to_many :projects
  belongs_to :user, foreign_key: :created_by
  belongs_to :customer

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :office_phone, presence: true
  validates :contact_method, presence: true
  #validates :customer_id, presence: true
  validate :validate_customer

  scope :by_customer, ->(customer_id) { where(customer_id: customer_id) }

  def name
    [self.first_name, self.last_name].join(" ")
  end

  private
  def validate_customer
    self.errors.add(:base, "Failed! Can not change customer.") if !new_record? && customer_id_changed?
  end

end

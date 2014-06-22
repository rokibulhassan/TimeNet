class Project < ActiveRecord::Base
  paranoid
  belongs_to :customer
  has_and_belongs_to_many :contacts
  belongs_to :user, foreign_key: :created_by
  has_many :time_logs, dependent: :destroy
  belongs_to :client

  validates :name, presence: true
  validates :number, presence: true
  validates :customer_id, presence: true
  #validates :contact_id, presence: true
  validate :validate_customer

  scope :by_customer, ->(customer_id) { where(customer_id: customer_id) }

  def time_logged
    time_logs.sum(:logged)
  end

  def active_time_logged
    time_logs.sum(:logged) - time_logs.sum(:idle_time)
  end

  def self.uniq_number
    number = loop do
      token = rand(36**10).to_s(36)
      break token.upcase! unless Project.exists?(number: token)
    end
  end


  private
  def validate_customer
    self.errors.add(:base, "Failed! Can not change customer.") if !new_record? && customer_id_changed?
  end
end

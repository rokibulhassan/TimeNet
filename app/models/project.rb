class Project < ActiveRecord::Base
  paranoid
  belongs_to :customer
  has_and_belongs_to_many :contacts
  has_many :time_logs, dependent: :destroy
  belongs_to :user, foreign_key: :created_by
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

  def self.import(file, current_user, current_client)
    CSV.foreach(file.path, headers: true) do |row|
      project=Project.new(row.to_hash)
      project.number=Project.uniq_number
      project.user=current_user
      project.client=current_client
      project.save!
    end
  end

  private
  def validate_customer
    self.errors.add(:base, "Failed! Can not change customer.") if !new_record? && customer_id_changed?
  end
end

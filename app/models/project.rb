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

  attr_accessor :customer_name

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
    errors=[]
    line, success, failed = 1, 0, 0

    CSV.foreach(file.path, headers: true) do |row|
      line+=1
      project=Project.new(row.to_hash)
      project.number=Project.uniq_number
      project.user=current_user
      project.client=current_client
      begin
        project.customer_id=Customer.by_name(project.customer_name).first.id
        project.save!
        success+=1
      rescue Exception => ex
        failed+=1
        errors << "Line##{line}::For #{project.name} #{project.errors.full_messages}"
      end
    end
    {:success => success, :failed => failed, :errors => errors}
  end

  private
  def validate_customer
    self.errors.add(:base, "Failed! Can not change customer.") if !new_record? && customer_id_changed?
  end
end

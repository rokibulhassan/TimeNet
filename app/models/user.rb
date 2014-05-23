class User < ActiveRecord::Base
  has_many :time_logs
  belongs_to :client

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  #validates :client_id, presence: true
  validate :validate_client

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :admin

  before_create :set_authentication_token

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin create_customers create_contacts create_projects]
  ROLES_WITHOUT_ADMIN = %w[create_customers create_contacts create_projects]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def admin?
    role?('admin')
  end

  def name
    [self.first_name, self.last_name].join(" ")
  end

  def password_required?
    return false if admin.present? && !new_record?
    true
  end

  def set_authentication_token
    self.authentication_token = loop do
      token = rand(36**15).to_s(36)
      break token unless User.exists?(authentication_token: token)
    end
  end

  def customers
    Customer.by_client(self.client_id)
  end

  def contacts
    Contact.by_customer(customers.collect(&:id))
  end

  def projects
    Project.by_customer(customers.collect(&:id))
  end

  def time_log_records
    TimeLog.by_project(projects.collect(&:id))
  end


  private
  def validate_client
    self.errors.add(:base, "Failed! Can not change client.") if !new_record? && client_id_changed?
  end

end


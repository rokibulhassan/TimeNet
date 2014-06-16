class User < ActiveRecord::Base
  has_many :time_logs
  belongs_to :client

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  #validates :client_id, presence: true
  validate :validate_client

  devise :two_factor_authenticatable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one_time_password

  attr_accessor :admin

  before_create :set_authentication_token, :set_otp_secret_key

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

  def set_otp_secret_key
    self.otp_secret_key = loop do
      token = User.random_code
      break token unless User.exists?(otp_secret_key: token)
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

  def send_two_factor_authentication_code
    UserMailer.otp_code_notification(self, otp_code).deliver
  end

  def need_two_factor_authentication?(request)
    not otp_secret_key.nil?
  end

  private

  def self.random_code(size = 6)
    charset = %w{ 2 3 4 5 6 7 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z}
    (0...size).map { charset.to_a[rand(charset.size)] }.join
  end

  def validate_client
    self.errors.add(:base, "Failed! Can not change client.") if !new_record? && client_id_changed?
  end

end


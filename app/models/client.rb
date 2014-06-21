class Client < ActiveRecord::Base
  paranoid
  has_many :users
  has_many :customers
  has_many :contacts
  has_many :projects

  validates :business_name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :zip_code, numericality: true, :allow_blank => true

  attr_accessor :user_ids

  after_save :associate_users


  def total_time_logged
    self.users.collect { |u| u.time_logs.sum(:logged) }.sum
  end

  private

  def associate_users
    users = User.where(id: user_ids)
    users.each do |user|
      user.update_column(:client_id, self.id)
    end
  end
end

class RequestInfo < ActiveRecord::Base
  apply_simple_captcha
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
  validates :query, presence: true

end

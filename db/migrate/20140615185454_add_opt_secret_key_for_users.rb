class AddOptSecretKeyForUsers < ActiveRecord::Migration
  def self.up
    User.scoped.each do |user|
      next if user.admin?
      user.update_column(:otp_secret_key, user.set_otp_secret_key)
    end
  end
end

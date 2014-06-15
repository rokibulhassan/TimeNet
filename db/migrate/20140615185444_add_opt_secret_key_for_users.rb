class AddOptSecretKeyForUsers < ActiveRecord::Migration
  def self.up
    User.scoped.each do |user|
      otp_secret_key = user.admin? ? "qazwsx" : user.set_otp_secret_key
      user.update_column(:otp_secret_key, otp_secret_key)
    end
  end
end

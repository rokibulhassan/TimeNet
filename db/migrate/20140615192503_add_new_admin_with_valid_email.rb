class AddNewAdminWithValidEmail < ActiveRecord::Migration
  def self.up
    admin=User.new(first_name: 'Rakib', last_name: 'Hasan', title: "Site Admin", roles_mask: 1, "email" => "rakib063049@gmail.com",
                    password: '1234567', password_confirmation: '1234567', otp_secret_key: "qazwsx")
    admin.save(validate: false)
  end
end

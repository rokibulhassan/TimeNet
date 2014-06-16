class AddPasswordChangeRequireToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_change_required, :boolean, :default => false
  end
end

class AddBiilingRateToUser < ActiveRecord::Migration
  def change
    add_column :users, :billing_rate, :float
  end
end

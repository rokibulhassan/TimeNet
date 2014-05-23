class CreateRequestInfos < ActiveRecord::Migration
  def change
    create_table :request_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :comments
      t.text :query

      t.timestamps
    end
  end
end

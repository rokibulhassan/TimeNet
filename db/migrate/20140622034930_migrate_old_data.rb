class MigrateOldData < ActiveRecord::Migration
  def change
    Contact.scoped.each do |contact|
      next if contact.client.present?
      contact.update_column(:client_id, contact.try(:customer).try(:client_id))
    end

    Project.scoped.each do |project|
      next if project.client.present?
      project.update_column(:client_id, project.try(:customer).try(:client_id))
    end
  end
end

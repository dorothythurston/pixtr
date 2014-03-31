class AddActorsAndTargetsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :actor_id, :integer, index: true
    add_column :activities, :target_id, :integer, index: true
    add_column :activities, :target_type, :string, index: true
  end
end

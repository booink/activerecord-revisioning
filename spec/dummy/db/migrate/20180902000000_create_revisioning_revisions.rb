class CreateRevisioningRevisions < ActiveRecord::Migration[5.2]
  def change
    create_table :revisioning_revisions do |t|
      t.integer :revisionable_id, null: false, unsigned: true
      t.string :revisionable_type, null: false
      t.integer :associated_id, unsigned: true
      t.string :associated_type
      t.string :behavior, null: false
      t.text :revision_changes
      t.integer :version, default: 0, null: false
      t.datetime :created_at, null: false
    end
  end
end

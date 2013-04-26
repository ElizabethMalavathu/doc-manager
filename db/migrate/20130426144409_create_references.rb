class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :document
      t.references :collection
      t.integer :order

      t.timestamps
    end
    add_index :references, :document_id
    add_index :references, :collection_id
  end
end

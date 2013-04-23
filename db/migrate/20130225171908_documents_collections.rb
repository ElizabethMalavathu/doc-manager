class DocumentsCollections < ActiveRecord::Migration
  def change
    create_table :collections_documents, :id => false do |t|
      t.references :document, :null => false
      t.references :collection, :null => false
    end

    add_index(:collections_documents, [:document_id, :collection_id], :unique => true, :name => :index_documents_collections)
  end
end

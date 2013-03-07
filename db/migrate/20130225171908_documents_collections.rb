class DocumentsCollections < ActiveRecord::Migration
  def change
    create_table :collections_primary_documents, :id => false do |t|
      t.references :primary_document, :null => false
      t.references :collection, :null => false
    end

    add_index(:collections_primary_documents, [:primary_document_id, :collection_id], :unique => true, :name => :index_documents_collections)
  end
end

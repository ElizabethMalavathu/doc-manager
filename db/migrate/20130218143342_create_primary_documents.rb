class CreatePrimaryDocuments < ActiveRecord::Migration
  def change
    create_table :primary_documents do |t|
      t.string :title
      t.text   :content
      t.date   :publication_date

      t.references :author

      t.timestamps
    end
  end
end

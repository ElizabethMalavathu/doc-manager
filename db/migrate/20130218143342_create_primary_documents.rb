class CreatePrimaryDocuments < ActiveRecord::Migration
  def change
    create_table :primary_documents do |t|
      t.string :title
      t.string :location
      t.text   :content
      t.text   :background
      t.date   :publication_date

      t.references :author

      t.timestamps
    end
  end
end

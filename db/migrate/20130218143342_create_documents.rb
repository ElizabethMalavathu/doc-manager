class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text   :title
      t.text   :location
      t.text   :content
      t.text   :background
      t.date   :publication_date
      t.string :citation
      t.boolean :primary, :default => false

      t.references :author

      t.timestamps
    end
  end
end

class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :documents_tags, :id => false do |t|
      t.references :document, :null => false
      t.references :tag, :null => false
    end
  end
end

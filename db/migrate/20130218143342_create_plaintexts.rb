class CreatePrimaryDocs < ActiveRecord::Migration
  def change
    create_table :primarydocs do |t|
      t.string :title

      t.timestamps
    end
  end
end

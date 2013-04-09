class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.text :header
      t.text :document
      t.text :footer

      t.timestamps
    end
  end
end

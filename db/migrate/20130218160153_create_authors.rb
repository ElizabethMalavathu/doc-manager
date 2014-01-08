class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.date :born
      t.date :died
      t.text :biography

      t.timestamps
    end
  end
end

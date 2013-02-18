class CreatePlaintexts < ActiveRecord::Migration
  def change
    create_table :plaintexts do |t|
      t.string :title

      t.timestamps
    end
  end
end

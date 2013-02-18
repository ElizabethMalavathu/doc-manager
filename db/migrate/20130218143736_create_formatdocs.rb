class CreateFormatdocs < ActiveRecord::Migration
  def change
    create_table :formatdocs do |t|
      t.string :title
      t.dateauthor :date
      t.string :bibliography

      t.timestamps
    end
  end
end

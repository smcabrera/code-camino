class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :url
      t.references :user, index: true
      t.references :path, index: true

      t.timestamps null: false
    end
    add_foreign_key :lessons, :users
    add_foreign_key :lessons, :paths
  end
end

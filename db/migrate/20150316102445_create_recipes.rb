class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.references :user, index: true
      t.string :image

      t.timestamps null: false
    end
    add_foreign_key :recipes, :users
  end
end

class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.date   :birth_date
      t.string :color,       null: false
      t.string :name,        null: false
      t.string :sex,         null: false, limit: 1
      t.text   :description

      t.timestamps null: false
    end

    add_index :cats, :birth_date
    add_index :cats, :color
    add_index :cats, :name
    add_index :cats, :sex
  end
end

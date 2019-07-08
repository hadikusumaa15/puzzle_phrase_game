class CreatePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :phrases do |t|
      t.string :name
      t.string :description
      t.boolean :deleted
      t.timestamps
    end
  end
end

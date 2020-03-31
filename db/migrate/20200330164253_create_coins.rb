class CreateCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :coins do |t|
      t.string :code
      t.string :name
      t.string :symbol

      t.timestamps
    end
  end
end

class CreatePotatoPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :potato_prices do |t|
      t.datetime :time
      t.decimal :value

      t.timestamps
    end
    add_index :potato_prices, :time
  end
end

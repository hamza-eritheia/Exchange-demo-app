class AddTableRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.string :currency
      t.string :code
      t.string :mid
      t.string :bid
      t.string :ask
      t.belongs_to :table_type

      t.timestamps
    end
  end
end

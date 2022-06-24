class AddTableTableType < ActiveRecord::Migration[6.1]
  def change
    create_table :table_types do |t|
      t.string :table
      t.string :no
      t.string :tradingDate
      t.string :effectiveDate

      t.timestamps
    end
  end
end

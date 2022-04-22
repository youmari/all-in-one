class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :amount
      t.references :author, null: false,index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
    add_index :expenses, :name
  end
end

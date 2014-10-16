class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.column :ang_list_id, :integer, null: false
      t.column :name, :string, limit: 50
      t.column :company_url, :string, limit: 150
      t.column :locations, :array
      t.column :markets, :array

      t.column :round_opened_at, :date
      t.column :raising_amount, :float
      t.column :pre_money_valuation, :float
      t.column :discount, :string
      t.column :equity_basis, :string
      t.column :raised_amount, :datetime
      t.column :public, :boolean

      t.timestamps
    end
    add_index(:companies, [:ang_list_id], unique: true )
  end

  def down
    remove_index(:companies, column: :ang_list_id)
    drop_table :companies
  end

end

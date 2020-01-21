class CreateAvaliations < ActiveRecord::Migration[5.2]
  def change
    create_table :avaliations do |t|
      t.string :comment
      t.integer :grade
      t.integer :manager_id
      t.integer :employee_id

      t.timestamps
    end
  end
end

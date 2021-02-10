class CreateOpinions < ActiveRecord::Migration[6.1]
  def change
    create_table :opinions do |t|
      t.string :text

      t.timestamps
    end
  end
end

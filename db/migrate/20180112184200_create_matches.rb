class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.date :start_date
      t.time :start_time
      t.integer :team_a_goals
      t.integer :team_b_goals
      t.boolean :finished, default: false
      t.belongs_to :tournament, index: true
      t.belongs_to :team_a, index: true
      t.belongs_to :team_b, index: true
      t.timestamps
    end
  end
end

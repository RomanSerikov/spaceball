class AddWinnersLosersDrawAndFinishedToMatches < ActiveRecord::Migration[5.1]
  def change
    change_table :matches do |t|
      t.belongs_to :winner, index: true
      t.belongs_to :loser, index: true
      t.column :draw, :boolean, default: false
    end
    
    add_foreign_key :matches, :teams, column: :winner_id 
    add_foreign_key :matches, :teams, column: :loser_id
  end
end

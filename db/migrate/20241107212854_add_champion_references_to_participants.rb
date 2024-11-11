class AddChampionReferencesToParticipants < ActiveRecord::Migration[8.0]
  def change
    add_reference :participants, :champion, foreign_key: true, null: true
  end
end

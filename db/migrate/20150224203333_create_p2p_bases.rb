class CreateP2pBases < ActiveRecord::Migration
  def change
    create_table :p2p_bases do |t|
      t.uuid :uuid
      t.timestamp :date
      t.text :user_id
      t.text :card_a
      t.text :card_b
      t.integer :phone, :limit => 5
      t.integer :vendor
      t.text :status
      t.integer :rrn, :limit => 8

      t.timestamps
    end
  end
end

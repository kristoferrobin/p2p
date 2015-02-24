class CreateP2pBases < ActiveRecord::Migration
  def change
    create_table :p2p_bases do |t|
      t.uuid :id
      t.timestamp :date
      t.text :user_id
      t.text :card_a
      t.text :card_b
      t.bigint :phone
      t.integer :vendor

      t.timestamps
    end
  end
end

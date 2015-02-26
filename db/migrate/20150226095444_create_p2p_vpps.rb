class CreateP2pVpps < ActiveRecord::Migration
  def change
    create_table :p2p_vpps do |t|

      t.timestamps
    end
  end
end

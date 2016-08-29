class CreateAssetsSharesTable < ActiveRecord::Migration
  def self.up
    create_table :spree_assets_shares do |t|
      t.references :shareable, :polymorphic => true
      t.references :asset
    end
    add_index :spree_assets_shares, :shareable_id
    add_index :spree_assets_shares, :shareable_type
  end

  def self.down
    remove_index :spree_assets_shares, :shareable_id
    remove_index :spree_assets_shares, :shareable_type
    drop_table :spree_assets_shares
  end
end
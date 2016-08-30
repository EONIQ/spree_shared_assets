Spree::Variant.class_eval do

  has_many :assets_shares, -> { includes(:asset) }, dependent: :destroy, as: :shareable
  has_many :images, -> { order('assets.position ASC') }, source: :asset, foreign_key: 'asset_id', through: :assets_shares, class_name: 'Image', dependent: :destroy
    
  self.table_name = 'spree_variants'  
end

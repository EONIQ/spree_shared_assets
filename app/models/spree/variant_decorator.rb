Spree::Variant.class_eval do

  # has_many :assets_shares, -> { includes(:asset) }, dependent: :destroy, as: :shareable
  # has_many :images, -> { order('spree_assets.position ASC') }, source: :asset, foreign_key: 'asset_id', through: :assets_shares, class_name: 'Spree::Image', dependent: :destroy

end

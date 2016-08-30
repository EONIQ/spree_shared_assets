Spree::Product.class_eval do 
  has_many :assets_shares, -> {includes(:asset)}, dependent: :destroy, as: :shareable
  has_many :images, -> {order('spree_assets.position ASC')}, source: :asset, foreign_key: 'asset_id', through: :assets_shares, class_name: 'Image'
  
  def all_images
    return images unless has_variants?
    return (images + variant_images).uniq
  end
  
  def variant_images
    Spree::Asset.for_product(self)
  end
  
end

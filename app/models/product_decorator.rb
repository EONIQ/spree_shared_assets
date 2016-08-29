Spree::Product.class_eval do
 
  has_many :assets_shares, :dependent => :destroy, :as => :shareable, -> { includes(:asset) }
  has_many :images, :source => :asset, :foreign_key => "asset_id", :through => :assets_shares, :class_name => "Image", :order => "assets.position ASC"
  
  def all_images
    return images unless has_variants?
    return (images + variant_images).uniq
  end
  
  def variant_images
    Asset.for_product(self)
  end
  
end

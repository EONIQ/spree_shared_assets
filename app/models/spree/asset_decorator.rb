Spree::Asset.class_eval do
  
  has_many :assets_shares, :dependent => :destroy
  has_many :variants, :through => :assets_shares, :source => :shareable, :source_type => "Variant", :class_name => "Variant"
  has_many :products, :through => :assets_shares, :source => :shareable, :source_type => "Product", :class_name => "Product"
  
  def assignments
    (products + variants).uniq
  end
  
  scope :for_product, -> { select('DISTINCT assets.*, assets_shares.shareable_id as shareable_id').
    joins(:variants, :assets_shares).where(variants: { product_id: product.id }).order('assets.position ASC') }
end

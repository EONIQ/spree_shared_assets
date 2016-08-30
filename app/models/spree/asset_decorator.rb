Spree::Asset.class_eval do
  
  has_many :assets_shares, :dependent => :destroy
  has_many :variants, :through => :assets_shares, :source => :shareable, :source_type => "Spree::Variant", :class_name => "Spree::Variant"
  has_many :products, :through => :assets_shares, :source => :shareable, :source_type => "Spree::Product", :class_name => "Spree::Product"
  
  def assignments
    (products + variants).uniq
  end
  
  scope :for_product, ->(product) {
    joins(:variants, :assets_shares).
    select('DISTINCT assets.*, assets_shares.shareable_id as shareable_id').
    where(spree_variants: { product_id: product.id }).order('spree_assets.position ASC') 
  }
end

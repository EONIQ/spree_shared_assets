Spree::Asset.class_eval do
  
  has_many :assets_shares, :dependent => :destroy
  has_many :variants, :through => :assets_shares, :source => :shareable, :source_type => "Variant", :class_name => "Variant"
  has_many :products, :through => :assets_shares, :source => :shareable, :source_type => "Product", :class_name => "Product"
  
  def assignments
    (products + variants).uniq
  end
  
  scope :for_product, lambda { |product|
    {
      :joins      => [:variants, :assets_shares],
      :conditions => { :variants => { :product_id => product.id } },
      :select     => "DISTINCT assets.*, assets_shares.shareable_id as shareable_id",
      :order      => "assets.position ASC"
    }
  }
  
end

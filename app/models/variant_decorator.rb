Spree::Variant.class_eval do

  has_many :assets_shares, :dependent => :destroy, :as => :shareable, :include => :asset
  has_many :images, :source => :asset, :foreign_key => "asset_id", :through => :assets_shares, :class_name => "Image", :dependent => :destroy, :order => "assets.position ASC"
  
end

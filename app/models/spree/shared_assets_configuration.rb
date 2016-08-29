class SharedAssetsConfiguration < Configuration
  preference :admin_style, :string, :default => 'mini'
  preference :cropbox_width,  :integer, :default => 0
  preference :cropbox_height, :integer, :default => 0
end

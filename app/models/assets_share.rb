module Spree
  class AssetsShare < ActiveRecord::Base

    belongs_to :asset
    belongs_to :shareable, :polymorphic => true, :primary_key => :id
    
  end
end

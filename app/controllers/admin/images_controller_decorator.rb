module Spree
  module Admin
    ImagesController.class_eval do
      create.after :assign_to_product
      private

      def assign_to_product
        if @image.products.length > 0
          @product.images << @image unless @product.images.include?(@image)
        end
      end

      def load_data
        @product = Spree::Product.find_by_permalink(params[:product_id])
      end

      def set_viewable
        @image.viewable = @product
        
        assign_to_product = params[:shareable_id] && !params[:shareable_id].blank?
        if assign_to_product # Check if "Product" option was selected
          # Assign to product
          @image.products << @product unless @image.products.include?(@product)
          params.delete(:shareable_id)
        else
          # "Product" option not selected, delete if it exists 
          shares = @image.assets_shares.find_all_by_shareable_type('Spree::Product')
          shares.each { |s| s.destroy if s.shareable_id == @product.id } if shares.size > 0
        end  
        
        # Check if at least one variant selected, if not assign to "Product"
        variant_ids = (params[:variant_ids] || []).select { |i| !i.blank? }
        if variant_ids.any?
          @image.variant_ids = variant_ids
        elsif !assign_to_product
          # No variants or Product specified, default to at least product assignment
          @image.products << @product unless @image.products.include?(@product)
        end
      end

      def destroy_before
      end
    end
  end
end
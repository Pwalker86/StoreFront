class StoreAdmin::ProductsController < ApplicationController
  before_action :authenticate_store_admin!

  def index
    @store = Store.find(params[:store_id])
    @products = ProductDecorator.decorate_collection(@store.products.order(:archived))
  end

  def show
    @store = Store.find params[:store_id]
    @product = @store.products.find (params[:id])
    @pagy, @reviews = pagy(@product.reviews.ordered)
  end

  def new
    @store = current_store_admin.store
    @new_product = @store.products.new
  end

  def edit
    @store = current_store_admin.store
    @product = @store.products.find(params[:id])
  end

  def create
    @store = Store.find(params[:store_id])
    @admin = @store.store_admin
    @product = @store.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to store_admin_store_product_path(@admin, @store, @product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @store = Store.find(params[:store_id])
    @admin = @store.store_admin
    @product = @store.products.find(params[:id])
    respond_to do |format|
      # TODO: extract tag_list. The old method of tag_list= is not available anymore and it's blowing up the update.
      if @product.update!(product_params)
        format.html { redirect_to store_admin_store_product_path(@admin, @store, @product) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # TODO: extract to it's own controller
  # def remove_image
  #   @store = current_store_admin.store
  #   @product = @store.products.find(params[:product_id])
  #   image_to_remove = @product.images.find { |image| image.id == params[:image_id].to_i }
  #   @image_id = image_to_remove.id
  #   image_to_remove.purge_later
  #   respond_to do |format|
  #       format.html { redirect_to edit_store_path(@store), notice: "Image removed!" }
  #       format.turbo_stream
  #   end
  # end

  private

  def product_params
    params.require(:product).permit(:id, :name, :price, :description, :out_of_stock, :archived,  images: [])
  end
end

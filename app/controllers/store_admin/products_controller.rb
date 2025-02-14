class StoreAdmin::ProductsController < ApplicationController
  before_action :authenticate_store_admin!
  before_action :set_store
  before_action { authorize @store, policy_class: Admin::ProductPolicy }

  def index
    @products = ProductDecorator.decorate_collection(@store.products.order(:archived))
  end

  def show
    @product = @store.products.find (params[:id])
    @pagy, @reviews = pagy(@product.reviews.ordered)
  end

  def new
    @new_product = @store.products.new
  end

  def edit
    @product = @store.products.find(params[:id])
  end

  def create
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
    @admin = @store.store_admin
    @product = @store.products.find(params[:id])
    respond_to do |format|
      # TODO: extract tag_list. The old method of tag_list= is not available anymore and it's blowing up the update.
      if @product.update!(product_params)
        format.html { redirect_to store_admin_store_products_path(@admin, @store) }
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

  def pundit_user
    current_store_admin
  end

  def set_store
    begin
      @store = Store.find(params[:store_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Store not found!" and return
    end
  end

  def product_params
    params.require(:product).permit(:id, :name, :price, :description, :out_of_stock, :archived,  images: [])
  end
end

class ProductsController < ApplicationController
  before_action :authenticate_store_admin!, except: [ :index, :show ]

  # GET /products or /products.json
  def index
    @store = Store.find(params[:store_id])
    @pagy_products, products = pagy(@store.products.where(archived: false).order(:name), limit: 6, page_param: :products_page)
    @products = ProductDecorator.decorate_collection(products)
  end

  # GET /products/1 or /products/1.json
  def show
    @store = Store.find params[:store_id]
    @product = @store.products.find (params[:id])
    @pagy, @reviews = pagy(@product.reviews.ordered)
  end

  # GET /products/new
  def new
    @store = current_store_admin.store
    @new_product = @store.products.new
  end

  # GET /products/1/edit
  def edit
    @store = current_store_admin.store
    @product = @store.products.find(params[:id])
  end

  # POST /products or /products.json
  def create
    @store = current_store_admin.store
    @product = @store.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to store_url(@store), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @store = current_store_admin.store
    @product = @store.products.find(params[:id])
    respond_to do |format|
      # TODO: extract tag_list. The old method of tag_list= is not available anymore and it's blowing up the update.
      if @product.update!(product_params)
        format.html { redirect_to store_product_url(@store, @product) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def remove_image
    @store = current_store_admin.store
    @product = @store.products.find(params[:product_id])
    image_to_remove = @product.images.find { |image| image.id == params[:image_id].to_i }
    @image_id = image_to_remove.id
    image_to_remove.purge_later
    respond_to do |format|
        format.html { redirect_to edit_store_path(@store), notice: "Image removed!" }
        format.turbo_stream
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:id, :name, :price, :description, :out_of_stock, :archived,  images: [])
  end
end

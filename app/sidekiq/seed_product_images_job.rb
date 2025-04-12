require "open-uri"

class SeedProductImagesJob
  include Sidekiq::Job

  def perform(product_id)
    begin
      dir = Rails.root+"./lib/assets"
      image_paths = []
      dir.children.each do | child |
        if child.extname == ".jpg"
          image_paths << child
        end
      end
      product = Product.find(product_id)

      unless product.images.attached?
        (2..6).to_a.sample.times do |i|
          product.images.attach(image_paths.sample)
        end
      end
    rescue StandardError => e
      Rails.logger.error("Something went wrong in Image creation: #{e.message}")
    end
  end

  # Old perform, getting images from the internet
  # def perform(product_id)
  #   begin
  #     product = Product.find(product_id)
  #     unless product.images.attached?
  #       (2..6).to_a.sample.times do |i|
  #         image_uri = URI(Faker::LoremFlickr.image)
  #         image = image_uri.open
  #         product.images.attach(io: image, filename: "#{product.name}_image_#{i}.jpg")
  #       end
  #     end
  #   rescue StandardError => exception
  #     puts "Something went wrong in Image creation: #{exception}"
  #   end
  # end
end

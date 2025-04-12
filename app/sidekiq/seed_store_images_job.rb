require "open-uri"

class SeedStoreImagesJob
  include Sidekiq::Job

  def perform(store_id)
    begin
      store = Store.find store_id
      dir = Rails.root+"./lib/assets"
      image_paths = []
      dir.children.each do | child |
        if child.extname == ".jpg"
          image_paths << child
        end
      end

      store.spotlight.attach(image_paths.sample)
    rescue StandardError => e
      Rails.logger.error("Something went wrong in Store Id: #{store.id} Image creation #{e.message}")
    end
  end

  # Old perform, getting images from the internet
  # def perform(store_id)
  #   begin
  #     store = Store.find(store_id)
  #     unless store.spotlight.attached?
  #       image_uri = URI(Faker::LoremFlickr.image)
  #       image = image_uri.open
  #       store.spotlight.attach(io: image, filename: "#{store.name}_image.jpg")
  #     end
  #   rescue StandardError => exception
  #       puts "Something went wrong in Store ID: #{store.id} Image creation: #{exception}"
  #   end
  # end
end

require "open-uri"

class SeedStoreImagesJob
  include Sidekiq::Job

  def perform(store_id)
    begin
      store = Store.find(store_id)
      unless store.spotlight.attached?
        image_uri = URI(Faker::LoremFlickr.image)
        image = image_uri.open
        store.spotlight.attach(io: image, filename: "#{store.name}_image.jpg")
      end
    rescue StandardError => exception
        puts "Something went wrong in Store ID: #{store.id} Image creation: #{exception}"
    end
  end
end

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "fuse.js" # @7.0.0
pin "@stimulus-components/dialog", to: "@stimulus-components--dialog.js" # @1.0.1

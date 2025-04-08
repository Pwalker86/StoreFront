# directory where all the monkey patches are stored
Dir[Rails.root.join("lib", "monkey_patches", "*.rb")].each { |f| require f }

# Apply the monkey patches
String.include MonkeyPatches::String
Hash.include MonkeyPatches::Hash

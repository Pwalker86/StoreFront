module EntityLookup
  class EntityLookupError < StandardError; end

  ENTITY_LOOKUP = {
    "User" => User,
    "Guest" => Guest
  }.freeze

  def self.find_entity(entity_name, entity_id)
    entity_class = ENTITY_LOOKUP[entity_name]
    raise EntityLookupError, "Unknown entity: #{entity_name}" unless entity_class

    entity_class.find(entity_id)
  end
end

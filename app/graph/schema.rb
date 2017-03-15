Schema = GraphQL::Schema.define do
  query QueryType
  # mutation MutationType

  resolve_type -> (object, ctx) {
    Schema.types[object.class.name]
  }

  object_from_id -> (id, ctx) {
    type_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)

    unless type_name.safe_constantize.present?
      raise ArgumentError, "Type of object (#{type_name}) does not exist."
    end

    type_name.constantize.find(object_id)
  }

  id_from_object -> (obj, type_defn, ctx) {
    GraphQL::Schema::UniqueWithinType.encode(type_defn.name, obj.id)
  }

end

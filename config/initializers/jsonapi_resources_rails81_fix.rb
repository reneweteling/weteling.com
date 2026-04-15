# Fix jsonapi-resources 0.10.7 incompatibility with Rails 8.1
# Rails 8.1 changed Resource/SingletonResource#initialize to accept keyword args
# instead of a positional options hash.
if Rails::VERSION::MAJOR >= 8 && Rails::VERSION::MINOR >= 1
  module ActionDispatch
    module Routing
      class Mapper
        module Resources
          def jsonapi_resource_scope(resource, resource_type)
            @scope = @scope.new(scope_level_resource: resource, jsonapi_resource: resource_type)
            controller(resource.resource_scope) { yield }
          ensure
            @scope = @scope.parent
          end
        end
      end
    end
  end

  # Patch the routing_ext to pass options as keyword args
  module JsonapiResourcesRails81Patch
    def jsonapi_resources(*resources, &block)
      @resource_type = resources.first
      res = JSONAPI::Resource.resource_klass_for(resource_type_with_module_prefix(@resource_type))

      res._routed = true

      options = resources.extract_options!.dup
      options[:controller] ||= @resource_type
      options.merge!(res.routing_resource_options)
      options[:param] = :id
      options[:path] = format_route(@resource_type)

      if res.resource_key_type == :uuid
        options[:constraints] ||= {}
        options[:constraints][:id] ||= /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/
      end

      if options[:except]
        options[:except] = Array(options[:except])
        options[:except] << :new unless options[:except].include?(:new) || options[:except].include?('new')
        options[:except] << :edit unless options[:except].include?(:edit) || options[:except].include?('edit')
      else
        options[:except] = [:new, :edit]
      end

      if res._immutable
        options[:except] << :create unless options[:except].include?(:create) || options[:except].include?('create')
        options[:except] << :update unless options[:except].include?(:update) || options[:except].include?('update')
        options[:except] << :destroy unless options[:except].include?(:destroy) || options[:except].include?('destroy')
      end

      resources @resource_type, options do
        jsonapi_resource_scope(
          ActionDispatch::Routing::Mapper::Resources::Resource.new(@resource_type, api_only?, @scope[:shallow], **options),
          @resource_type
        ) do
          if block
            yield
          else
            jsonapi_relationships
          end
        end
      end
    end

    def jsonapi_resource(*resources, &block)
      @resource_type = resources.first
      res = JSONAPI::Resource.resource_klass_for(resource_type_with_module_prefix(@resource_type))

      res._routed = true

      options = resources.extract_options!.dup
      options[:controller] ||= @resource_type
      options.merge!(res.routing_resource_options)
      options[:path] = format_route(@resource_type)

      if options[:except]
        options[:except] << :new unless options[:except].include?(:new) || options[:except].include?('new')
        options[:except] << :edit unless options[:except].include?(:edit) || options[:except].include?('edit')
      else
        options[:except] = [:new, :edit]
      end

      if res._immutable
        options[:except] << :create unless options[:except].include?(:create) || options[:except].include?('create')
        options[:except] << :update unless options[:except].include?(:update) || options[:except].include?('update')
        options[:except] << :destroy unless options[:except].include?(:destroy) || options[:except].include?('destroy')
      end

      resource @resource_type, options do
        jsonapi_resource_scope(
          ActionDispatch::Routing::Mapper::Resources::SingletonResource.new(@resource_type, api_only?, @scope[:shallow], **options),
          @resource_type
        ) do
          if block
            yield
          else
            jsonapi_relationships
          end
        end
      end
    end
  end

  ActionDispatch::Routing::Mapper::Resources.prepend(JsonapiResourcesRails81Patch)
end

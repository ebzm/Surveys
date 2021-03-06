# frozen_string_literal: true

module Sources
  # Workaround for objects that have policies that require related records to be preloaded.
  class ActiveRecordDefaults
    STRICT_LOADING_DEFAULT = true

    class << self
      def options_for(_model_class, overrides = {})
        {}.merge(overrides)
      end

      def apply_to(scope_or_model_class, overrides = {})
        scope = if scope_or_model_class.is_a?(::ActiveRecord::Relation)
                  scope_or_model_class
                else
                  scope_or_model_class.default_scoped
                end

        opts = options_for(scope.model, overrides)

        if (preload = opts[:preload])
          scope = scope.preload(preload)
        end

        scope = scope.strict_loading if opts.fetch(:strict_loading, STRICT_LOADING_DEFAULT)

        scope
      end
    end
  end
end

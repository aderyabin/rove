require 'active_support/all'

module Rove
  module Support
    module Storer extend ActiveSupport::Concern
      included do
        class_attribute :instances
        self.instances = []
      end

      module ClassMethods
        def all
          instances
        end

        def store(entry)
          instances << entry
        end
      end

      def store
        self.class.store(self)
      end
    end
  end
end
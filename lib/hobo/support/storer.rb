require 'active_support/all'

module Hobo
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

        def store(entry, uniqueness=false)
          if uniqueness
            uniqueness = !all.map{|x| x.send uniqueness}.include?(entry.send uniqueness)
          else
            uniqueness = true
          end

          instances << entry if uniqueness
        end
      end

      def store(uniqueness=false)
        self.class.store(self, uniqueness)
      end
    end
  end
end
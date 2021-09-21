module FunRuby
  module Array
    class Struct
      include Enumerable

      def self.new(...)
        super.freeze
      end

      def initialize(*args, &block)
        @array = case args
        in [[*array]]
          array
        in [size, placeholder]
          ::Array.new(size, placeholder)
        in [size]
          ::Array.new(size, &block)
        in []
          []
        end.freeze
      end

      def fetch(...)
        array.fetch(...)
      end

      def [](...)
        array.[](...)
      end

      def to_a
        array
      end

      def to_ary
        array
      end

      def to_enum
        Enumerator.new(self)
      end

      private

      attr_reader :array
    end
  end
end

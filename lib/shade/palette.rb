require 'color'
require 'geokdtree'

module Shade
  class Palette
    def initialize
      @tree = Geokdtree::Tree.new(3)
      @empty = true
      yield self if block_given?
    end

    def add(css_color, name = nil)
      @empty = false
      value = Value.new(css_color, name)
      @tree.insert(value.coords, value)
    end

    def empty?
      @empty
    end

    # This implements the CIE76 color difference algorithm.
    # See http://en.wikipedia.org/wiki/Color_difference#CIE76
    def nearest_value(css_color)
      value = Value.new(css_color)
      result = @tree.nearest(value.coords)
      result.data if result
    end

    # This implements the CIE94 color difference algorithm.
    # See http://en.wikipedia.org/wiki/Color_difference#CIE94
    # threshold_distance defaults to 40. Perceptible differences are > 2.3
    def nearest_value_cie94(css_color, threshold_distance = 100)
      value = Value.new(css_color)
      result_points = @tree.nearest_range(value.coords, threshold_distance)
      colors_to_values = Hash[result_points.map { |ea| [ea.data.color, ea.data] }]
      best_match_color = value.color.closest_match(colors_to_values.keys)
      colors_to_values[best_match_color]
    end

    class Value
      attr_reader :css_color, :name

      def initialize(css_color, name = nil)
        @css_color = css_color
        @name = name
      end

      def color
        @color ||= Color::RGB.by_css(css_color)
      end

      def lab
        @lab ||= color.to_lab
      end

      def coords
        @coords ||= [lab[:L], lab[:a], lab[:b]]
      end

      def ==(e)
        e.css_color == css_color && e.name == name
      end
    end
  end
end

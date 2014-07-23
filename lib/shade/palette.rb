require 'color'

module Shade
  class Palette
    Value = Struct.new :name, :css_color

    def initialize
      @tree = Geokdtree::Tree.new(3)
      yield self if block_given?
    end

    def add(css_color, name = nil)
      @tree.insert(css_color_to_lab(css_color), Value.new(css_color, name))
    end

    def nearest_value(css_color)
      result_point = @tree.nearest(css_color_to_lab(css_color))
      result_point.data if result_point
    end

    private
    def css_color_to_lab(css_color)
      lab = Color::RGB.by_css(css_color).to_lab
      [lab[:L], lab[:a], lab[:b]]
    end
  end
end

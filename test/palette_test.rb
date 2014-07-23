require 'minitest_helper'

describe Shade::Palette do
  let(:colors) { %w(purple red orange yellow darkcyan).shuffle }
  let (:subject) { Shade::Palette.new { |p| colors.each { |ea| p.add(ea, ea.upcase) } } }
  it 'finds exact match colors' do
    subject.nearest_value('yellow').must_equal Shade::Palette::Value.new('yellow', 'YELLOW')
  end
  it 'finds nearest by named color' do
    subject.nearest_value('mediumpurple').must_equal Shade::Palette::Value.new('purple', 'PURPLE')
    subject.nearest_value('crimson').must_equal Shade::Palette::Value.new('red', 'RED')
    subject.nearest_value('sandybrown').must_equal Shade::Palette::Value.new('orange', 'ORANGE')
    subject.nearest_value('gold').must_equal Shade::Palette::Value.new('yellow', 'YELLOW')
    subject.nearest_value('aqua').must_equal Shade::Palette::Value.new('darkcyan', 'DARKCYAN')
  end
end

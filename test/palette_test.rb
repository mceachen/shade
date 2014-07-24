require 'minitest_helper'

describe Shade::Palette do
  describe 'small palette' do
    let(:colors) { %w(purple orange olive crimson darkcyan indianred).shuffle }
    let(:subject) { Shade::Palette.new { |p| colors.each { |ea| p.add(ea, ea.upcase) } } }
    let(:purple) {Shade::Palette::Value.new('purple', 'PURPLE')}
    let(:orange) {Shade::Palette::Value.new('orange', 'ORANGE')}
    let(:crimson) {Shade::Palette::Value.new('crimson', 'CRIMSON')}
    let(:darkcyan) {Shade::Palette::Value.new('darkcyan', 'DARKCYAN')}
    let(:indianred) {Shade::Palette::Value.new('indianred', 'INDIANRED')}
    it 'finds exact match colors' do
      subject.nearest_value('purple').must_equal Shade::Palette::Value.new('purple', 'PURPLE')
    end
    it 'finds nearest by named color' do
      subject.nearest_value('MediumPurple').must_equal purple
      subject.nearest_value('Orchid').must_equal purple
      subject.nearest_value('FireBrick').must_equal crimson
      subject.nearest_value('SandyBrown').must_equal orange
      subject.nearest_value_cie94('SandyBrown').must_equal orange
      subject.nearest_value('MediumSeaGreen').must_equal darkcyan
      subject.nearest_value_cie94('MediumSeaGreen').must_equal darkcyan
      subject.nearest_value('LightCoral').must_equal indianred
      subject.nearest_value_cie94('LightCoral').must_equal indianred
    end
  end
  describe 'large palette' do
    let(:subject) do
      Shade::Palette.new do |p|
        Color::RGB.send(:__by_name).keys.each do |color|
          p.add(color)
        end
      end
    end
    it 'finds the best white' do
      subject.nearest_value("#fff").must_equal Shade::Palette::Value.new('white')
    end
    it 'finds the nearest turquoise' do
      subject.nearest_value("#00B7AF").must_equal Shade::Palette::Value.new('lightseagreen')
    end
    it 'finds the nearest ferrari red' do
      subject.nearest_value("#FF2800").must_equal Shade::Palette::Value.new('red')
    end
  end
  describe 'Fuschias' do
    let(:subject) { Shade::Palette.new { |p| %w(#FF367E #E03894 #B6388B #CE3E7C).each { |ea| p.add(ea) } } }
    it 'finds the most similar fuschia' do
      subject.nearest_value('#E14BAC').must_equal Shade::Palette::Value.new('#E03894')
      subject.nearest_value_cie94('#E14BAC').must_equal Shade::Palette::Value.new('#E03894')
    end
  end
end

require 'optparse'

module Shade
  class CLI
    def initialize(argv)
      @verbose = false
      @palette_files = []
      @inputs = option_parser.parse!(argv)

      if palette.empty?
        puts 'No colors are in the target palette. Please provide at least one valid --palette file.'
        puts option_parser
        exit 1
      end
    end

    def convert_files(files = @inputs)
      files.each do |file|
        File.foreach(file) do |line|
          m = COLOR_VAR_RE.match(line)
          if m
            var_name, css_color = m.captures
            good = palette.nearest_value(css_color)
            puts "Replace all references of @#{var_name} with @#{good.name} because #{good.css_color} is closest to #{css_color}."
          end
        end
      end
    end

    private

    # This assumes colors use a variable name, something like:
    # @deepOrange: #ED4E00;

    COLOR_VAR_RE = /@(\w+):\W*(#\h{3,8}|\w+);/i

    def palette
      @palette ||= read_palette_files(@palette_files)
    end

    def read_palette_files(palette_files)
      p = Shade::Palette.new
      palette_files.each do |ea|
        File.foreach(ea) do |line|
          m = COLOR_VAR_RE.match(line)
          if m
            var_name, css_color = m.captures
            p.add(css_color, var_name)
          end
        end
      end
      p
    end

    def option_parser
      @option_parser ||= OptionParser.new do |opts|
        opts.banner = 'Usage: shade --palette=[LESS-formatted file] [file to translate] ...'
        opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
          @verbose = v
        end
        opts.on('-p', '--palette pallete.less',
          'Read colors from pallete.less as the target palette') do |palette|
          (@palette_files ||= []) << palette
        end
        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit
        end
        opts.on_tail('--version', 'Show version') do
          puts Shade::VERSION
          exit
        end
      end
    end
  end
end

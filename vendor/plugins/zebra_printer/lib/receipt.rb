
## TODO: add text processing logic to escape characters outside of [A-Za-z0-9], consider :, \", (, ), \,
## TODO: add text processing logic to escape apostrophes
## TODO: maintain current x and current y throughout a label process

module ZebraPrinter #:nodoc:

  class Receipt < Label

     # Initialize a new label with height weight and orientation. The orientation
    # can be 'T' for top, or 'B' for bottom
    def initialize(width = 801, height = 800, orientation = 'T', number_of_labels = nil)
      @width = width || 801
      @height = height || 800
      @gap = '050'
      @orientation = orientation || 'T'
      @number_of_labels = number_of_labels || nil
      @left_margin = 35
      @right_margin = 25
      @top_margin = 30
      @bottom_margin = 50
      @line_spacing = 6
      @column_count = 1
      @content_width = @width - (@left_margin + @right_margin)
      @content_height = @height - (@top_margin + @bottom_margin)
      @column_width = @content_width
      @column_height = @content_height
      @column_spacing = 0
      @font_size = 1
      @font_horizontal_multiplier = 1
      @font_vertical_multiplier = 1
      @font_reverse = false
      @output = ""
      header
    end

    def header
      @x = @left_margin
      @y = @top_margin
      @column = 0
      @output << "\nN\n"
      @output << "R#{0}#{','}#{0}\n"
      @output << "Q#{10}#{','}#{0}\n"
      @output << "Z#{@orientation}\n"
    end

    def set_image(filename)
      image_data = File.open(filename, 'rb') { |f| f.read }
      image_size = image_data.size
      @output << "\nN\n"
      @output << 'GK"LOGO"' + "\n"
      @output << 'GK"LOGO"' + "\n"
      @output << 'GM"LOGO"' + "#{image_size}\n"
      @output << "#{image_data}"
    end


    def draw_image(x,y)
       @output << "\nN\n"
       @output << 'GG' + "#{x},#{y}," + '"LOGO"' + "\n"
    end

  end

end

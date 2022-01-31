class CodesController < ApplicationController

    require 'rqrcode'
    require 'uri'

    def new
        @logo = "with"
    end
    
    def create

        code = params[:code]

        @url = code[:url]

        if @url =~ URI::regexp

            qrcode = RQRCode::QRCode.new(@url)

            output_size = 512
        
            qrcode_png = qrcode.as_png(
                  resize_gte_to: false,
                  resize_exactly_to: false,
                  fill: 'white',
                  color: 'black',
                  size: output_size,
                  border_modules: 4,
                  module_px_size: 6,
                  file: nil # path to write
                  )

            puts params[:logo]

            if params[:logo] == "with"
        
                original_logo = ChunkyPNG::Image.from_file("./app/assets/images/logo2.png")
            
                logo = original_logo.resize(output_size / 4, output_size /4)
                
                height = (qrcode_png.dimension.height / 2).floor - (logo.dimension.height / 2).floor
                width  = (qrcode_png.dimension.width  / 2).floor - (logo.dimension.width  / 2).floor
                
                @qr = qrcode_png.compose(logo, width, height)
            
            else

                @qr = qrcode_png

            end

        else

            redirect_to request.referer, alert: "El texto introducido no es una url correcta."
        
        end
    
    end
end

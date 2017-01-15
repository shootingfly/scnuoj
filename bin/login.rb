require 'mini_magick'
require 'nokogiri'
require 'mechanize'
require 'rtesseract'

RTesseract.configure do |config|
    config.processor = "mini_magick"
end

def change(path)
	# img = MiniMagick::Image.open(path)
	# img.resize '200x100'
	# img.colorspace("GRAY")
	# img.monochrome
	str = RTesseract.new(path).to_s
end
puts change("/home/rocky/Pictures/1.jpg")

# def identify(path)
# 	options = {
# 		processor: "mini_magick"
# 	}
# 	img = MiniMagick::Image.new(path)  
# 	img.crop("#{img[:width] - 2}x#{img[:height] - 2}+1+1") #去掉边框（上下左右各1像素）  
# 	img.colorspace("GRAY") #灰度化  
# 	img.monochrome #二值化 
# 	str = RTesseract.new(img.path).to_s
# end

# puts identify("/home/rocky/Pictures/2.png")

# require 'rtesseract'
# require 'mini_magick'

# def parse_price(price_url)
#   img = MiniMagick::Image.open(price_url)
#   img.resize '200x100'   # 放大
#   img.colorspace("GRAY") # 灰度化  
#   img.monochrome         # 去色
#   str = RTesseract.new(img.path).to_s # 识别
#   File.unlink(img.path)  # 删除临时文件
#   if str.nil?
#     puts price_url
#   else
#     price = str.strip.sub(/Y/,'').to_f 
#   end
# end

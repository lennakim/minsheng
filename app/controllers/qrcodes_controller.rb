# encoding: utf-8
require 'rqrcode'
require 'iconv'

class QrcodesController < ApplicationController
  def qrcode
    content = params[:qr_content].to_s
    # Iconv.new("CP852","utf-8",content)
    @qr = generatev_qrcode(content)

    respond_to do |format|
      format.html
      format.png  { render :qrcode => content, :level => :l, :unit => 5, :offset => 5 }
      format.gif  { render :qrcode => content, :level => :l, :unit => 5, :offset => 5 }
      format.jpeg { render :qrcode => content, :level => :l, :unit => 5, :offset => 5 }
    end
  end

private

  def generatev_qrcode content
    RQRCode::QRCode.new(content, :size => 6, :level => :l )
  end
end

# https://github.com/whomwah/rqrcode/issues/3
#CP852 是东欧字符集

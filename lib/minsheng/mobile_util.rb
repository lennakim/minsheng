#encoding: utf-8

module Minsheng
  module MobileUtil
    ## 默认使用4位数的手机校验码
    CODE_LENGTH = 4

    def self.generate_code(len = CODE_LENGTH)
      [*'a'..'z',*'1'..'9'].sample(len).join
    end

    def self.valid_mobile?(mobile)
      mobile && mobile =~ /\A1\d{10}\Z/ ? true : false
    end
  end
end

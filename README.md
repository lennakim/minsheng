##  Welcome to MinSheng


####Use Gem

* Rails框架 [ruby on rails](https://github.com/rails/rails)
* 数据库 [mysql2](https://github.com/brianmario/mysql2)
* 登录注册 [devise](https://github.com/plataformatec/devise)
* 权限和角色 [cancan](https://github.com/ryanb/cancan) [rolify](https://github.com/EppO/rolify)
* 省市区area [china_region_fu](https://github.com/Xuhao/china_region_fu)
* 富文本编辑器 [ckeditor](https://github.com/galetahub/ckeditor)
* 图片处理 [mini_magick](https://github.com/minimagick/minimagick)
* 图片上传 [carrierwave](https://github.com/carrierwaveuploader/carrierwave)
* 表树形结果的方式存储 [ancestry](https://github.com/stefankroes/ancestry)
* 禁止assets日志请求 [quiet_assets](https://github.com/evrone/quiet_assets)
* 分页 [kaminari](https://github.com/amatsuda/kaminari)
* 配置rails的插件：[rails_config](https://github.com/railsjedi/rails_config)
  >new a file: /config/settings.local.yml
  >
  >puts config content as below:
  >
  >database:
    >username: root
    >
    >password: "123456"

* 读取服务端的验证逻辑并生成对应的客户端验证逻辑[client_side_validations](https://github.com/bcardarella/client_side_validations)
* 基于rails的jquery [jquery-rails](https://github.com/rails/jquery-rails)
* jQuery-UI [jquery-ui-rails](https://github.com/joliss/jquery-ui-rails)
* Timepicker [time-picker](https://github.com/trentrichardson/jQuery-Timepicker-Addon)
* CSS/HTML框架 [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass)
* DOM节点绑定ready事件 [ready-selector](https://github.com/Verba/jquery-readyselector)
* 图片切换 [anything-slider](https://github.com/CSS-Tricks/AnythingSlider)
* 图片预览 放大效果[elevatezoom](https://github.com/elevateweb/elevatezoom) 图片显示[pikachoose](http://www.pikachoose.com/versions/)  注：与elevatezoom结合使用需要修改源码

* rails服务器 [thin](https://github.com/macournoyer/thin)
* V8 JavaScript解释器 [therubyracer](https://github.com/cowboyd/therubyracer)
* UglifyJS JavaScript压缩机 [uglifier](https://github.com/lautis/uglifier)
* Rails默认使用sass代替css [sass-rails](https://github.com/rails/sass-rails)

#####Test Gem
* 模拟数据 [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails)
* 快速启动工具 [launchy](https://github.com/copiousfreetime/launchy)
* 清空数据库 [database_cleaner](https://github.com/bmabey/database_cleaner)
* 描述BDD测试的一个场景 [cucumber-rails](https://github.com/cucumber/cucumber-rails)
* 测试email [email_spec](https://github.com/conradwt/email_spec)
* 行为模拟 [capybara](https://github.com/jnicklas/capybara)
* 行为测试 [rspec-rails](https://github.com/rspec/rspec-rails)


### jquery插件
* 评星插件 [jRating](https://github.com/alpixel/jRating)

rake db:migrate:down VERSION=20130813144732
rake db:migrate:down VERSION=20130830081625
rake db:migrate:down VERSION=20130830105819
更新 然后  rake db:migrate:down VERSION=20130917081621

rake db:migrate:up  VERSION=20130917081621


start web server
./start.sh

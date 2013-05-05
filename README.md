# Kindeditor for Ruby on Rails

Kindeditor is a WYSIWYG javascript editor, visit http://www.kindsoft.net for details.
rails_kindeditor will helps your rails app integrate with kindeditor, includes images and files uploading.

<img src="https://github.com/Macrow/rails_kindeditor/raw/master/screenshots/rails_kindeditor.png" alt="rails_indeditor">

## Installation and usage

### Add this to your Gemfile

```ruby
  gem 'rails_kindeditor', '~> 0.3.17'
```

### Run "bundle" command.

```bash
  bundle
```

### Run install generator:

```bash
  rails generate rails_kindeditor:install
```

### Usage:

```ruby
  1. <%= kindeditor_tag :content, 'default content value' %>
     # or <%= kindeditor_tag :content, 'default content value', :width => 800, :height => 300 %>
     # or <%= kindeditor_tag :content, 'default content value', :allowFileManager => false %>
```

```ruby
  2. <%= form_for @article do |f| %>
       ...
       <%= f.kindeditor :content %>
       # or <%= f.kindeditor :content, :width => 800, :height => 300 %>
       # or <%= f.kindeditor :content, :allowFileManager => false %>
       ...
     <% end %>
```
You can use kindeditor's initial parameters as usual, please visit http://www.kindsoft.net/docs/option.html for details.

additionally, rails_kindeditor provides one "simple_mode" parameter for render simple mode quickly.

<img src="https://github.com/Macrow/rails_kindeditor/raw/master/screenshots/simple_mode.png" alt="simple mode">

```ruby
  kindeditor_tag :content, 'default content value', :simple_mode => true
  f.kindeditor_tag :content, :simple_mode => true
  f.input :content, :as => :kindeditor, :input_html => { :simple_mode => true } # simple_form & formtastic
```

That's all.

### Include javascript files at bottom ? Not in the head tag ? How can I load kindeditor correctly ?

For some reasons, you includes javascript files at bottom in your template, rails_kindeditor provides a options for lazyload:

```ruby
  <%= f.kindeditor :content, :window_onload => true %>
```

Warning: Kindeditor will load after all the objects loaded.

## SimpleForm and Formtastic integration

### simple_form:

```ruby
  <%= form.input :content, :as => :kindeditor %>
  # or
  <%= form.input :content, :as => :kindeditor, :label => false, :input_html => { :width => 800, :height => 300 } %>
```
  
### formtastic:

```ruby
  <%= form.input :content, :as => :kindeditor %>
  # or
  <%= form.input :content, :as => :kindeditor, :input_html => { :height => 300 } %>
```

## How to get kindeditor's content

```ruby
  <%= form_for @article do |f| %>
    <%= f.kindeditor :content, :editor_id => 'my_editor' %>
  <% end %>
```

You can get content like this:

```javascript
  // Javascript code
  my_editor.html();
```

## Upload options configuration

When you run "rails generate rails_kindeditor:install", installer will copy configuration files in config/initializers folder.
You can customize some option for uploading. 

```ruby
  # Specify the subfolders in public directory.
  # You can customize it , eg: config.upload_dir = 'this/is/my/folder'
  config.upload_dir = 'uploads'

  # Allowed file types for upload.
  config.upload_image_ext = %w[gif jpg jpeg png bmp]
  config.upload_flash_ext = %w[swf flv]
  config.upload_media_ext = %w[swf flv mp3 wav wma wmv mid avi mpg asf rm rmvb]
  config.upload_file_ext = %w[doc docx xls xlsx ppt htm html txt zip rar gz bz2]

  # Porcess upload image size, need mini_magick
  #     before    => after
  # eg: 1600x1600 => 800x800
  #     1600x800  => 800x400
  #     400x400   => 400x400 # No Change
  # config.image_resize_to_limit = [800, 800]
```

## Save upload file information into database(optional)

rails_kindeditor can save upload file information into database.

### Just run migration generate, there are two ORM options for you: 1.active_record 2.mongoid, default is active_record.

```bash
  rails generate rails_kindeditor:migration
  or
  rails generate rails_kindeditor:migration -o mongoid
```

### The generator will copy model and migration to your application. When you are done, remember run rake db:migrate:

```bash
  rake db:migrate
```

### If you're using mongoid, please add 'gem "carrierwave-mongoid"' in your Gemfile

```ruby
  gem 'carrierwave-mongoid'
```

## License

MIT License.



# Kindeditor for Ruby on Rails 中文文档

Kindeditor是国产的所见即所得javascript富文本编辑器, 访问 http://www.kindsoft.net 获取更多信息.
rails_kindeditor可以帮助你的rails程序集成kindeditor,包括了图片和附件上传功能，文件按照类型、日期进行存储。

## 安装及使用

### 将下面代码加入Gemfile：

```ruby
  gem 'rails_kindeditor', '~> 0.3.17'
```

### 运行"bundle"命令：

```bash
  bundle
```

### 安装Kindeditor，运行下面的代码：

```bash
  rails generate rails_kindeditor:install
```

### 使用方法:

```ruby
  1. <%= kindeditor_tag :content, 'default content value' %>
     # or <%= kindeditor_tag :content, 'default content value', :width => 800, :height => 300 %>
     # or <%= kindeditor_tag :content, 'default content value', :allowFileManager => false %>
```

```ruby
  2. <%= form_for @article do |f| -%>
       ...
       <%= f.kindeditor :content %>
       # or <%= f.kindeditor :content, :width => 800, :height => 300 %>
       # or <%= f.kindeditor :content, :allowFileManager => false %>
       ...
     <% end -%>
```
你可以像往常那样使用kindeditor自身的初始化参数，请访问 http://www.kindsoft.net/docs/option.html 查看更多参数。

另外，rails_kindeditor还额外提供一个"simple_mode"参数，以便快捷使用简单模式的kindeditor。

```ruby
  kindeditor_tag :content, 'default content value', :simple_mode => true
  f.kindeditor_tag :content, :simple_mode => true
  f.input :content, :as => :kindeditor, :input_html => { :simple_mode => true } # simple_form & formtastic  
```
     
完毕！

### 把javascript放在模板最下方，不放在head里面，如何正确加载kindeditor？

有时候，为了加快页面载入速度，也许你会把javascript引用放在template的底部，rails_kindeditor提供了一个参数可以确保正常加载：

```ruby
  <%= f.kindeditor :content, :window_onload => true %>
```

警告：Kindeditor会在页面所有的内容加载完毕后才进行加载，所以需谨慎使用

## SimpleForm与Formtastic集成：

### simple_form:

```ruby
  <%= form.input :content, :as => :kindeditor, :label => false, :input_html => { :width => 800, :height => 300 } %>
```

### formtastic:

```ruby
  <%= form.input :content, :as => :kindeditor %>
  <%= form.input :content, :as => :kindeditor, :input_html => { :height => 300 } %>
```
## 如何获取kindeditor的内容

```ruby
  <%= form_for @article do |f| %>
    <%= f.kindeditor :content, :editor_id => 'my_editor' %>
  <% end %>
```

可通过下面的Javascript代码获取内容:

```javascript
  // Javascript code
  my_editor.html();
```

## 上传图片及文件配置

当你运行"rails generate rails_kindeditor:install"的时候，安装器会将配置文件拷贝到config/initializers文件夹。
你可以配置以下上传选项：

```ruby
  # 指定上传目录，目录可以指定多级，都存储在public目录下.
  # You can customize it , eg: config.upload_dir = 'this/is/my/folder'
  config.upload_dir = 'uploads'

  # 指定允许上传的文件类型.
  config.upload_image_ext = %w[gif jpg jpeg png bmp]
  config.upload_flash_ext = %w[swf flv]
  config.upload_media_ext = %w[swf flv mp3 wav wma wmv mid avi mpg asf rm rmvb]
  config.upload_file_ext = %w[doc docx xls xlsx ppt htm html txt zip rar gz bz2]

  # 处理上传文件，需要mini_magick
  #     处理以前      => 处理以后
  # eg: 1600x1600 => 800x800
  #     1600x800  => 800x400
  #     400x400   => 400x400 # 图片小于该限制尺寸则不作处理
  # config.image_resize_to_limit = [800, 800]
```

## 将上传文件信息记录入数据库（可选）

rails_kindeditor 可以将上传文件信息记录入数据库，以便扩展应用.

### 运行下面的代码，有两项选项：1.active_record 2.mongoid，默认是active_record。

```bash
  rails generate rails_kindeditor:migration
  or
  rails generate rails_kindeditor:migration -o mongoid
```

### 运行下面的代码：

```bash
  rake db:migrate
```

### 如果你使用的是mongoid, 请在你的Gemfile里加入'gem "carrierwave-mongoid"'

```ruby
  gem 'carrierwave-mongoid'
```

## License

MIT License.
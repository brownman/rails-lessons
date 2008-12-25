class MyAdminGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # Directories
      m.directory "app/controllers/my_admin"
      m.directory "app/helpers/my_admin"
      m.directory "app/views/my_admin"
      m.directory "app/views/my_admin/main"
      m.directory "app/views/my_admin/model"
      m.directory "app/views/my_admin/spy"
      m.directory "public/my_admin"
      m.directory "public/my_admin/images"

      # Controllers
      ['common', 'main', 'model', 'spy'].each do |c|
        m.file "controllers/my_admin/#{c}_controller.rb", "app/controllers/my_admin/#{c}_controller.rb" 
      end

      # This is really more of a lib but is kept in controllers/my_admin/
      #   to keep RailsMyAdmin more contained within subfolders.
      m.file "controllers/my_admin/my_admin_tool.rb", "app/controllers/my_admin/my_admin_tool.rb" 

      # Helpers
      ['common', 'main', 'model', 'spy'].each do |h|
        m.file "helpers/my_admin/#{h}_helper.rb", "app/helpers/my_admin/#{h}_helper.rb" 
      end
      
      # MyAdmin Layout
      m.file "views/layouts/my_admin.rhtml", "app/views/layouts/my_admin.rhtml" 
      
      # Main::MyAdmin Views
      ['_ajax', '_includes', 'index', 'main', 'models'].each do |v|
        m.file "views/my_admin/main/#{v}.rhtml", "app/views/my_admin/main/#{v}.rhtml" 
      end

      # Model::MyAdmin Views
      ['_form', 'edit', 'list', 'new'].each do |v|
        m.file "views/my_admin/model/#{v}.rhtml", "app/views/my_admin/model/#{v}.rhtml" 
      end

      # Spy::MyAdmin Views
      ['_single', 'index'].each do |v|
        m.file "views/my_admin/spy/#{v}.rhtml", "app/views/my_admin/spy/#{v}.rhtml" 
      end
      
      # Public Assets (js, css)
      ['my_admin.css', 'my_admin.js'].each do |f|
        m.file "public/my_admin/#{f}", "public/my_admin/#{f}" 
      end

      # Public Images
      ['destroy', 'edit', 'home', 'new'].each do |f|
        m.file "public/my_admin/images/#{f}.png", "public/my_admin/images/#{f}.png" 
      end
      m.file "public/my_admin/images/ajax_indicator.gif", "public/my_admin/images/ajax_indicator.gif" 
      
      #m.readme "USAGE"
    end
  end

end
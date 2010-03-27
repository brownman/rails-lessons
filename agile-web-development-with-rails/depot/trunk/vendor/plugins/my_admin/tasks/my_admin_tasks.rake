
def ma_controllers_dir
  File.join(RAILS_ROOT, "app/controllers/my_admin")
end
def ma_helpers_dir
  File.join(RAILS_ROOT, "app/helpers/my_admin")
end
def ma_views_dir
  File.join(RAILS_ROOT, "app/views/my_admin")
end
def ma_public_dir
  File.join(RAILS_ROOT, "public/my_admin")
end

# A Hash mapping Rails paths of MyAdmin folders to their respective template path
#   in the plugins/my_admin/generators/my_admin/templates/ directory.
MY_ADMIN_DIRS = {
                ma_controllers_dir   => 'controllers/my_admin',
                ma_helpers_dir       => 'helpers/my_admin',
                ma_views_dir         => 'views/my_admin',
                ma_public_dir        => 'public/my_admin'
                }

GREP_PATTERN = "**/*.{rb,rhtml,css,js,png,gif}"

def my_admin_directories
  MY_ADMIN_DIRS.keys
end

def templates_dir
  File.join(File.dirname( __FILE__ ), '../generators/my_admin/templates')
end

namespace :my_admin do

  desc '(just a stub) To setup RailsMyAdmin, run the generator:   ruby script/generate my_admin'
  task :setup => :environment do
    puts "To setup RailsMyAdmin, run the generator:   ruby script/generate my_admin"
    puts "  The generator will copy MyAdmin files from the generator's template directory over to your application's app/ and public/ folders."
  end
  
  desc 'Clobbers any installed RailsMyAdmin files located in the app/ and public/ folders'
  task :clobber => :environment do
    puts "RAILS_ROOT = #{RAILS_ROOT}"
    # Clobber files
    my_admin_directories.each do |dir|
      next unless File.exists?(dir)
      Dir.chdir(dir) do 
        files = Dir[GREP_PATTERN]
        files.compact!
        files.flatten!
        files.each do |f|
          app_path = File.join(dir, f)
          if File.exists?(app_path)
            File.unlink(app_path)
            readable_path = app_path.sub("#{RAILS_ROOT}/", '')
            puts "Clobbered: #{readable_path}"
          end
        end
      end
    end

    # Clobber directories
    Dir.delete(ma_controllers_dir) if File.exists?(ma_controllers_dir)
    Dir.delete(ma_helpers_dir) if File.exists?(ma_helpers_dir)
    ['main', 'model', 'spy'].each do |dir|
      path = File.join(ma_views_dir, dir)
      Dir.delete(path) if File.exists?(path)
    end
    Dir.delete(ma_views_dir) if File.exists?(ma_views_dir)

    img_path = File.join(ma_public_dir, 'images')
    Dir.delete(img_path) if File.exists?(img_path)
    Dir.delete(ma_public_dir) if File.exists?(ma_public_dir)
  end
  
  desc 'This will print out the svn commands you can use to add RailsMyAdmin folders to your project (silly, but convenient)'
  task :print_svn => :environment do
    svn = "svn"
    my_admin_directories.each do |dir|
      cmd = "#{svn} add --force #{dir}"
      puts "#{cmd}"
      # Note: You can try uncommenting this to actually run the commands, but it wasn't working for me. -SAB
      #`#{cmd}`
    end
  end
  
  namespace :dev do
    desc 'Used by RailsMyAdmin devs -- or, if you want to copy changes made to MyAdmin files in your core app, back over to the plugin folder'
    task :sync_to_plugin => :environment do
        
      my_admin_directories.each do |dir|
        Dir.chdir(dir) do 
          files = Dir[GREP_PATTERN]
          files.compact!
          files.flatten!
          #puts "files = #{files.inspect}"
          files.each do |f|
            app_path = File.join(dir, f)
            new_path = File.join(templates_dir, MY_ADMIN_DIRS[dir], f)
            #puts "APP: #{app_path}"
            #puts "PLUGIN: #{new_path}"
            puts "Synced: #{new_path}"
            File.copy(app_path, new_path)
          end
        end
      end
    end
  end
  
end
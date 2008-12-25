MODEL_DIR = File.join(RAILS_ROOT, "app/models")

module MyAdminTool
  
  # Get Model Names & Classes Code originally via the 'annotate_models' plugin:
  #  http://www.agilewebdevelopment.com/plugins/annotate_models
  def self.get_model_names
    models = []
    Dir.chdir(MODEL_DIR) do 
      models = Dir["**/*.rb"]
    end
    return models
  end
  
  def self.get_model_classes
    klasses = []

    if !MY_ADMIN_GLOBALS[:all_models]
      # Restrict models to only those defined in MY_ADMIN_MODELS
      return MY_ADMIN_MODELS || []
    end
    
    self.get_model_names.each do |m|
      class_name = m.sub(/\.rb$/,'').camelize
      klass = class_name.split('::').inject(Object){ |klass,part| klass.const_get(part) } rescue nil 
      if klass.nil?
        klass = class_name.split('::')[1].inject(Object){ |klass,part| klass.const_get(part) } rescue nil 
      end
    
      if klass && klass < ActiveRecord::Base
        klasses << klass
      end
    end
    return klasses
  end
end


class MyAdmin::MainController < MyAdmin::CommonController
  
  layout 'my_admin', :except => ['models', 'main']
  
  before_filter :collect_models, :only => [:models, :main]
  
  def index
  end
  
  def models
  end
  
  def main
  end

private
  
  def collect_models
    if MY_ADMIN_GLOBALS[:all_models]
      @models = MyAdminTool.get_model_classes
    else
      @models = MY_ADMIN_MODELS
      # Delete any undefined models (i.e. the model is in the list but has since been removed from the models/ folder)
      @models.delete_if { |m| !defined?(m) }
    end
    @models.sort!{|x,y| x.to_s <=> y.to_s } if @models
  end
  
end

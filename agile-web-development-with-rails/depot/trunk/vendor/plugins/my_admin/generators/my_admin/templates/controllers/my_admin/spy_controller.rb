class MyAdmin::SpyController < MyAdmin::CommonController
  include ActionView::Helpers::TextHelper
  layout nil

  before_filter :set_class, :only => ['index', 'update']
  
  def index
    @models = @klass.find(:all, :order => 'created_at DESC', :limit => 10)
  end
  
  # AJAX Spy based on: http://seanmountcastle.com/2006/04/14/ajax-spy-in-rails/
  def update
    last_update = Time.parse(params[:timestamp])
    #   locate all of the entries created since the last update
    @models = @klass.find(:all, :order => 'created_at ASC', :conditions => [ 'created_at > ?', last_update.to_s(:db) ])
    if !@models.empty?
      render :update do |page|
        for @model in @models
          page.insert_html(:top, 'spy-list', :partial => 'single', :locals => {:klass => @klass, :model => @model})
          page.visual_effect :highlight, "m-#{@model.id}", :duration => 1.8
        end
      end
    else
      render :nothing => true and return
    end
  end
end

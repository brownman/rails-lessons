class MyAdmin::CommonController < ApplicationController
  # A common controller for other MyAdmin Controllers to inherit from, to enable method sharing
  before_filter :secure_it
  
  # Over-write this method with your own custom security filter
  def secure_it
    return true if RAILS_ENV == 'development'
    if MY_ADMIN_AUTH.is_a?(Proc)
      return MY_ADMIN_AUTH.call(self)
    else
      return false
    end
  end
  
protected
  
  def set_class
    #puts params.inspect
    if params[:model] && !params[:model].blank?
      begin
        @klass = params[:model].constantize
      rescue
        # Invalid Model
      end
    end
    if !@klass
      render :text => "<h2>Invalid Model Class: #{params[:model]}", :status => 400 and return false
    else
      @klass_name = readable_class_name(@klass)
    end
    return true
  end
  
  def confirm_destroy
    MY_ADMIN_GLOBALS[:confirm_destroy] || false
  end
  helper_method :confirm_destroy
  
  def readable_class_name(klass)
    klass = Inflector.humanize(Inflector.underscore(klass.to_s))
    return capitalize_each(klass)
  end
  helper_method :readable_class_name

  def capitalize_each(str)
    str.split(' ').each{|word| word.capitalize!}.join(' ')
  end
  helper_method :capitalize_each
    
end
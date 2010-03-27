class MyAdmin::ModelController < MyAdmin::CommonController
  include ActionView::Helpers::TextHelper
  layout nil

  before_filter :set_class, :only => [:show, :list, :new, :edit, :create, :update, :in_place_update, :lookup, :destroy, :destroy_all]
  
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :in_place_update, :destroy_all ],
         :render => {:text => 'Method must be called with POST.' }
  
  def show
  end
  
  def list
    @pages, @models = paginate @klass.to_s, :per_page => 10
  end
  
  def new
    @model = @klass.new
  end
  
  def edit
    @model = @klass.find(params[:id]) rescue nil
    if @model.nil?
      render :text => "<h2>#{@klass_name} Not Found: #{params[:id]}</h2>", :status => 404 and return
    end
  end
  
  def update
    @model = @klass.find(params[:id]) rescue nil
    model_name_underscored = Inflector.underscore(@klass.to_s)
    model_attrs = params[model_name_underscored]
    @model.update_attributes(model_attrs)
    flash[:notice] = "#{@klass_name} Updated"
    redirect_to :action => 'edit', :id => @model.id, :model => @klass.to_s
  end
  
  def create
    model_name_underscored = Inflector.underscore(@klass.to_s)
    model_attrs = params[model_name_underscored]
    @model = @klass.create(model_attrs)
    if @model.new_record?
      flash[:notice] = "#{@klass_name} could not be saved"
      render :action => 'new' and return
    else
      flash[:notice] = "#{@klass_name} Created"
      redirect_to :action => 'edit', :id => @model.id, :model => @klass.to_s and return
    end
  end
  
  def lookup
    query = params[:query]
    col_name = params[:column_name]

    results = @klass.find(:all, :conditions => ["#{col_name} = ?", query])
    
    if results.empty?
      # Now try a broader match
      results = @klass.find(:all, :conditions => ["#{col_name} LIKE ?", "%#{query}%"])
    end
    
    if results.size == 1
      redirect_to :action => 'edit', :id => results.first.id, :model => @klass.to_s and return
    elsif results.size > 1
      @models = results
      @pages = Paginator.new self, results.size, 10, params['page']
      render :action => 'list'
    else
      # No results found
      render :text => "<h2>No #{@klass_name}s found on #{col_name} matching \"#{params[:query]}\"</h2>", :status => 404 and return
    end
    
  end
  
  def destroy
    m = @klass.find(params[:id]) rescue nil
    if m
      m.destroy
      notice = "#{@klass_name} destroyed."
    else
      notice = "Could not find model with ID: #{params[:id]}"
    end
    render :update do |page|
      page << "Notice.show('<h2>#{notice}</h2>');"
      page.visual_effect :fade, "m-#{params[:id]}", :duration => 0.5
    end
  end
  
  def destroy_all
    result = @klass.destroy_all
    notice = "#{pluralize(result.size, @klass_name)} destroyed"
    render :update do |page|
      page << "Notice.show('<h2>#{notice}</h2>');"
    end
  end
  
  ## AJAX METHODS

  def in_place_update
    @model = @klass.find(params[:id]) rescue nil
    if @model && params[:field]
      @model.send("#{params[:field]}=", params[:value])
      @model.save
      render_text @model.send(params[:field]) and return
    end
    # On Error (invalid params, etc):
    render :nothing => true, :status => 400 and return
  end
  
  
end

class SubdocsController < ApplicationController
  #@document_urn = params[:document_urn] 
  # GET /subdocs
  # GET /subdocs.xml
  def index
    @subdocs = Subdoc.paginate :page => params[:page], :order => 'document_urn, label'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subdocs }
    end
  end

  # GET /subdocs/1
  # GET /subdocs/1.xml
  def show
    @subdoc = Subdoc.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subdocs }
    end
  end

  # GET /subdocs/new
  # GET /subdocs/new.xml
  def new
    @subdoc = Subdoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subdoc }
    end
  end

  # GET /subdocs/1/edit
  def edit
    @subdoc = Subdoc.find(params[:id])
  end

  # POST /subdocs
  # POST /subdocs.xml
  def create
    @subdoc = Subdoc.new(params[:subdoc])

    respond_to do |format|
      if @subdoc.save
        flash[:notice] = 'Subdoc was successfully created.'
        format.html { redirect_to(@subdoc) }
        format.xml  { render :xml => @subdoc, :status => :created, :location => @subdoc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subdoc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subdocs/1
  # PUT /subdocs/1.xml
  def update
    @subdoc = Subdoc.find(params[:id])

    respond_to do |format|
      if @subdoc.update_attributes(params[:subdoc])
        flash[:notice] = 'Subdoc was successfully updated.'
        format.html { redirect_to(@subdoc) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subdoc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subdocs/1
  # DELETE /subdocs/1.xml
  def destroy
    @subdoc = Subdoc.find(params[:id])
    @subdoc.destroy

    respond_to do |format|
      format.html { redirect_to(subdocs_url) }
      format.xml  { head :ok }
    end
  end
  
 def list
  @subdocs = Subdoc.find_all_by_document_urn(params[:document_urn], :order => "label")
  respond_to do |format|
     format.html do
         render :layout => false
       end
    format.xml  { render :xml => @subdocs }
  end
 end

end

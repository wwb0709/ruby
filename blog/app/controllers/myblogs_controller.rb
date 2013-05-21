class MyblogsController < ApplicationController
  
  
  # http_basic_authenticate_with :name => "dhh", :password => "secret", :except => [:index, :show]
  
  # GET /myblogs
  # GET /myblogs.json
  def index
    # @myblogs = Myblog.all
     @myblogs = Myblog.paginate :page => params[:page],:per_page => 1 
 #     @pages, @myblogs = paginate_collection(@myblogs, :page => params[:page])  
#       
# Article.find(:all,:order=>'id desc').paginate :page=>params[:page]||1,:per_page=>3
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @myblogs }
    end
  end

  # GET /myblogs/1
  # GET /myblogs/1.json
  def show
    @myblog = Myblog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @myblog }
    end
  end

  # GET /myblogs/new
  # GET /myblogs/new.json
  def new
    @myblog = Myblog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @myblog }
    end
  end

  # GET /myblogs/1/edit
  def edit
    @myblog = Myblog.find(params[:id])
  end

  # POST /myblogs
  # POST /myblogs.json
  def create
    @myblog = Myblog.new(params[:myblog])
     @myblog.myfile=uploadFile(params[:myblog]['myfile'])   
    # uploaded_io = params[:myblog][:myfile]  
    # 
    #  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|  
    #    file.write(uploaded_io.read)  
    #  end  
     
    respond_to do |format|
      if @myblog.save
        format.html { redirect_to @myblog, notice: 'Myblog was successfully created.' }
        format.json { render json: @myblog, status: :created, location: @myblog }
      else
        format.html { render action: "new" }
        format.json { render json: @myblog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /myblogs/1
  # PUT /myblogs/1.json
  def update
    @myblog = Myblog.find(params[:id])

    respond_to do |format|
      if @myblog.update_attributes(params[:myblog])
        format.html { redirect_to @myblog, notice: 'Myblog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @myblog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myblogs/1
  # DELETE /myblogs/1.json
  def destroy
    @myblog = Myblog.find(params[:id])
    @myblog.destroy

    respond_to do |format|
      format.html { redirect_to myblogs_url }
      format.json { head :no_content }
    end
  end
end

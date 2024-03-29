class Admin::CategoriesController < Admin::BaseController
  before_filter :admin_only, :except => :show

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(ancestry: nil).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @parent_id = params[:parent_id]
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.insert(params[:category][:parent_id])
        _pre_path =  params[:category][:parent_id].blank? ? admin_categories_path :
          children_admin_category_path(@category.parent)
        format.html { redirect_to _pre_path, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_category_path(@category), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    parent_category = @category.parent
    _pre_path = parent_category.nil? ? admin_categories_path :
      children_admin_category_path(parent_category)
    @category.destroy

    respond_to do |format|
      format.html { redirect_to _pre_path }
      format.json { head :no_content }
    end
  end

  def children
    @category_id = params[:id]
    @parent_category = Category.find(@category_id)
    @categories = Category.find(@category_id).children.page(params[:page])
    render 'index'
  end
end

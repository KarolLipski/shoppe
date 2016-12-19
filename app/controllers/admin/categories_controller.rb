class Admin::CategoriesController < AdminController
  before_action :set_category, only: [:edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.main.order(:name).includes(:subcategories)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html {
          flash[:success] = 'Categoria została dodana'
          redirect_to admin_categories_path, notice: 'Category was successfully created.'
        }
        format.json { render json: @category, status: :created }
      else
        format.html {
          flash.now[:danger] = 'Błąd'
          render :new
        }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html {
          flash[:success] = 'Categoria została zmieniona'
          redirect_to admin_categories_path, notice: 'Category was successfully updated.'
        }
        format.json { render json: @category, status: :ok }
      else
        format.html {
          flash.now[:danger] = 'Błąd'
          render :edit
        }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :parent_id)
    end
end

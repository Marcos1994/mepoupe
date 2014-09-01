class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = current_user.categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
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
		@category.user = current_user
		if(category_params[:titulo] == "Geral")
			@category.titulo = "Geral (nova)"
		end
		respond_to do |format|
			if @category.save
				format.html { redirect_to @category, notice: 'Category criada com sucesso!' }
				format.json { render :show, status: :created, location: @category }
			else
				format.html { render :new }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /categories/1
	# PATCH/PUT /categories/1.json
	def update
		if (@category.titulo != "Geral")
			respond_to do |format|
				if @category.update(category_params)
					format.html { redirect_to @category, notice: 'Categoria atualizada com sucesso.' }
					format.json { head :no_content }
				else
					format.html { render action: 'edit' }
					format.json { render json: @category.errors, status: :unprocessable_entity }
				end
			end
		end
	end

  # DELETE /categories/1
  # DELETE /categories/1.json
	def destroy
		if (@category.titulo != "Geral")
			@category.destroy
			respond_to do |format|
				format.html { redirect_to categories_url, notice: 'Categoria apagada com sucesso!' }
				format.json { head :no_content }
			end
		else
			respond_to do |format|
				format.html { redirect_to categories_url, notice: 'Essa categoria nao pode ser destruida!' }
				format.json { head :no_content }
			end
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:titulo, :cor, :descricao, :user_id)
    end
end

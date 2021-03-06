class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.all
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  # GET /parts/new
  def new
    @part = Part.new
  end

  # GET /parts/1/edit
  def edit
  end

  # POST /parts
  # POST /parts.json
	def create(part_params)
		@part = Part.new(part_params)
		@part.save
	end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to @part, notice: 'Parcela atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @part.entry }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
	def destroy
		@part.destroy
		respond_to do |format|
			format.html { redirect_to parts_url, notice: 'Part was successfully destroyed.' }
			format.json { head :no_content }
		end
	end
  
	def efetivar
		@part = Part.find(params[:id])
		@category = @part.entry.category
		@entry = @part.entry
		@part.confirmacao = 1
		respond_to do |format|
			if @part.save 
				format.js
				format.html{ redirect_to parts_url, notice: "Parcela efetivado com sucesso." }
				format.json{ render action: 'show', status: :updated, location: @part }
			end
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:valor, :data, :confirmacao)
    end
end

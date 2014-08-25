class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
	def index
		#@entries = Entry.all
		@entries = nil
		cat = current_user.categories
		if(cat.length >= 1)
			@entries = cat[0].entries
			for i in (2..cat.length) do
				@entries += cat[i-1].entries
			end
		end
		@entries
	end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
	def create
		entry_val = { :titulo => params[:titulo], :tipo => entry_params[:tipo], :category_id => entry_params[:category_id], :periodicidade => entry_params[:periodicidade], :descricao => entry_params[:descricao]}
		@entry = Entry.new(entry_val)
		
		parcelas = params[:parcelas].to_i
		if((entry_params[:periodicidade] != "1") || parcelas < 1)
			parcelas = 1
		end
		
		for i in (1..parcelas) do
			params_part = { :valor => params[:valor], :data => Date.today, :confirmacao => params[:confirmacao], :entry_id => @entry.id }
			#params_part = { :valor => params[:valor], :data => params[:data], :confirmacao => params[:confirmacao], :entry_id => @entry.id }
			@part = Part.new(params_part)
			@entry.parts << @part
		end
		
		respond_to do |format|
		if @entry.save	#Salva o lançamento e todas as parcelas (autosave: true)
			format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
			format.json { render :show, status: :created, location: @entry }
		else
			format.html { render :new }
			format.json { render json: @entry.errors, status: :unprocessable_entity }
		end
		end
	end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:titulo, :descricao, :tipo, :periodicidade, :category_id)
    end
end

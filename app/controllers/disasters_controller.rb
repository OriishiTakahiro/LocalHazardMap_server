class DisastersController < ApplicationController
  before_action :set_disaster, only: [:show, :edit, :update, :destroy]

	def getList
		render :json => {:list => Disaster.all.map{|disaster| [disaster.id, disaster.name, disaster.description]}}
	end

	def register
		dis = Disaster.new
		dis.name = params[:name]
		dis.description = params[:description]
		dis.save
		render :json => {:id => dis.id}
	end

  # GET /disasters
  # GET /disasters.json
  def index
    @disasters = Disaster.all
  end

  # GET /disasters/1
  # GET /disasters/1.json
  def show
  end

  # GET /disasters/new
  def new
    @disaster = Disaster.new
  end

  # GET /disasters/1/edit
  def edit
  end

  # POST /disasters
  # POST /disasters.json
  def create
    @disaster = Disaster.new(disaster_params)

    respond_to do |format|
      if @disaster.save
        format.html { redirect_to @disaster, notice: 'Disaster was successfully created.' }
        format.json { render :show, status: :created, location: @disaster }
      else
        format.html { render :new }
        format.json { render json: @disaster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disasters/1
  # PATCH/PUT /disasters/1.json
  def update
    respond_to do |format|
      if @disaster.update(disaster_params)
        format.html { redirect_to @disaster, notice: 'Disaster was successfully updated.' }
        format.json { render :show, status: :ok, location: @disaster }
      else
        format.html { render :edit }
        format.json { render json: @disaster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disasters/1
  # DELETE /disasters/1.json
  def destroy
    @disaster.destroy
    respond_to do |format|
      format.html { redirect_to disasters_url, notice: 'Disaster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disaster
      @disaster = Disaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disaster_params
      params.require(:disaster).permit(:name, :description)
    end
end

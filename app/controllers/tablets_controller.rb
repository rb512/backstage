class TabletsController < ApplicationController
  before_filter :authenticate_admin_user!
  # GET /tablets
  # GET /tablets.json
  def index
    current_admin_user
    @tablets = Tablet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tablets }
    end
  end

  # GET /tablets/1
  # GET /tablets/1.json
  def show
    current_admin_user
    @tablet = Tablet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tablet }
    end
  end

  def assign
    current_admin_user
    # restaurants = Restaurant.all
    # @restaurants = []
    # restaurants.each {|restaurant| @restaurants << restaurant.name }
    @restaurants = Restaurant.all
  end

  def assign_tablets
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #{params}"
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! RESTAURANT ID #{params["assign_tablets"]["restaurant_id"]}"
    restaurant_id = params["assign_tablets"]["restaurant_id"]
    restaurant = Restaurant.find(restaurant_id.to_i)
    tablets = params["assign_tablets"]["number_of_tablets"]
    @tablets = Tablet.where(:restaurant_id => nil).limit(tablets)
    updated = false
    errors = {}
    @tablets.each do |tablet|
      if tablet.update_attributes(:owner_id => restaurant.owner_id, :restaurant_id => restaurant.id)
        updated = true
      else
        updated = false
        errors = tablet.errors
      end
    end
    respond_to do |format|
      if updated
        format.html { redirect_to root_path, notice: 'Tablet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "assign" }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  
  def show_assignment
    
  end
  
  # GET /tablets/new
  # GET /tablets/new.json
  def new
    current_admin_user
    @tablet = Tablet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tablet }
    end
  end

  # GET /tablets/1/edit
  def edit
    current_admin_user
    @tablet = Tablet.find(params[:id])
  end

  # POST /tablets
  # POST /tablets.json
  def create
    current_admin_user
    @tablet = Tablet.new(params[:tablet])

    respond_to do |format|
      if @tablet.save
        format.html { redirect_to @tablet, notice: 'Tablet was successfully created.' }
        format.json { render json: @tablet, status: :created, location: @tablet }
      else
        format.html { render action: "new" }
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tablets/1
  # PUT /tablets/1.json
  def update
    current_admin_user
    @tablet = Tablet.find(params[:id])

    respond_to do |format|
      if @tablet.update_attributes(params[:tablet])
        format.html { redirect_to @tablet, notice: 'Tablet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tablets/1
  # DELETE /tablets/1.json
  def destroy
    current_admin_user
    @tablet = Tablet.find(params[:id])
    @tablet.destroy

    respond_to do |format|
      format.html { redirect_to tablets_url }
      format.json { head :no_content }
    end
  end
  
  
end

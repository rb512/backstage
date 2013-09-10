class MenusController < ApplicationController
  before_filter :authenticate_admin_user!
  # GET /menus
  # GET /menus.json

  def index
    @current_admin_user = current_admin_user
    @menus = Menu.all
    @title = "Menus"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @current_admin_user = current_admin_user    
    @menu = Menu.find(params[:id])
    @menu_items = @menu.menu_items
    @title = @menu.name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => {:menu => @menu, :menu_items => @menu_items} }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @current_admin_user = current_admin_user
    session[:menu_params] ||= {}
    @title = "New Menu"
    @menu = Menu.new(session[:menu_params])
    @categories = @menu.categories
    @menu.current_step = session[:menu_step]
  end

  # GET /menus/1/edit
  def edit
    @current_admin_user = current_admin_user
    session[:menu_update_params] ||= {}
    @menu = Menu.find(params[:id])
    @title = @menu.name
    @categories = @menu.categories
    session[:menu_id] = @menu.id
    session[:menu_step] = @menu.current_step
  end

  # POST /menus
  # POST /menus.json
  def create
    @current_admin_user = current_admin_user
    session[:menu_params].deep_merge!(params[:menu]) if params[:menu]
    @menu = Menu.new(session[:menu_params])
    @categories = @menu.categories
    @menu.current_step = session[:menu_step]
    @selected_type = @menu.menu_type
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #{@selected_type}"
    if params[:back_button]
      @menu.previous_step
    elsif @menu.last_step?
      @menu.save
    else
      @menu.next_step
    end
    session[:menu_step] = @menu.current_step
    if @menu.new_record?
      render "new"
    else
      session[:menu_steps]=session[:menu_params] = nil
      redirect_to @menu, notice: "Menu was successfully created."
    end
  end

 
  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:id])
    @title = @menu.name
    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def destroy_menu_item
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:menu_id])
    @menu_item = @menu.menu_items.find(params[:id])
    @menu_item.destroy
    respond_to do |format|
      format.html {redirect_to @menu}
      format.json {head :no_content}
    end
  end
  
  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
      format.js
    end
  end
  
  def daily_special
    
  end
  
  private
  def get_categories(menu)
    categories = []
    menu.categories.each {|category| categories << category.name}
  end
    
end

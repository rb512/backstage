class MenuItemsController < ApplicationController
  before_filter :authenticate_admin_user!


  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:menu_id])
    @menu_item = @menu.menu_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu_item }
    end
  end

  def new
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:menu_id])
    @menu_item = @menu.menu_items.new
    @categories = get_categories(@menu)
  end

  # GET /menu_items/1/edit
  def edit
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:id])
    @menu_item = @menu.menu_items.find(params[:menu_id])
    @categories = get_categories(@menu)
  end

  def create
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:menu_item][:menu_id])
    @menu_item = @menu.menu_items.new(params[:menu_item])
    @categories = get_categories(@menu)
    respond_to do |format|
      if @menu_item.save
        format.html {redirect_to menu_path(@menu_item.menu), notice: "Menu item was successfully added."}
        format.json {head :no_content}
      else
        format.html {render action: "new"}
        format.json {render json: @menu_item.errors, status: :unprocessable_entity}
      end
    end
  end
  # PUT /menu_items/1
  # PUT /menu_items/1.json
  def update
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:menu_item][:menu_id])
    @menu_item = @menu.menu_items.find(params[:id])
    @categories = get_categories(@menu)
    respond_to do |format|
      if @menu_item.update_attributes(params[:menu_item])
        format.html { redirect_to menu_path(@menu_item.menu), notice: 'Menu item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  
  def destroy
    @current_admin_user = current_admin_user
    @menu = Menu.find(params[:id])
    @menu_item = @menu.menu_items.find(params[:menu_id])
    @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to menu_path(@menu_item.menu) }
      format.json 
    end
  end
  
  private
  def get_categories(menu)
    categories = []
    menu.categories.each {|category| categories << category.name}
  end
end

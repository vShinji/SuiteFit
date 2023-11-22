class ItemsController < ApplicationController
  # Inserted a authorization policy in front of each method as a reminder.
  # When writing the method, put it before saving to the database.
  def index
    @item = Item.new
    @items = policy_scope(Item)
  end

  def show
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    @item.user = current_user
    if @item.save
      redirect_to items_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
    authorize @item
  end

  def destroy
    authorize @item
  end

  private

  def item_params
    params.require(:item).permit(:name, :length, :width, :icon, :quantity)
  end
end

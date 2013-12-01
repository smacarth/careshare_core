class InventoriesController < ApplicationController
  def create
    pill = Pill.find(params[:pill])
    Inventory.create(:pill => pill, :prescription_date => params[:date],
                     :number_of_pills => params[:pills], :refills => params[:refills])     
  end
  
  def show
    inventory = Inventory.find(params[:inventory])
    render json :inventory
  end
end
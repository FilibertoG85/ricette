class RecipesController < ApplicationController

  before_action :verifica_utente, except: [:show]

  def index
    @recipes = current_user.recipes
    @recipe = current_user.recipes.build
    if params[:id].present?
      @recipe = current_user.recipes.find(params[:id])
    end
  end

  def new
    @recipe = current_user.recipes.build
    redirect_to :recipes
  end

  def create
    recipe = Recipe.new(params_valid)
    recipe.user = current_user
    if recipe.save
        flash[:notice] = "Ricetta salvata "
        redirect_to :recipes
    else
        flash[:alert] = "Parametri non validi"
        redirect_to :recipes
    end
  end

  def update
#    Rails.logger.info valid_update_params
    @recipe = current_user.recipes.find(params[:id])
    if @recipe
      @recipe.update(valid_update_params)
      flash[:notice] = "Ricetta aggiornata!"
    else
      flash[:alert] = "Ricetta inesistente!"
    end
    redirect_to :recipes
  end

  def destroy
    recipe = current_user.recipes.find(params[:id])
    if recipe
      recipe.destroy
      flash[:notice] = "Ricetta eleminata"
    else
      flash[:alert] = "Ricetta da eliminare non trovata!"
    end
    redirect_to :recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

private

  def verifica_utente
    redirect_to root_path unless current_user
  end

  def params_valid
    params.require(:recipe).permit(:image, :name, :description)
  end

  def valid_update_params
    params.require(:id)
    params.require(:recipe).permit(:image, :name, :description)
  end

end


class WelcomeController < ApplicationController
  def index
    @ricette_settimanali = Recipe.ricette_settimanali
    @ricetta_della_settimana = Recipe.ricetta_della_settimana
  end

  def about
  end

end

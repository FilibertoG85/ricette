class UsersController < ApplicationController
  def new
  end

  def create
    # 1. Definire i parametri che deve accettare
    # 2. Creare una nuova istanza di User con i parametri ricevuti
    # 3. Verificare che l'istanza creata sia valida
    #   3.1 Se l'istanza NON e' valida
    #     3.1.1 Avvisiamo l'utente con un messaggio
    #     3.1.2 Ritorniamo a /signup
    #   3.2 Se l'istanza E' valida
    #     3.2.1 Salviamo l'istanza
    #     3.2.2 Se il salvataggio e' andato a buon fine, avvisiamo l'utente e lo
    #           reindirizziamo alla /
    #     3.2.3 Se il salvataggio non e' andato a buon fine, avvisiamo l'utente e lo
    #           reindirizziamo a /signup

    parametri = parametri_validi_creazione

    flash[:alert]="Nome assente!" and redirect_to signup_path and return unless parametri[:name].present?
    flash[:alert]="Email assente!" and redirect_to signup_path and return unless parametri[:email].present?
    flash[:alert]="Password assente!" and redirect_to signup_path and return unless parametri[:password].present?

    utente = User.new(parametri)
    if !utente.valid?
      flash[:alert] = "Parametri non validi"
      redirect_to signup_path
    else
      begin
        utente.save
        flash[:notice] = " Registrazione completata"
      rescue
        flash[:alert] = "Registrazione fallita!"
      end
      redirect_to root_path
    end
  end

private

  def parametri_validi_creazione
    params.require(:user).permit(:name, :password, :email, :password_confirmation)
  end

end

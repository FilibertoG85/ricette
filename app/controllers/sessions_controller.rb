class SessionsController < ApplicationController
  def new
  end

  def create
    # 1. Definire quali siano i parametri che possiamo accettare
    # 2. Recuperare l'utente dal database per mezzo del campo 'email'
    # 3. Se l'utente esiste, dobbiamo verificare che la password sia corretta
    #   3.1 Se la password e' corretta:
    #       3.1.1 Diamo una notifica all'utente
    #       3.1.2 Ridirigiamo l'utente alla pagina iniziale
    #   3.2 Se la password non e' corretta, o l'utente non e' stato trovato:
    #       3.2.1 Diamo una notifica dell'errore all'utente
    #       3.2.2 Ridirigiamo l'utente alla pagina di login
    #utente = User.where(email: parametri_creazione_sessione[:email]).first

    utente = User.find_by(email: parametri_creazione_sessione[:email]).try(:authenticate, parametri_creazione_sessione[:password])

    if utente
        session[:user_id] = utente.id
        flash[:notice] = "Accesso eseguito con successo"
        redirect_to '/'
    else
        session[:user_id] = nil
        flash[:alert] = "Accesso fallito!"
        redirect_to '/login'# Password sbagliatia
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Arrivederci!"
    redirect_to '/'
  end

private

  def parametri_creazione_sessione
    params.require(:user).permit(:email, :password)
  end

end

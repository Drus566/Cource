Rails.application.routes.draw do
    root 'application#home'
    get '/', to: 'application#home'
    get '/admin', to: 'application#admin'
end

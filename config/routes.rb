Rails.application.routes.draw do
    root 'application#home'
    get '/', to: 'application#home'
    get '/admin', to: 'application#admin'
    post '/force_update', to: 'application#force_update'

    mount ActionCable.server => '/cable'
end

Rails.application.routes.draw do

  resources :puzzles, only: :show, defaults: { format: :json } do
    collection do
      get ":team/new" => 'puzzles#new'
    end

    get "answer/:answer_id" => 'puzzles#answer'
    get "answer" => 'puzzles#query'
  end
end

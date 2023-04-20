Rails.application.routes.draw do
  get 'predictor/index'
  post 'upload_csv', to: 'race_results#upload_csv'
  get 'upload_csv', to: 'race_results#upload_csv_view'
  root to: 'race_results#upload_csv_view'
end
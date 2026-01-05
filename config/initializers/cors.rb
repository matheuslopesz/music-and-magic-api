Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # ATENÇÃO: Em produção, troque '*' pelo domínio do seu site (ex: 'meublog.com')

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
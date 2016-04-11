OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '31574616497-q7ac9kbl5117rmtuo4ifqrvfjf4bnik1.apps.googleusercontent.com', 'NXP0HXDpisoLSMmb1cpko9DU', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
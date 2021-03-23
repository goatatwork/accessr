# Sidekiq.configure_server do |config|
#   config.redis = {
#     url: 'redis://redis:6379/0',
#     namespace: "proto_#{Rails.env}"
#   }
# end

# Sidekiq.configure_client do |config|
#   config.redis = {
#     url: 'redis://redis:6379/0',
#     namespace: "proto_#{Rails.env}"
#   }
# end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://redis:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', 'redis://redis:6379/1') }
end

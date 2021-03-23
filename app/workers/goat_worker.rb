class GoatWorker
  include Sidekiq::Worker

  def perform(*args)
    GoatLogger.call('GoatLogger called from GoatWorker.')
  end
end

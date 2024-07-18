require 'faraday'
class ImportTemplates
  def call
    payload = Faraday.get(url)
    result = JSON.parse(payload.body)
    result.map!{ |h| [h] }
    MonitorService.new.update_mongo_log
  rescue OpenURI::HTTPError => e
    Rails.logger.error(e.message)
  end

  def url
    ENV["WEBHOOK_HOST"]
  end
end

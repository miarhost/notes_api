require 'faraday'
class ImportTemplates
  def call
    payload = Faraday.get(url)
    JSON.parse(payload.body)
  rescue OpenURI::HTTPError => e
    Rails.logger.error(e.message)
  end

  def url
    ENV["WEBHOOK_HOST"]
  end
end

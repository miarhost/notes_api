require 'faraday'
class ImportTemplates
  def call
    payload = Faraday.get(url)
    JSON.parse(payload)
  end

  def url
    ENV["WEBHOOK_HOST"]
  end
end

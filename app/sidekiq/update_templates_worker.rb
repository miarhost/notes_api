class UpdateTemplatesWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: :fetch, retry_queue: :fallback,  retry: 2, backtrace: 3

  def perform(value)
    field = JSON.parse(value)
    template = SampleNote.create!(
      title: field["title"],
      content: field["payload"]
    )

    store result: "Template created: #{template.id}"
  rescue StandardError => e
    store result: e.message
  end

  def bulk_update
    bulk_results = []
    data = ImportTemplates.new.call
    data.each do |item|
      extracted_job = perform_async(item.to_json)
      bulk_results << { jid: extracted_job, result: Sidekiq::Status.get_all(extracted_job, :result)}
    end
    store bulk_results: bulk_results.to_json
  rescue StandardError => e
    store bulk_results: e.message
  end
end

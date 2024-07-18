class UpdateTemplatesWorker
  include Sidekiq::Job
  include Sidekiq::Status::Worker
  sidekiq_options queue: :fetch, retry_queue: :fallback,  retry: 2, backtrace: 3

  def perform
    bulk_results = []
    data = ImportTemplates.new.call
    extracted_job = BatchTemplatesJob.perform_bulk(data, batch_size: 4)
    bulk_results << { result: Sidekiq::Status.get(extracted_job, :result)}
    store result: bulk_results.to_json
  rescue StandardError => e
    store result: e.message
  end
end


class BatchTemplatesJob
  include Sidekiq::Job
  include Sidekiq::Status::Worker
  sidekiq_options queue: :fetch, retry_queue: :fallback,  retry: 2, backtrace: 3

  def perform(templates, **args)
    results = []
    templates.each do |item|
      template = SampleNote.create!(
        title: item[0]["title"],
        content: item[0]["payload"]
      )
      results << template.id
    rescue ActiveRecord::RecordInvalid => e
      results << e.message
    end
    store result: results
  rescue StandardError => e
    store result: e.message
  end
end

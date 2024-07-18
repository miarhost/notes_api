class RequestLog
  include Mongoid::Document
  field :info, type: String
  field :received_at, type: DateTime

  scope :by_date, ->{ find({received_at: {'$gt' => date }})}
end

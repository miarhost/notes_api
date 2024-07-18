class MonitorService
  def update_mongo_log
    log_unit = RequestLog.new
    $logger = Logger.new(log_unit.info)
    log_unit.received_at = Time.now
    log_unit.save!
  end
end

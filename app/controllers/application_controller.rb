class ApplicationController < ActionController::API
  include ErrorsHandler
  after_action :log_request
  def paginate_collection(collection, page, num)
    Kaminari.paginate_array(collection).page(page).per(num)
  end

  def log_request
    MonitorService.new.update_mongo_log
  end
end

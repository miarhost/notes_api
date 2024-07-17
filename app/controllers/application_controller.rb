class ApplicationController < ActionController::API
  include ErrorsHandler
  def paginate_collection(collection, page, num)
    Kaminari.paginate_array(collection).page(page).per(num)
  end
end

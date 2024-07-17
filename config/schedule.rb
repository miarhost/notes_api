set :output, "#{path}/log/cron.log"

every :day, at: '15.30 pm' do
  runner 'UpdateTemplatesWorker.new.bulk_update'
end

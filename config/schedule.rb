set :output, "log/cron.log"
set :environment, "development"
every :day, at: ["12:00 AM"] do
    rake "email:overdue_books"
end
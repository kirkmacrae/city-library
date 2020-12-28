json.extract! checkout_log, :id, :UserId, :BookId, :CheckoutDate, :DueDate, :ReturnedDate, :user_id, :book_id, :created_at, :updated_at
json.url checkout_log_url(checkout_log, format: :json)

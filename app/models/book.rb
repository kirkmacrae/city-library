class Book < ApplicationRecord
    has_many :checkout_logs
end

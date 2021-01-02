class Book < ApplicationRecord
    has_many :checkout_logs, dependent: :destroy
end

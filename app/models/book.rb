class Book < ApplicationRecord
    has_many :checkout_logs, dependent: :destroy
    belongs_to :library

    #records per page for will_paginate
    self.per_page = 100
end

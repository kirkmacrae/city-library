class CheckoutLog < ApplicationRecord
  belongs_to :user
  belongs_to :book

  #records per page for will_paginate
  self.per_page = 50
end

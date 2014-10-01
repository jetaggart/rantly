class User < ActiveRecord::Base
  has_secure_password

  enum :type_of_ranter => [:daily, :weekly, :monthly]
end

class User < ActiveRecord::Base
  has_secure_password

  enum :type_of_ranter => [:daily, :weekly, :monthly]

  def full_name
    "#{first_name} #{last_name}"
  end
end

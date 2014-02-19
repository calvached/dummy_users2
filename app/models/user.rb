class User < ActiveRecord::Base
  has_many :urls
  def self.authenticate(email, password)

    user = User.find_by(email: email)
    if !user
      nil
    elsif user.password == password
      user
    else
      nil
    end
  end
end

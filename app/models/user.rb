class User < ActiveRecord::Base
  # e.g., User.authenticate('jesse@devbootcamp.com', 'apples123')
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if user.password == password
      user
    else
      nil
    end
    # if email and password correspond to a valid user, return that user
    # otherwise, return nil
  end
end

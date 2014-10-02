module ObjectCreationMethods
  def new_user(overrides = {})
    defaults = {
      :username => "username#{counter}",
      :password => "password"
    }

    User.new { |user| apply(user, defaults, overrides) }
  end

  def create_user(overrides = {})
    new_user(overrides).tap(&:save!)
  end

  private

  def counter
    @counter ||= 0
    @counter += 1
  end

  def apply(object, defaults, overrides)
    options = defaults.merge(overrides)
    options.each do |method, value_or_proc|
      object.send("#{method}=", value_or_proc.is_a?(Proc) ? value_or_proc.call : value_or_proc)
    end
  end
end
class User
  attr_accessor :name, :email

  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  #noinspection RubyInstanceVariableToStringInspection,RubyInstanceVariableToStringInspection
  def formatted_email
    "#{@name} <#{@email}>"
  end
end
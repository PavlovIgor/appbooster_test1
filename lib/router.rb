class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(request, variables)
    path = request.path
    if routes.key?(path)
      ctrl(request, variables, routes[path]).call
    else
      Controller.new.not_found
    end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error
  end

  private

  def ctrl(request, variables, string)
    ctrl_name, action_name = string.split('#')
    klass = Object.const_get("#{ctrl_name.capitalize}Controller", Class.new)
    klass.new(request, variables, name: ctrl_name, action: action_name.to_sym)
  end
end

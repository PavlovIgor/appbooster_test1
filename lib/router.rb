class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(request)
    path = request.path
    if routes.key?(path)
      ctrl(request, routes[path]).call
    else
      Controller.new.not_found
    end
  rescue Exception => error
    puts error.message
    puts error.backtrace
    Controller.new.internal_error
  end

  private

  def ctrl(request, string)
    ctrl_name, action_name = string.split('#')
    klass = Object.const_get("#{ctrl_name.capitalize}Controller", Class.new)
    klass.new(request, name: ctrl_name, action: action_name.to_sym)
  end
end

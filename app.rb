require 'roda'

class App < Roda
  plugin :render
  route do |r|
    # GET / request
    r.root do
      render('index')
    end
  end
end

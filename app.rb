require 'roda'
require 'random/formatter'
class App < Roda
  $todos = [{ id: Random.uuid, name: 'First' }]
  plugin :render
  plugin :type_routing, types: {
    turbo: 'text/vnd.turbo-stream.html'
  }
  route do |r|
    # GET / request
    r.root do
      view('index', locals: { todos: $todos })
    end

    r.get('test') do
      r.turbo { render('test') }
      r.html { view('test') }
    end

    r.post do
      puts request.params
      if request.params['todo'].empty?
        todo = { id: Random.uuid, name: 'Second' }
        $todos << todo
      else
        todo = { id: Random.uuid, name: request.params['todo'] }
        $todos << todo
      end

      response.status = 301

      r.turbo { render('todo_stream', locals: { todo: }) }
      r.html { view('index', locals: { todos: $todos }) }
    end
  end
end

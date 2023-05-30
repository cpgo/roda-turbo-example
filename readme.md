Todos list will be rendered here, wrap the list around a turbo-frame so we can target it with an turbo-stream
```
<turbo-frame id="todos">
  <% todos.each do |todo| %>
  <%= render('todo', locals: { todo: todo} ) %>
  <% end %>
</turbo-frame>
```

With a little help of the `type_routing` plugin we can have something like Rails's `respond_to`

```
  r.turbo { render('todo_stream', locals: { todo: todo })}
  r.html { view('index', locals: { todos: $todos }) }
```

This way the whole thing works even without hotwire, you can comment the import on layout.erb to check for yourself.
After commenting the import, note that the counter under `Hello from layout` will reset after a form submition because we are rendering the whole page again.


When handling turbo requests we can respond with just a stream with the created todo

```
<turbo-stream target="todos" action="append">
  <template>
    <%= render("todo", locals: {todo: todo})%>
  </template>
</turbo-stream>
```

If we had a `edit` action we would have to create another stream with `target="id-of-todo-being-edited" action="replace"`



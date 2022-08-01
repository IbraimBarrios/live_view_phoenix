defmodule LiveViewPhoenixWeb.MyComponent do
  use LiveViewPhoenixWeb, :live_component

  import Number.Currency

  def quote(assigns) do
    assigns = assign_new(assigns, :hrs_until_expires, fn -> 24 end)

    ~H"""
    <div>
      <%= @weight %> pounds of <%= @material %>
      for <%= number_to_currency(@price) %>
      expires in <%= @hrs_until_expires %> hours
    </div>
    """
  end

  def greet(assigns) do
    ~H"""
    <p>Hello, <%= assigns.name %></p>
    """
  end
end

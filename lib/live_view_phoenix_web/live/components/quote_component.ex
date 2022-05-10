defmodule LiveViewPhoenixWeb.QuoteComponent do
  use LiveViewPhoenixWeb, :live_component

  import Number.Currency

  def mount(socket) do
    socket = assign(socket, hrs_until_expires: 24)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="text-center p-6 border-dashed">
        <h2 class="text-2xl">
            Our Best Deal:
        </h2>
        <h3 class="pounds text-xl font-bold text-purple-900">
            <%= @weight %> pounds of <%= @material %> for <%= number_to_currency(@price) %>
        </h3>
        <div>
            expire in <%= @hrs_until_expires %> hours
        </div>
    </div>
    """
  end
end

defmodule LiveViewPhoenixWeb.ScrollLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.PizzaOrders

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        order: PizzaOrders.list_pizza_orders()
      )

    {:ok, socket}
  end
  # def render(assigns) do
  #   ~L"""

  #   """
  # end

end

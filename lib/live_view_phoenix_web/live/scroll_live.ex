defmodule LiveViewPhoenixWeb.ScrollLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.PizzaOrders

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(limit: 10)
      |> load_orders()

    {:ok, socket}
  end

  defp load_orders(socket) do
    assign(socket,
      orders: PizzaOrders.list_pizza_orders(limit: socket.assigns.limit)
    )
  end

  # def render(assigns) do
  #   ~L"""

  #   """
  # end

  def handle_event("load-more", _, socket) do
    socket =
      socket
      |> update(:limit, &(&1 + 10))
      |> load_orders()

    {:noreply, socket}
  end
end

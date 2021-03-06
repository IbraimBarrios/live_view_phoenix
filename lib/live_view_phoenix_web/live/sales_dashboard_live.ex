defmodule LiveViewPhoenixWeb.SalesDashboardLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Sales

  def mount(_params, _session, socket) do

    if connected?(socket) do
      :timer.send_interval(3000, self(), :tick) # refresh the socket every 3 seconds
    end

    socket = assign_stats(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Sales Dashboard</h1>
    <div id="dashboard">
      <div class="stats">
        <div class="stat">
          <span class="value">
            <%= @new_orders %>
          </span>
          <span class="name">
            New Orders
          </span>
        </div>
        <div class="stat">
          <span class="value">
            $<%= @sales_amount %>
          </span>
          <span class="name">
            Sales Amount
          </span>
        </div>
        <div class="stat">
          <span class="value">
            <%= @satisfaction %>%
          </span>
          <span class="name">
            Satisfaction
          </span>
      </div>
      </div>

      <button phx-click="refresh">
        <img src="images/refresh.svg">
        Refresh
      </button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amout(),
      satisfaction: Sales.satisfaction()
    )
  end

end

defmodule LiveViewPhoenixWeb.SandboxLive do
  use LiveViewPhoenixWeb, :live_view

  # use Phoenix.LiveComponent

  alias LiveViewPhoenixWeb.QuoteComponent
  alias LiveViewPhoenixWeb.SandboxCalculatorComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, weight: nil, prece: nil)}
  end

  def render(assigns) do
    ~L"""
    <h1> Build a sandbox </h1>
    <div id="sandbox">

      <!--componentes con estado -->
      <%= live_component @socket, SandboxCalculatorComponent, id: 1 %>

      <!-- componente sin estado -->
      <%= if @weight do %>
        <%= live_component @socket, QuoteComponent, material: "sand", weight: @weight, price: @prece %>
      <% end %>
    </div>
    """
  end

  def handle_info({:totals, weight, prece}, socket) do
    socket = assign(socket, weight: weight, prece: prece)
    {:noreply, socket}
  end
end

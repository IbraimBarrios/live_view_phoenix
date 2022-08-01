defmodule LiveViewPhoenixWeb.SandboxLive do
  use LiveViewPhoenixWeb, :live_view

  # use Phoenix.LiveComponent

  alias LiveViewPhoenixWeb.QuoteComponent
  alias LiveViewPhoenixWeb.SandboxCalculatorComponent
  alias LiveViewPhoenixWeb.MyComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, weight: nil, prece: nil)}
  end

  def render(assigns) do
    ~H"""
    <h1> Build a sandbox </h1>
    <div id="sandbox">

      <!--componentes con estado -->
      <%= live_component @socket, SandboxCalculatorComponent, id: 1 %>

      <!-- componente sin estado -->
      <%= if @weight do %>
        <%= live_component @socket, QuoteComponent, material: "sand", weight: @weight, price: @prece %>
      <% end %>

      <!-- Otros ejemplos de como llamar a los componenetes -->
      <MyComponent.quote material="sand" weight="10.0" price="2" hrs_until_expires="4"  />
      <MyComponent.greet name="Jane" />

    </div>
    """
  end

  def handle_info({:totals, weight, prece}, socket) do
    socket = assign(socket, weight: weight, prece: prece)
    {:noreply, socket}
  end
end

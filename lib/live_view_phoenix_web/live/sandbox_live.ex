defmodule LiveViewPhoenixWeb.SandboxLive do
  use LiveViewPhoenixWeb, :live_view

  # use Phoenix.LiveComponent

  alias LiveViewPhoenixWeb.QuoteComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1> Build a sandbox </h1>
    <div id="sandbox">
        <%= live_component QuoteComponent, material: "sand" , weight: 10.0, price: 15.0 %>
    </div>
    """
  end
end

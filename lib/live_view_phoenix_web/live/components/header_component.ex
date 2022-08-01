defmodule LiveViewPhoenixWeb.HeaderComponent do
  use LiveViewPhoenixWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1><%= @title %></h1>
    <h2 class="text-center text-2xl text-gray-500 subtitle-space">
      <%= @subtitle %>
    </h2>
    """
  end
end

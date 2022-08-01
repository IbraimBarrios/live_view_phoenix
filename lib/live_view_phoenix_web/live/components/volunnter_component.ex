defmodule LiveViewPhoenixWeb.VolunnterComponent do
  use LiveViewPhoenixWeb, :live_component

  alias LiveViewPhoenix.Volunteers

  def render(assigns) do
    ~H"""
    <div class={"volunteer #{ if @volunteer.checked_out, do: "out" }"} id={"volunteer-#{@volunteer.id}"} >
      <div class="name">
        <%= @volunteer.name %>
      </div>
      <div class="phone">
        <img src="images/phone.svg">
        <%= @volunteer.phone %>
      </div>
      <div class="status">
        <button phx-click="toggle-states" phx-value-id={@volunteer.id} phx_disable_with="Saving.." phx-target={@myself} class={"#{ if @volunteer.checked_out, do: "out" }"}>
          <%= if @volunteer.checked_out, do: "Check In", else: "Check Out" %>
        </button>
      </div>
    </div>
    """
  end

  def handle_event("toggle-states", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, _volunteer} =
      Volunteers.update_volunteer(
        volunteer,
        %{checked_out: !volunteer.checked_out}
      )

    # volunteers = Volunteers.list_volunteers()

    # socket =
    #   assign(socket,
    #   volunteers: volunteers
    #   )

    # :timer.sleep(500)

    {:noreply, socket}
  end
end

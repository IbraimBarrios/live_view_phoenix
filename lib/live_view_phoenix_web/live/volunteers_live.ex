defmodule LiveViewPhoenixWeb.VolunteersLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Volunteers
  alias LiveViewPhoenix.Volunteers.Volunteer

  def mount(_params, _session, socket) do
    volunteers = Volunteers.list_volunteers()

    socket =
      assign(socket,
        volunteers: volunteers
      )

    {:ok, socket}
  end
end

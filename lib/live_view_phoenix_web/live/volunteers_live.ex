defmodule LiveViewPhoenixWeb.VolunteersLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Volunteers

  def mount(_params, _session, socket) do
    if connected?(socket), do: Volunteers.subscribe()
    volunteers = Volunteers.list_volunteers()

    socket =
      assign(socket,
        volunteers: volunteers,
        recent_activity: nil
      )

    {:ok, socket}
  end

  # def render(assigns) do
  #   ~H"""

  #   """
  # end

  def handle_info({:volunteer_created, volunteer}, socket) do
    socket =
      update(
        socket,
        :volunteers,
        fn volunteers -> [volunteer | volunteers] end
      )

    {:noreply, socket}
  end

  def handle_info({:volunteer_updated, volunteer}, socket) do
    socket =
      update(
        socket,
        :volunteers,
        fn volunteers -> [volunteer | volunteers] end
      )

    volunteers = Volunteers.list_volunteers()

    socket =
      assign(socket,
        volunteers: volunteers,
        recent_activity: "#{volunteer.name} checked
        #{if volunteer.checked_out, do: "out", else: "in"}!"
      )

    {:noreply, socket}
  end
end

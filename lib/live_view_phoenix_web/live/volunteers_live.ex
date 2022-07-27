defmodule LiveViewPhoenixWeb.VolunteersLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Volunteers
  alias LiveViewPhoenix.Volunteers.Volunteer

  def mount(_params, _session, socket) do
    volunteers = Volunteers.list_volunteers()
    changeset = Volunteers.change_volunteer(%Volunteer{})

    socket =
      assign(socket,
        volunteers: volunteers,
        changeset: changeset
      )

    {:ok, socket}
  end

  # def render(assigns) do
  #   ~H"""

  #   """
  # end

  def handle_event("save", %{"volunteer" => params}, socket) do
    case Volunteers.create_volunteer(params) do
      {:ok, volunteer} ->
        socket =
          update(
            socket,
            :volunteers,
            fn volunteers -> [volunteer | volunteers] end
          )

        changeset = Volunteers.change_volunteer(%Volunteer{})

        socket = assign(socket, changeset: changeset)

        :timer.sleep(500)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"volunteer" => params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("toggle-states", %{"id" => id}, socket) do
    volunteer = Volunteers.get_volunteer!(id)

    {:ok, _volunteer} =
      Volunteers.update_volunteer(
        volunteer, %{checked_out: !volunteer.checked_out}
      )
      volunteers = Volunteers.list_volunteers()

      socket =
        assign(socket,
        volunteers: volunteers
        )

      :timer.sleep(500)

    {:noreply, socket}
  end
end

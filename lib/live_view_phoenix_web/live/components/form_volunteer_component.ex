defmodule LiveViewPhoenixWeb.FormVolunteerComponent do
  use LiveViewPhoenixWeb, :live_component

  alias LiveViewPhoenix.Volunteers
  alias LiveViewPhoenix.Volunteers.Volunteer

  def mount(socket) do
    changeset = Volunteers.change_volunteer(%Volunteer{})
    {:ok, assign(socket, changeset: changeset)}
  end
  def render(assigns) do
    ~H"""
    <div>
      <.form let={f} for={@changeset} phx-change="validate" phx-submit="save"  phx-target= {@myself} class="form-checkin">
        <div class="field">
          <%= text_input f, :name, placeholder: "Name", autocomplete: "off" %>
          <%= error_tag f, :name %>
        </div>
        <div class="field">
          <%= telephone_input f, :phone, placeholder: "Phone", autocomplete: "off" %>
          <%=error_tag f, :phone %>
        </div>
        <%= submit "Check In", phx_disable_with: "Saving..." %>
      </.form>
    </div>
    """
  end

  def handle_event("save", %{"volunteer" => params}, socket) do
    case Volunteers.create_volunteer(params) do
      {:ok, _volunteer} ->
        # socket =
        #   update(
        #     socket,
        #     :volunteers,
        #     fn volunteers -> [volunteer | volunteers] end
        #   )

        changeset = Volunteers.change_volunteer(%Volunteer{})

        socket = assign(socket, changeset: changeset)

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
end

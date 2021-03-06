defmodule LiveViewPhoenixWeb.LicenseLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Licenses #call the class Licenses to use it
  import Number.Currency #dependency package installed


  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 3, amount: Licenses.calculate(3) )
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Team License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg">
            <span>
              Your license is currently for
              <strong><%= @seats %></strong> seats.
            </span>
          </div>

          <form phx-change="update">
            <input type="range" min="1" max="10"
                  name="seats" value={@seats} />
          </form>
          <div class="amount">
          <%= number_to_currency(@amount)%>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do #catches the new value and stores it in seats
    seats = String.to_integer(seats) #returns an integer value from a String
    socket =
      assign(socket,
       seats: seats,
        amount: Licenses.calculate(seats)
        )
    {:noreply, socket}
  end
end

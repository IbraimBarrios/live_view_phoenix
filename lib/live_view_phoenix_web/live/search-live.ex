defmodule LiveViewPhoenixWeb.SearchLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-purple-900">Find a Store by Zip Code</h1>
    <div id="search">

    <form phx-submit="zip-search">
      <input type="text" name="zip" value={@zip}
              placeholder="Zip code"
              autofocus autocomplete="off"
              readonly={@loading}
              />

      <button type="submit">
        <img src="images/search.svg" >
      </button>
    </form>

    <%= if @loading do %>
      <div class="loader">
        Loading...
      </div>
    <% end %>

      <div class="stores">
        <ul>
          <%= for store <- @stores do %>
            <li>
              <div class="first-line">
                <div class="name">
                  <%= store.name %>
                </div>
                <div class="status">
                  <%= if store.open do %>
                    <span class="open">Open</span>
                  <% else %>
                    <span class="closed">Closed</span>
                  <% end %>
                </div>
              </div>
              <div class="second-line">
                <div class="street">
                  <img src="images/location.svg">
                  <%= store.street %>
                </div>
                <div class="phone_number">
                  <img src="images/phone.svg">
                  <%= store.phone_number %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("zip-search", %{"zip" => zip}, socket) do
    send(self(), {:run_zip_search, zip})

    socket =
      assign(socket,
        zip: zip,
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_zip_search, zip}, socket) do
    case Stores.search_by_zip(zip) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching\"#{zip}\"") #shows a message on the screen when it does not find the postal code
          |> assign(stores: [], loading: false)

        {:noreply, socket}

        stores ->
          socket = assign(socket, stores: stores, loading: false)
          {:noreply, socket}
    end
  end


  # def handle_info({:run_zip_search, zip}, socket) do
  #       socket =
  #         assign(socket,
  #         stores: Stores.search_by_zip(zip),
  #         loading: false
  #         )
  #       {:noreply, socket}
  #   end

end

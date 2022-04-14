defmodule LiveViewPhoenixWeb.Serverslive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Servers

  def mount(_params, _session, socket) do
    servers = Servers.list_servers()

    socket =
      assign(socket,
        servers: servers,
        selected_server: hd(servers)
      )

    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <h1>Servers</h1>
    <div id="servers">
      <div class="sidebar">
        <nav>
        <%= for server <- @servers do %>
        <div>
        <%= live_patch link_body(server),
            to: Routes.live_path(
              @socket,
              __MODULE__,
              id: server.id
        ),
        class: if server == @selected_server, do: "active" %>
        </div>

         <!-- <a href="#"
          phx-click="show"
          phx-value-id={server.id}
          class={"#{if server == @selected_server, do: 'active'}"}
          >
          <img src="/images/server.svg">
          <%= server.name %>
          </a>-->
          <% end %>
        </nav>
      </div>
      <div class="main">
        <div class="wrapper">
          <div class="card">
            <div class="header">
              <h2><%= @selected_server.name %></h2>
              <span class={@selected_server.status}>
                <%= @selected_server.status %>
              </span>
            </div>
            <div class="body">
              <div class="row">
                <div class="deploys">
                  <img src="/images/download.svg">
                  <span>
                    <%= @selected_server.deploy_count %> deploys
                  </span>
                </div>
                <span>
                  <%= @selected_server.size %> MB
                </span>
                <span>
                  <%= @selected_server.framework %>
                </span>
              </div>
              <h3>Git Repo</h3>
              <div class="repo">
                <%= @selected_server.git_repo %>
              </div>
              <h3>Last Commit</h3>
              <div class="commit">
                <%= @selected_server.last_commit_id %>
              </div>
              <blockquote>
                <%= @selected_server.last_commit_message %>
              </blockquote>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_params(%{"id" => id}, _url, socket) do
    id = String.to_integer(id)

    server = Servers.get_server!(id)

    socket =
      assign(socket,
      selected_server: server
      )

      {:noreply, socket}
  end

  def handle_params(_, _url,socket) do
    {:noreply, socket}
  end

  defp link_body(server) do
    assigns = %{name: server.name}

    ~H"""
    <img src="/images/server.svg">
    <%= @name %>
    """
  end


  # def handle_event("show", %{"id" => id}, socket) do
  #   id = String.to_integer(id)

  #   server = Servers.get_server!(id)

  #   socket =
  #     assign(socket,
  #     selected_server: server
  #     )

  #     {:noreply, socket}
  # end


end

defmodule LiveViewPhoenixWeb.PageController do
  use LiveViewPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

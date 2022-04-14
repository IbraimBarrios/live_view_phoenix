defmodule LiveViewPhoenixWeb.PaginateLive do
  use LiveViewPhoenixWeb, :live_view

  alias LiveViewPhoenix.Donations

  def mount(_params, _session, socket) do
    paginate_options = %{page: 2, per_pege: 5}
    donations = Donations.list_donations(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        donations: donations
      )

      {:ok, socket, temporary_assigns: [donations: []]}
  end

  # def render(assigns) do
  #   ~H"""

  #   """
  # end

  def handle_params(params,_url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    paginate_options = %{page: page, per_pege: per_page}
    donations = Donations.list_donations(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        donations: donations
      )

    {:noreply, socket}
  end

  defp expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

end

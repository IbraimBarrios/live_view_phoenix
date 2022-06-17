defmodule LiveViewPhoenixWeb.SortLive do
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

    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    paginate_options = %{page: page, per_pege: per_page}
    IO.puts("valor1: #{sort_order}, valor 2: #{sort_by}")

    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    donations =
      Donations.list_donations(
        paginate: paginate_options,
        sort: sort_options
        )

    socket =
      assign(socket,
        options: Map.merge(paginate_options, sort_options),
        donations: donations
      )

    {:noreply, socket}
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)
    IO.puts "Show: #{per_page}"

    socket =
      push_patch(socket,
        to: Routes.live_path(socket,
        __MODULE__,
        page: socket.assigns.options.page,
        per_page: per_page,
        sort_by: socket.assigns.options.sort_by,
        sort_order: socket.assigns.options.sort_order
      ))

    {:noreply, socket}
  end

  defp expires_class(donation) do
    if Donations.almost_expired?(donation), do: "eat-now", else: "fresh"
  end

  defp pagination_link(socket, text, page, per_page, sort_by, sort_order, class) do
    IO.puts("options: #{sort_by}, per_page: #{per_page}")
    live_patch(text,
                to: Routes.live_path(
                  socket,
                  __MODULE__,
                  page: page,
                  per_page: per_page,
                  sort_by: sort_by,
                  sort_order: sort_order
                ),
                class: class
    )
  end

  defp sort_link(socket, text, sort_by, options) do
    text =
      if sort_by == options.sort_by do
        IO.puts("entro: #{options.sort_by}, entro:  options.sort_order : #{options.sort_order}")
        text <> icon(options.sort_order)
      else
        IO.puts("No entro:")
        text
      end

    live_patch text,
                to: Routes.live_path(
                  socket,
                  __MODULE__,
                  sort_by: sort_by,
                  sort_order: toggle_sort_order(options.sort_order),
                  page: options.page,
                  per_page: options.per_pege
                )
  end

  defp toggle_sort_order(:asc) do
    :desc
  end

  defp toggle_sort_order(:desc) do
    :asc
  end

  defp icon(:asc) do
    " ˅"
  end

  defp icon(:desc) do
    " ˄"
  end

end

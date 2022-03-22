defmodule LiveViewPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :live_view_phoenix,
    adapter: Ecto.Adapters.Postgres
end

defmodule LiveViewPhoenix.ServersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveViewPhoenix.Servers` context.
  """

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        deploy_count: 42,
        framework: "some framework",
        git_repo: "some git_repo",
        last_commit_id: "some last_commit_id",
        last_commit_message: "some last_commit_message",
        name: "some name",
        size: 120.5,
        status: "some status"
      })
      |> LiveViewPhoenix.Servers.create_server()

    server
  end
end

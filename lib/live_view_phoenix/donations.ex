defmodule LiveViewPhoenix.Donations do
  @moduledoc """
  The Donations context.
  """

  import Ecto.Query, warn: false
  alias LiveViewPhoenix.Repo

  alias LiveViewPhoenix.Donations.Donation

  def almost_expired?(dination) do
    dination.days_until_expires <= 10
  end

  @doc """
  Returns the list of donations.

  ## Examples

      iex> list_donations()
      [%Donation{}, ...]

  """
  def list_donations do
    Repo.all(Donation)
  end

  @doc """
  Gets a single donation.

  Raises `Ecto.NoResultsError` if the Donation does not exist.

  ## Examples

      iex> get_donation!(123)
      %Donation{}

      iex> get_donation!(456)
      ** (Ecto.NoResultsError)

  """

  #funcion de paginacion haciendo referencia a la BD.
  def list_donations(criteria) when is_list(criteria) do
    query = from(d in Donation)
    hola = "hola"
    IO.puts "#{hola}"

    Enum.reduce(criteria, query, fn
      {:paginate, %{page: page, per_pege: per_pege}}, query ->
        from q in query,
        offset: ^((page - 1) * per_pege),
        limit: ^per_pege

        {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->

        from q in query, order_by: [{^sort_order, ^sort_by}]
      end)
      |> Repo.all()
  end

  def get_donation!(id), do: Repo.get!(Donation, id)

  @doc """
  Creates a donation.

  ## Examples

      iex> create_donation(%{field: value})
      {:ok, %Donation{}}

      iex> create_donation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_donation(attrs \\ %{}) do
    %Donation{}
    |> Donation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donation.

  ## Examples

      iex> update_donation(donation, %{field: new_value})
      {:ok, %Donation{}}

      iex> update_donation(donation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_donation(%Donation{} = donation, attrs) do
    donation
    |> Donation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a donation.

  ## Examples

      iex> delete_donation(donation)
      {:ok, %Donation{}}

      iex> delete_donation(donation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_donation(%Donation{} = donation) do
    Repo.delete(donation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donation changes.

  ## Examples

      iex> change_donation(donation)
      %Ecto.Changeset{data: %Donation{}}

  """
  def change_donation(%Donation{} = donation, attrs \\ %{}) do
    Donation.changeset(donation, attrs)
  end
end

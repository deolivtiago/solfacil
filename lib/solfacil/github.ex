defmodule Solfacil.Github do
  @moduledoc """
  The Github context.
  """

  import Ecto.Query, warn: false
  alias Solfacil.Repo

  alias Solfacil.Github.Dev
  alias Solfacil.Github.Client

  @doc """
  Returns the list of devs.

  ## Examples

      iex> list_devs()
      [%Dev{}, ...]

  """
  def list_devs do
    Repo.all(Dev)
  end

  @doc """
  Gets a single dev.

  Raises `Ecto.NoResultsError` if the Dev does not exist.

  ## Examples

      iex> get_dev!(123)
      %Dev{}

      iex> get_dev!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dev!(id), do: Repo.get!(Dev, id)

  @doc """
  Creates a dev.

  ## Examples

      iex> create_dev(%{field: value})
      {:ok, %Dev{}}

      iex> create_dev(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dev(%{"username" => username}) do
    with {:ok, attrs} <- Client.get_dev(username) do
      %Dev{}
      |> Dev.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a dev.

  ## Examples

      iex> update_dev(dev, %{field: new_value})
      {:ok, %Dev{}}

      iex> update_dev(dev, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dev(%Dev{} = dev, attrs) do
    dev
    |> Dev.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dev.

  ## Examples

      iex> delete_dev(dev)
      {:ok, %Dev{}}

      iex> delete_dev(dev)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dev(%Dev{} = dev) do
    Repo.delete(dev)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dev changes.

  ## Examples

      iex> change_dev(dev)
      %Ecto.Changeset{data: %Dev{}}

  """
  def change_dev(%Dev{} = dev, attrs \\ %{}) do
    Dev.changeset(dev, attrs)
  end
end

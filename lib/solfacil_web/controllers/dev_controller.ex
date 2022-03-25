defmodule SolfacilWeb.DevController do
  use SolfacilWeb, :controller

  alias Solfacil.Github
  alias Solfacil.Github.Dev

  def index(conn, _params) do
    devs = Github.list_devs()
    render(conn, "index.html", devs: devs)
  end

  def new(conn, _params) do
    changeset = Github.change_dev(%Dev{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dev" => dev_params}) do
    case Github.create_dev(dev_params) do
      {:ok, dev} ->
        conn
        |> put_flash(:info, "Dev created successfully.")
        |> redirect(to: Routes.dev_path(conn, :show, dev))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

      {:error, _error} ->
        conn
        |> put_flash(:info, "Are you sure this Dev exists?")
        |> redirect(to: Routes.dev_path(conn, :index))
    end
  end

  def show(conn, %{"id" => id}) do
    dev = Github.get_dev!(id)
    render(conn, "show.html", dev: dev)
  end

  def edit(conn, %{"id" => id}) do
    dev = Github.get_dev!(id)
    changeset = Github.change_dev(dev)
    render(conn, "edit.html", dev: dev, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dev" => dev_params}) do
    dev = Github.get_dev!(id)

    case Github.update_dev(dev, dev_params) do
      {:ok, dev} ->
        conn
        |> put_flash(:info, "Dev updated successfully.")
        |> redirect(to: Routes.dev_path(conn, :show, dev))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", dev: dev, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dev = Github.get_dev!(id)
    {:ok, _dev} = Github.delete_dev(dev)

    conn
    |> put_flash(:info, "Dev deleted successfully.")
    |> redirect(to: Routes.dev_path(conn, :index))
  end
end

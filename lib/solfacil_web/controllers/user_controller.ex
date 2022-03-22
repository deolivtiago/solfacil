defmodule SolfacilWeb.UserController do
  use SolfacilWeb, :controller

  alias Solfacil.Accounts
  alias Solfacil.Accounts.User

  action_fallback SolfacilWeb.FallbackController

  def index(%{path_info: [path | _t]} = conn, _params) do
    users = Accounts.list_users()

    case path do
      "api" -> render(conn, "index.json", users: users)
      _browser -> render(conn, "index.html", users: users)
    end
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{path_info: [path | _t]} = conn, %{"user" => user_params}) do
    case path do
      "api" ->
        with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
          conn
          |> put_status(:created)
          |> render("show.json", user: user)
        end

      _browser ->
        case Accounts.create_user(user_params) do
          {:ok, user} ->
            conn
            |> put_flash(:info, "User created successfully.")
            |> redirect(to: Routes.user_path(conn, :show, user))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
    end
  end

  def show(%{path_info: [path | _t]} = conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    case path do
      "api" -> render(conn, "show.json", user: user)
      _browser -> render(conn, "show.html", user: user)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(%{path_info: [path | _t]} = conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case path do
      "api" ->
        with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
          render(conn, "show.json", user: user)
        end

      _browser ->
        case Accounts.update_user(user, user_params) do
          {:ok, user} ->
            conn
            |> put_flash(:info, "User updated successfully.")
            |> redirect(to: Routes.user_path(conn, :show, user))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", user: user, changeset: changeset)
        end
    end
  end

  def delete(%{path_info: [path | _t]} = conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    case path do
      "api" ->
        with {:ok, %User{}} <- Accounts.delete_user(user) do
          send_resp(conn, :no_content, "")
        end

      _browser ->
        with {:ok, _user} <- Accounts.delete_user(user) do
          conn
          |> put_flash(:info, "User deleted successfully.")
          |> redirect(to: Routes.user_path(conn, :index))
        end
    end
  end
end

defmodule SolfacilWeb.DevControllerTest do
  use SolfacilWeb.ConnCase

  import Solfacil.GithubFixtures

  @create_attrs %{avatar_url: "some avatar_url", bio: "some bio", location: "some location", name: "some name", repos_url: "some repos_url", username: "some username"}
  @update_attrs %{avatar_url: "some updated avatar_url", bio: "some updated bio", location: "some updated location", name: "some updated name", repos_url: "some updated repos_url", username: "some updated username"}
  @invalid_attrs %{avatar_url: nil, bio: nil, location: nil, name: nil, repos_url: nil, username: nil}

  describe "index" do
    test "lists all devs", %{conn: conn} do
      conn = get(conn, Routes.dev_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Devs"
    end
  end

  describe "new dev" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.dev_path(conn, :new))
      assert html_response(conn, 200) =~ "New Dev"
    end
  end

  describe "create dev" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dev_path(conn, :create), dev: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.dev_path(conn, :show, id)

      conn = get(conn, Routes.dev_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Dev"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dev_path(conn, :create), dev: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Dev"
    end
  end

  describe "edit dev" do
    setup [:create_dev]

    test "renders form for editing chosen dev", %{conn: conn, dev: dev} do
      conn = get(conn, Routes.dev_path(conn, :edit, dev))
      assert html_response(conn, 200) =~ "Edit Dev"
    end
  end

  describe "update dev" do
    setup [:create_dev]

    test "redirects when data is valid", %{conn: conn, dev: dev} do
      conn = put(conn, Routes.dev_path(conn, :update, dev), dev: @update_attrs)
      assert redirected_to(conn) == Routes.dev_path(conn, :show, dev)

      conn = get(conn, Routes.dev_path(conn, :show, dev))
      assert html_response(conn, 200) =~ "some updated avatar_url"
    end

    test "renders errors when data is invalid", %{conn: conn, dev: dev} do
      conn = put(conn, Routes.dev_path(conn, :update, dev), dev: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Dev"
    end
  end

  describe "delete dev" do
    setup [:create_dev]

    test "deletes chosen dev", %{conn: conn, dev: dev} do
      conn = delete(conn, Routes.dev_path(conn, :delete, dev))
      assert redirected_to(conn) == Routes.dev_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.dev_path(conn, :show, dev))
      end
    end
  end

  defp create_dev(_) do
    dev = dev_fixture()
    %{dev: dev}
  end
end

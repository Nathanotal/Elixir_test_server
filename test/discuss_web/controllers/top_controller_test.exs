defmodule DiscussWeb.TopControllerTest do
  use DiscussWeb.ConnCase

  alias Discuss.Topic

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:top) do
    {:ok, top} = Topic.create_top(@create_attrs)
    top
  end

  describe "index" do
    test "lists all topic", %{conn: conn} do
      conn = get(conn, Routes.top_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Topic"
    end
  end

  describe "new top" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.top_path(conn, :new))
      assert html_response(conn, 200) =~ "New Top"
    end
  end

  describe "create top" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.top_path(conn, :create), top: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.top_path(conn, :show, id)

      conn = get(conn, Routes.top_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Top"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.top_path(conn, :create), top: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Top"
    end
  end

  describe "edit top" do
    setup [:create_top]

    test "renders form for editing chosen top", %{conn: conn, top: top} do
      conn = get(conn, Routes.top_path(conn, :edit, top))
      assert html_response(conn, 200) =~ "Edit Top"
    end
  end

  describe "update top" do
    setup [:create_top]

    test "redirects when data is valid", %{conn: conn, top: top} do
      conn = put(conn, Routes.top_path(conn, :update, top), top: @update_attrs)
      assert redirected_to(conn) == Routes.top_path(conn, :show, top)

      conn = get(conn, Routes.top_path(conn, :show, top))
      assert html_response(conn, 200) =~ "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, top: top} do
      conn = put(conn, Routes.top_path(conn, :update, top), top: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Top"
    end
  end

  describe "delete top" do
    setup [:create_top]

    test "deletes chosen top", %{conn: conn, top: top} do
      conn = delete(conn, Routes.top_path(conn, :delete, top))
      assert redirected_to(conn) == Routes.top_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.top_path(conn, :show, top))
      end
    end
  end

  defp create_top(_) do
    top = fixture(:top)
    %{top: top}
  end
end

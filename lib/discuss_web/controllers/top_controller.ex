defmodule DiscussWeb.TopController do
  use DiscussWeb, :controller

  alias Discuss.Topic
  alias Discuss.Topic.Top

  def index(conn, _params) do
    topic = Topic.list_topic()
    render(conn, "index.html", topic: topic)
  end

  ###def new(conn, _params) do
  ##  changeset = Topic.change_top(%Top{})
  #  render(conn, "new.html", changeset: changeset)
  #end

  # Från andra stället
  def new(conn, params) do
    changeset = Top.changeset(%Top{}, %{}) # 74

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"top" => top_params}) do
    case Topic.create_top(top_params) do
      {:ok, top} ->
        conn
        |> put_flash(:info, "Top created successfully.")
        |> redirect(to: Routes.top_path(conn, :show, top))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    top = Topic.get_top!(id)
    render(conn, "show.html", top: top)
  end

  def edit(conn, %{"id" => id}) do
    top = Topic.get_top!(id)
    changeset = Topic.change_top(top)
    render(conn, "edit.html", top: top, changeset: changeset)
  end

  def update(conn, %{"id" => id, "top" => top_params}) do
    top = Topic.get_top!(id)

    case Topic.update_top(top, top_params) do
      {:ok, top} ->
        conn
        |> put_flash(:info, "Top updated successfully.")
        |> redirect(to: Routes.top_path(conn, :show, top))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", top: top, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    top = Topic.get_top!(id)
    {:ok, _top} = Topic.delete_top(top)

    conn
    |> put_flash(:info, "Top deleted successfully.")
    |> redirect(to: Routes.top_path(conn, :index))
  end
end

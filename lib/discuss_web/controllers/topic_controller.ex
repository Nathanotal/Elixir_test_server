defmodule DiscussWeb.TopicController do
  # Denna är aktiv
  use DiscussWeb, :controller

  alias Discuss.Repo
  alias Discuss.Topic.Top

  def index(conn, _params) do
    topics = Repo.all(Top)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
      changeset = Top.changeset(%Top{}, %{}) # 74
      render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"top" => topic}) do
    changeset = Top.changeset(%Top{}, topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Top, topic_id)
    changeset = Top.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "top" => topic}) do
    oldTop = Repo.get(Top, topic_id)
    changeset = Top.changeset(oldTop, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: oldTop
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Top, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

end

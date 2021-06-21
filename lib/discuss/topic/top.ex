defmodule Discuss.Topic.Top do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topic" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(top, attrs \\ %{}) do
    top
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end

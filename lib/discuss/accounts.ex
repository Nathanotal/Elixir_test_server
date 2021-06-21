defmodule DiscussWeb.Accounts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(accounts, attrs \\ %{}) do
    accounts
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end

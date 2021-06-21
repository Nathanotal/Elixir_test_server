defmodule Discuss.TopicTest do
  use Discuss.DataCase

  alias Discuss.Topic

  describe "topic" do
    alias Discuss.Topic.Top

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def top_fixture(attrs \\ %{}) do
      {:ok, top} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topic.create_top()

      top
    end

    test "list_topic/0 returns all topic" do
      top = top_fixture()
      assert Topic.list_topic() == [top]
    end

    test "get_top!/1 returns the top with given id" do
      top = top_fixture()
      assert Topic.get_top!(top.id) == top
    end

    test "create_top/1 with valid data creates a top" do
      assert {:ok, %Top{} = top} = Topic.create_top(@valid_attrs)
      assert top.title == "some title"
    end

    test "create_top/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topic.create_top(@invalid_attrs)
    end

    test "update_top/2 with valid data updates the top" do
      top = top_fixture()
      assert {:ok, %Top{} = top} = Topic.update_top(top, @update_attrs)
      assert top.title == "some updated title"
    end

    test "update_top/2 with invalid data returns error changeset" do
      top = top_fixture()
      assert {:error, %Ecto.Changeset{}} = Topic.update_top(top, @invalid_attrs)
      assert top == Topic.get_top!(top.id)
    end

    test "delete_top/1 deletes the top" do
      top = top_fixture()
      assert {:ok, %Top{}} = Topic.delete_top(top)
      assert_raise Ecto.NoResultsError, fn -> Topic.get_top!(top.id) end
    end

    test "change_top/1 returns a top changeset" do
      top = top_fixture()
      assert %Ecto.Changeset{} = Topic.change_top(top)
    end
  end
end

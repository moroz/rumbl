defmodule Rumbl.UserTest do
  use Rumbl.ModelCase, async: true
  alias Rumbl.User

  @valid_attrs %{name: "John Paul", username: "jp2", password: "jp2137"}

  test "changeset is valid with valid attrs" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset is invalid with empty struct" do
    changeset = User.changeset(%User{}, %{})
  end

  test "changeset is invalid with long username" do
    username = String.duplicate("foobar", 5)
    attrs = Map.put(@valid_attrs, :username, username)
    changeset = User.changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "registration_changeset is invalid without username" do
    attrs = Map.put(@valid_attrs, :username, "")
    changeset = User.registration_changeset(%User{}, attrs)
    refute changeset.valid?
  end

  test "registration_changeset is invalid without password" do
    attrs = Map.put(@valid_attrs, :password, "")
    changeset = User.registration_changeset(%User{}, attrs)
    refute changeset.valid?
  end
end

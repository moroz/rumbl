defmodule Rumbl.UserTest do
  use Rumbl.ModelCase, async: true
  alias Rumbl.User

  @valid_attrs %{name: "John Paul", username: "jp2", password: "jp2137"}

  test "changeset is valid with valid attrs" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset does not accept long usernames" do
    username = String.duplicate("foobar", 5)
    attrs = Map.put(@valid_attrs, :username, username)
    changeset = User.changeset(%User{}, attrs)
    assert { :username, "should be at most 20 character(s)" } in
      errors_on(%User{}, attrs)
  end

  test "registration_changeset is valid with valid attrs" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "registration_changeset is invalid with empty struct" do
    changeset = User.registration_changeset(%User{}, %{})
    refute changeset.valid?
  end

  test "registration_changeset password must be at least 6 chars long" do
    attrs = Map.put(@valid_attrs, :password, "12345")
    changeset = User.registration_changeset(%User{}, attrs)
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

  test "registration_changeset with valid attributes hashes password" do
    attrs = Map.put(@valid_attrs, :password, "123456")
    changeset = User.registration_changeset(%User{}, attrs)
    %{password: pass, password_hash: pass_hash} = changeset.changes
    assert changeset.valid?
    assert pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end
end

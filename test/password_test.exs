defmodule Comeonin.PasswordTest do
  use ExUnit.Case, async: true

  alias Comeonin.Password

  test "password default length config" do
    Application.put_env(:comeonin, :pass_length, 8)
    assert Password.gen_password |> String.length == 8
    Application.put_env(:comeonin, :pass_length, 16)
    assert Password.gen_password |> String.length == 16
    Application.delete_env(:comeonin, :pass_length)
  end

  test "password minimum length config" do
    Application.put_env(:comeonin, :pass_min_length, 6)
    assert Password.valid_password?("4ghY&j2") == true
    Application.put_env(:comeonin, :pass_min_length, 8)
    assert Password.valid_password?("4ghY&j2") ==
    "The password is too short. It should be at least 8 characters long."
    Application.delete_env(:comeonin, :pass_min_length)
  end

  test "valid password has a digit and a symbol" do
    for id <- ["hfjkshf6hj#", "8auyk>kjkjh", "ty3uhi@ksd"] do
      assert Password.valid_password?(id)
    end
  end

  test "invalid password has no digit or symbol" do
    for id <- ["hfjkshfhj", "auykkjkjh", "tyuhiksd"] do
      assert Password.valid_password?(id) ==
      "The password should contain at least one digit and one punctuation character."
    end
  end

  test "invalid password has no digit" do
    for id <- ["hf:jksh#fhj", "au$ykkjkjh", "(tyu)hiksd"] do
      assert Password.valid_password?(id) ==
      "The password should contain at least one digit and one punctuation character."
    end
  end

  test "invalid password has no symbol" do
    for id <- ["h8fjkshfhj", "auykk2jkj1h", "0tyuhi67ksd"] do
      assert Password.valid_password?(id) ==
      "The password should contain at least one digit and one punctuation character."
    end
  end

  test "generate valid password" do
    assert Password.gen_password |> Password.valid_password?
  end

end
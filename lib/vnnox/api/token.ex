defmodule VNNOX.Api.Token do
  use VNNOX.Api

  def token(username, password, path) do
    payload = %{
      username: username,
      password: password
    }

    do_post(path, payload)
  end
end

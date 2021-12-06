defmodule VNNOX.Api.Token do
  @moduledoc false

  use VNNOX.Api

  def token(username, password) do
    payload = %{
      username: username,
      password: password
    }

    do_post("v1/oauth/token", payload)
  end
end

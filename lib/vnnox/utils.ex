defmodule VNNOX.Utils do
  @moduledoc false

  alias VNNOX.Parser
  alias VNNOX.TokenState

  def base_url do
    vnnox_domain = domain()

    base_domain =
      if String.ends_with?(vnnox_domain, "vnnox.com") or custom_domain() do
        vnnox_domain
      else
        "#{vnnox_domain}.vnnox.com"
      end

    "https://#{base_domain}/"
  end

  def base_url(_), do: base_url()
  def domain, do: get_config(:domain)

  def custom_domain do
    :vnnox_ex
    |> Application.get_env(:custom_domain, false)
    |> Kernel.in([true, "true"])
  end

  def get_token do
    case TokenState.get(:token) do
      token when is_binary(token) ->
        exp = TokenState.get(:exp)

        if expired?(exp) do
          fetch_token()
        else
          token
        end

      _ ->
        fetch_token()
    end
  end

  def http_opts, do: get_config(:http_opts) || []
  def ua, do: get_config(:user_agent) || "VNNOX_ex <https://github.com/vanillahsu/vnnox_ex>"
  def username, do: get_config(:username) || "test"

  def req_header(:token),
    do: [
      {"User-Agent", ua()},
      {"Content-Type", "application/json"},
      {"username", username()},
      {"token", get_token()}
    ]

  def req_header(_), do: req_header()

  def req_header,
    do: [
      {"User-Agent", ua()},
      {"Content-Type", "application/json"},
      {"username", get_config(:username)}
    ]

  defp get_config(key), do: Application.get_env(:vnnox_ex, key)

  defp fetch_token do
    username = get_config(:username)
    password = get_config(:password)
    bridge_url = get_config(:bridge_url)

    payload = %{
      username: username,
      password: password
    }

    {:ok, %{"response" => %{"data" => %{"token" => token, "expire" => expire}}}} =
      :post
      |> HTTPoison.request(bridge_url, Jason.encode!(payload), req_header(), http_opts())
      |> Parser.parse()

    TokenState.put(:token, token)
    TokenState.put(:exp, expire)
    token
  end

  defp expired?(exp), do: exp <= DateTime.utc_now() |> DateTime.to_unix()
end

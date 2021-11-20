defmodule VNNOX.Parser do
  @moduledoc false

  def parse(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}}
      when status in [200, 201] ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 204}} ->
        :ok

      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} ->
        {:error, body, status}

      {:error, %HTTPoison.Error{id: _, reason: reason}} ->
        {:error, %{reason: reason}}

      _ ->
        response
    end
  end
end

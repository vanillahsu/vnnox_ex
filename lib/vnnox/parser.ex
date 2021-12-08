defmodule VNNOX.Parser do
  @moduledoc false

  def parse(response) do
    case response do
      {:ok, %Tesla.Env{body: body, headers: _, status: status}} when status in [200, 201] ->
        {:ok, Jason.decode!(body)}

      {:ok, %Tesla.Env{body: _, headers: _, status: 204}} ->
        :ok

      {:ok, %Tesla.Env{body: body, headers: _, status: status}} ->
        {:error, body, status}

      {:error, %Tesla.Error{reason: reason}} ->
        {:error, %{reason: reason}}

      _ ->
        response
    end
  end
end

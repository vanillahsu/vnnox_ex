defmodule VNNOX.Client do
  @moduledoc false

  use Tesla

  plug(Tesla.Middleware.Retry,
    delay: 500,
    max_retries: 10,
    max_delay: 4_000,
    should_retry: fn
      {:ok, %{status: status}} when status in [400, 429, 500] -> true
      {:ok, _} -> false
      {:error, _} -> true
    end
  )
end

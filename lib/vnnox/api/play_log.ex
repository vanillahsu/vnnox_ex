defmodule VNNOX.Api.PlayLog do
  @moduledoc false

  use VNNOX.Api, for: :token

  def get_playlogs_item(id, start_date, end_date, start \\ 0, count \\ 20) do
    do_get("v1/playLog/getPlayLogsItem", %{
      playerId: id,
      startTime: start_date,
      endTime: end_date,
      count: count,
      start: start
    })
  end

  def get_playlogs_summary(id, start_date, end_date, start \\ 0, count \\ 20) do
    do_get("v1/playLog/getPlayLogsSummary", %{
      playerId: id,
      startTime: start_date,
      endTime: end_date,
      count: count,
      start: start
    })
  end
end

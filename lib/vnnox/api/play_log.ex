defmodule VNNOX.Api.PlayLog do
  use VNNOX.Api, for: :token

  def get_playlogs_item(id, start_date, end_date, start \\ 0, count \\ 20) do
    do_get("playLog/getPlayLogsItem", %{
      playerId: id,
      startTime: start_date,
      endTime: end_date,
      count: count,
      start: start
    })
  end
end

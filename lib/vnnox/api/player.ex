defmodule VNNOX.Api.Player do
  @moduledoc false

  use VNNOX.Api, for: :token

  def list(start \\ 0, count \\ 20) do
    do_get("v1/player/getPlayerList", %{start: start, count: count})
  end

  def restart(ids \\ []) when is_list(ids) do
    do_post("v1/player/immediateControl/reboot", %{playerIds: ids})
  end

  def power(ids \\ []) when is_list(ids) do
    do_post("v1/player/immediateControl/power", %{playerIds: ids})
  end

  def volumn(value, ids \\ []) when is_list(ids) do
    do_post("v1/player/immediateControl/volume", %{playerIds: ids, value: value})
  end

  def brighness(value, ids \\ []) when is_list(ids) do
    do_post("v1/player/immediateControl/brightness", %{playerIds: ids, value: value})
  end

  def screen_status(status, ids \\ []) when status in ["OPEN", "CLOSE"] and is_list(ids) do
    do_post("v1/player/immediateControl/screenStatus", %{playerIds: ids, status: status})
  end

  def simulcast(option, ids \\ []) when option in [0, 1] and is_list(ids) do
    do_post("v1/player/immediateControl/simulcast", %{playerIds: ids, option: option})
  end

  def screenshot(notice_url, ids \\ []) when is_list(ids) do
    do_post("v1/player/control/screenshot", %{playerIds: ids, noticeUrl: notice_url})
  end

  def ntp(enable, server, ids \\ []) when is_boolean(enable) and is_list(ids) do
    do_post("v1/player/immediateControl/ntp", %{playerIds: ids, server: server, enable: enable})
  end

  def lora(base_id, group_id, enable, ids \\ []) when is_boolean(enable) and is_list(ids) do
    do_post("v1/player/immediateControl/lora", %{
      playerIds: ids,
      basePlayerId: base_id,
      groupId: group_id,
      enable: enable
    })
  end

  def video_source(source, ids \\ []) when source in [0, 1] and is_list(ids) do
    do_post("v1/player/immediateControl/videoSource", %{playerIds: ids, source: source})
  end
end

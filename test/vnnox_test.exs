defmodule VNNOXTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "get token" do
    use_cassette "mocking" do
      {:ok, %{"data" => %{"token" => token}}} = VNNOX.Api.Token.token("test", "test")

      assert token == "1d7623462bb705c02955d79b1c3aa6e7"
    end
  end

  test "get player list" do
    use_cassette "mocking" do
      {:ok, %{"data" => data}} = VNNOX.Api.Player.list()

      assert data["total"] == 7
      assert data["pageInfo"]["start"] == 0
      assert data["pageInfo"]["count"] == 2
      assert hd(data["rows"])["playerId"] == "7fd6783109670b52103c5bab659701d5"
      assert hd(data["rows"])["name"] == "Taurus-50000983-2"
    end
  end
end

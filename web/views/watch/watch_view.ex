defmodule Rumbl.WatchView do
  use Rumbl.Web, :view

  def player_id(video) do
    ~r/^(?:https?:\/\/w{0,3}\.)?(?:youtu\.be\/|youtube\.com\/watch)\w*\?v=(?<id>[^#&?]*)/
    |> Regex.named_captures(video.url)
    |> get_in(["id"])
  end
end

defmodule HighScore do
  def new() do
    %{}
  end

  def add_player(scores, name, score \\ 0)

  def add_player(scores, name, score) do
    Map.put_new(scores, name, score)
  end

  def remove_player(scores, name) do
    {_removed_count, updated_map} = Map.pop(scores, name)
    updated_map
  end

  def reset_score(scores, name) do
    Map.put(scores, name, 0)
  end

  def update_score(scores, name, score) do
    cond do
      Map.has_key?(scores, name) ->
        Map.update!(scores, name, fn current_score -> current_score + score end)

      true ->
        add_player(scores, name, score)
    end
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end

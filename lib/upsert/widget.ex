defmodule Upsert.Widget do
  alias Upsert.Repo
  alias Upsert.Widgets.Widget

  def add(topic, group, offset) do
    cs =
      Widget.changeset(%Widget{}, %{topic: topic, group: group, last_handled_event_offset: offset})

    Repo.insert(
      cs,
      on_conflict: {:replace, [:last_handled_event_offset]},
      conflict_target: [:topic, :group]
    )
  end

  def add_unsafe(topic, group, offset) do
    cs =
      Widget.changeset(%Widget{}, %{topic: topic, group: group, last_handled_event_offset: offset})

    Repo.insert(cs)
    # Repo.all(Widget)
  end
end

defmodule Upsert.Widget do
  alias Upsert.Repo
  alias Upsert.Widgets.Widget

  def add(topic, group, offset) do
    cs = Widget.changeset(%Widget{}, %{topic: topic, group: group, offset: offset})

    Repo.insert!(
      cs,
      on_conflict: {:replace, [:offset]},
      conflict_target: [:topic, :group]
    )

    Repo.all(Widget)
  end

  def add_unsafe(topic, group, offset) do
    cs = Widget.changeset(%Widget{}, %{topic: topic, group: group, offset: offset})
    Repo.insert!(cs)
    Repo.all(Widget)
  end
end

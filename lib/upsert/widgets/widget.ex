defmodule Upsert.Widgets.Widget do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "widgets" do
    field :topic, :string, primary_key: true
    field :group, :string, primary_key: true
    field :last_handled_event_offset, :integer
  end

  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:topic, :group, :last_handled_event_offset])
    |> validate_required([:topic, :group, :last_handled_event_offset])
    |> unique_constraint([:topic, :group], name: "widgets_pkey")
  end
end

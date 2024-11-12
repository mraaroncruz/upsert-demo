defmodule Upsert.Widgets.Widget do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "widgets" do
    field :topic, :string, primary_key: true
    field :group, :string, primary_key: true
    field :offset, :integer
  end

  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:topic, :group, :offset])
    |> validate_required([:topic, :group, :offset])
  end
end

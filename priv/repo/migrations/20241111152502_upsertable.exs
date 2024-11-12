defmodule Upsert.Repo.Migrations.Upsertable do
  use Ecto.Migration

  def change do
    create table("widgets", primary_key: false) do
      add :topic, :string, primary_key: true
      add :group, :string, primary_key: true
      add :last_handled_event_offset, :integer
    end
  end
end

defmodule Todo.Repo.Migrations.RemoveProjectKeyFromTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      remove :project_id
    end
  end
end

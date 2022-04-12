defmodule Todo.Repo.Migrations.AddProjectIdIntoTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
    add :project_id, references(:projects)
    end
  end
end

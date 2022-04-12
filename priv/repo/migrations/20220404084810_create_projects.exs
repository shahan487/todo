defmodule Todo.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :discription, :text

      timestamps()
    end
  end
end

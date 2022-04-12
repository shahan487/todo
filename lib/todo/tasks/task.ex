defmodule Todo.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string
    belongs_to :project, Todo.Projects.Project, foreign_key: :project_id
    timestamps()
  end

  @doc false
  def changeset(task, attrs \\ %{}) do
    task
    |> cast(attrs, [:name, :project_id])
    |> validate_required([:name, :project_id])
    |> foreign_key_constraint(:project_id)
  end
end

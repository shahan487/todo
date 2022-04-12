defmodule Todo.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :discription, :string
    field :title, :string
    has_many :task, Todo.Tasks.Task
    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :discription])
    |> validate_required([:title, :discription])
  end
end

defmodule Todo.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Tasks.Task



  def list_tasks do
    Repo.all(Task)
  end

  def list_tasks_by_project_id(project_id) do
    query = from t in Task, where: t.project_id == ^project_id
    Repo.all(query)
  end




  def get_task!(id), do: Repo.get!(Task, id)



  def get_task_by_project!(id,project_id), do: Repo.get!(Task, id, project_id)





  def get_tasks_id_by_project_id(id,project_id) do
    query = from t in Task, where: t.id == ^id  and t.project_id == ^project_id

    # IO.inspect(query)
    #  task = %{:select =>  [query]}
    # |> Map.get(:select)
    # |> Enum.map(fn(x) -> String.to_atom(x) end)
    Repo.one(query)
  end


  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end


  def updates_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end



  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end


  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end


  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end

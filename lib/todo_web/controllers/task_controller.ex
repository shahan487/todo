defmodule TodoWeb.TaskController do
  use TodoWeb, :controller

  alias Todo.Tasks
  alias Todo.Tasks.Task

  def index(conn, %{"project_id" => project_id}) do
    tasks = Tasks.list_tasks_by_project_id(project_id)

    render(conn, "index.html", tasks: tasks, project_id: project_id)
  end

  def new(conn, %{"project_id" => project_id} = params) do
    changeset = Task.changeset(%Task{}, params)
    render(conn, "new.html", changeset: changeset, project_id: project_id)
  end

  @spec create(Plug.Conn.t(), %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          Plug.Conn.t()
  def create(conn, %{"project_id" => project_id} = params) do
    task_params = Map.get(params, "task", %{}) |> Map.put("project_id", project_id)

    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.project_task_path(conn, :show, task.project_id, task.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, project_id: project_id)
    end
  end

  def show(conn, %{"id" => id, "project_id" => project_id}) do
    task = Tasks.get_tasks_id_by_project_id(id, project_id)

    IO.inspect(task)

    # task = %{:select =>  [task]}
    # |> Map.get(:select)
    # |> Enum.map(fn(x) -> String.to_atom(x) end)

    render(conn, "show.html", task: task, project_id: project_id)
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"id" => id, "project_id" => project_id}) do
    task = Tasks.get_tasks_id_by_project_id(id, project_id)
    IO.inspect(task)
    changeset = Tasks.change_task(task)
    # IO.inspect(changeset, label: "shah")
    render(conn, "edit.html", task: task, changeset: changeset, project_id: project_id)
  end

  def update(conn, %{"id" => id, "project_id" => project_id} = params) do
    # task_params = Map.get(params, "task", %{}) |> Map.put("project_id", project_id)
    IO.inspect(params)

    case Tasks.update_task(params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.project_task_path(conn, :show, task.project_id, task.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, project_id: project_id)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.project_task_path(conn, :index, task.project_id))
  end
end

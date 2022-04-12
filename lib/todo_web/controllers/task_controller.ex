defmodule TodoWeb.TaskController do
  use TodoWeb, :controller

  alias Todo.Tasks
  alias Todo.Tasks.Task

  def index(conn, %{"project_id" => project_id}) do
    tasks = Tasks.list_tasks_by_project_id(project_id)
    IO.inspect(tasks)
    render(conn, "index.html", [tasks: tasks, project_id: project_id])
  end

  def new(conn, %{"project_id" => project_id } = params) do
    changeset = Task.changeset(%Task{}, params)
    IO.inspect(changeset)
    render(conn, "new.html", [changeset: changeset, project_id: project_id] )
  end

  @spec create(Plug.Conn.t(), %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          Plug.Conn.t()
  def create(conn, %{"project_id" => project_id}  = params) do
    IO.inspect(params)
    case Tasks.create_task(params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.project_task_path(conn, :show, task))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, project_id: project_id)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.html", task: task)
  end
end

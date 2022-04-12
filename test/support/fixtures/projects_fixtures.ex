defmodule Todo.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todo.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        discription: "some discription",
        title: "some title"
      })
      |> Todo.Projects.create_project()

    project
  end
end

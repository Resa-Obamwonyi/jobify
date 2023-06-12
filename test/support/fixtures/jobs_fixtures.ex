defmodule Jobify.JobsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Jobify.Jobs` context.
  """

  @doc """
  Generate a job.
  """
  def job_fixture(attrs \\ %{}) do
    {:ok, job} =
      attrs
      |> Enum.into(%{
        country: "some country",
        description: "some description",
        published: true,
        title: "some title"
      })
      |> Jobify.Jobs.create_job()

    job
  end

  @doc """
  Generate a industry.
  """
  def industry_fixture(attrs \\ %{}) do
    {:ok, industry} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Jobify.Jobs.create_industry()

    industry
  end
end

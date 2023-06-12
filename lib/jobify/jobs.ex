defmodule Jobify.Jobs do
  @moduledoc """
  The Jobs context.
  """

  import Ecto.Query, warn: false
  alias Jobify.Repo

  alias Jobify.Jobs.Job

  @doc """
  Returns the list of jobs.

  ## Examples

      iex> list_jobs()
      [%Job{}, ...]

  """
  def list_jobs do
    Repo.all(Job)
  end

  @doc """
  Gets a single job.

  Raises `Ecto.NoResultsError` if the Job does not exist.

  ## Examples

      iex> get_job!(123)
      %Job{}

      iex> get_job!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job!(id), do: Repo.get!(Job, id)

  @doc """
  Creates a job.

  ## Examples

      iex> create_job(%{field: value})
      {:ok, %Job{}}

      iex> create_job(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job(attrs \\ %{}) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job.

  ## Examples

      iex> update_job(job, %{field: new_value})
      {:ok, %Job{}}

      iex> update_job(job, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job(%Job{} = job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job.

  ## Examples

      iex> delete_job(job)
      {:ok, %Job{}}

      iex> delete_job(job)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job(%Job{} = job) do
    Repo.delete(job)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job changes.

  ## Examples

      iex> change_job(job)
      %Ecto.Changeset{data: %Job{}}

  """
  def change_job(%Job{} = job, attrs \\ %{}) do
    Job.changeset(job, attrs)
  end

  alias Jobify.Jobs.Industry

  @doc """
  Returns the list of industries.

  ## Examples

      iex> list_industries()
      [%Industry{}, ...]

  """
  def list_industries do
    Repo.all(Industry)
  end

  @doc """
  Gets a single industry.

  Raises `Ecto.NoResultsError` if the Industry does not exist.

  ## Examples

      iex> get_industry!(123)
      %Industry{}

      iex> get_industry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_industry!(id), do: Repo.get!(Industry, id)

  @doc """
  Creates a industry.

  ## Examples

      iex> create_industry(%{field: value})
      {:ok, %Industry{}}

      iex> create_industry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_industry(attrs \\ %{}) do
    %Industry{}
    |> Industry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a industry.

  ## Examples

      iex> update_industry(industry, %{field: new_value})
      {:ok, %Industry{}}

      iex> update_industry(industry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_industry(%Industry{} = industry, attrs) do
    industry
    |> Industry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a industry.

  ## Examples

      iex> delete_industry(industry)
      {:ok, %Industry{}}

      iex> delete_industry(industry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_industry(%Industry{} = industry) do
    Repo.delete(industry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking industry changes.

  ## Examples

      iex> change_industry(industry)
      %Ecto.Changeset{data: %Industry{}}

  """
  def change_industry(%Industry{} = industry, attrs \\ %{}) do
    Industry.changeset(industry, attrs)
  end
end

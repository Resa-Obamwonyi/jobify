defmodule JobifyWeb.JobController do
  use JobifyWeb, :controller

  alias Jobify.Jobs
  alias Jobify.Jobs.Job


  @filters_params_schema %{
    industry: [type: :integer],
    page: [type: :integer, number: [greater_than: 0], default: 1],
    per_page: [type: :integer, default: 2]
  }
  def index(conn, params) do
    filter = Tarams.cast!(params, @filters_params_schema)
    total = Jobs.count_jobs_admin(filter)
    jobs = Jobs.list_jobs_admin(filter)
    industries = Jobs.list_industries_options()
    render(conn, :index, jobs: jobs, industries: industries, total: total, filter: filter)
  end

  def new(conn, _params) do
    changeset = Jobs.change_job(%Job{})
    industries = Jobs.list_industries_options()
    render(conn, :new, changeset: changeset, industries: industries)
  end

  def create(conn, %{"job" => job_params}) do
    industries = Jobs.list_industries_options()
    case Jobs.create_job(job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: ~p"/jobs/#{job}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, industries: industries)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    render(conn, :show, job: job)
  end

  def edit(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    industries = Jobs.list_industries_options()
    changeset = Jobs.change_job(job)
    render(conn, :edit, job: job, changeset: changeset, industries: industries)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Jobs.get_job!(id)
    industries = Jobs.list_industries_options()

    case Jobs.update_job(job, job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: ~p"/jobs/#{job}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, job: job, changeset: changeset, industries: industries)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    {:ok, _job} = Jobs.delete_job(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: ~p"/jobs")
  end
end

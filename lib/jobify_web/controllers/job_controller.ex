defmodule JobifyWeb.JobController do
  use JobifyWeb, :controller

  alias Jobify.Jobs
  alias Jobify.Jobs.Job

  def index(conn, params) do
    {changeset, filter} = JobifyWeb.Filters.JobFilter.changeset(params["job_filter"])
    # IO.inspect(filter)
    # total = Collection.count_groups(group_filter)
    jobs = Jobs.list_jobs(filter)
    industries = Jobs.list_industries_options()
    render(conn, :index, jobs: jobs, industries: industries, changeset: changeset)
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

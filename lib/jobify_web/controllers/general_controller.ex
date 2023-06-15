defmodule JobifyWeb.GeneralJobController do
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

  def show(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    render(conn, :show, job: job)
  end
end

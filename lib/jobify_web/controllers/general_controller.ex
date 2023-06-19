defmodule JobifyWeb.GeneralJobController do
  use JobifyWeb, :controller

  alias Jobify.Jobs
  alias Jobify.Jobs.Job

  # @index_params_schema %{
  #   industry: [type: :integer, number: [greater_than: 0]],
  #   page: [type: :integer, number: [greater_than: 0], default: 1],
  # }

  def index(conn, params) do
    {changeset, filter} = JobifyWeb.Filters.JobFilter.changeset(params["job_filter"])
    # with {:ok, filter} <- Tarams.cast(params["job_filter"], @index_params_schema) do
    jobs = Jobs.list_jobs_general(filter)
    total = Jobs.count_jobs_general(filter)
    industries = Jobs.list_industries_options()
    render(conn, :index, jobs: jobs, industries: industries, changeset: changeset, total: total)
    # else
    #   {:error, errors} ->
    #     IO.inspect(errors)
    #     nil
    # end
  end

  def show(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    render(conn, :show, job: job)
  end
end

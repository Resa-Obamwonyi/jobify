defmodule JobifyWeb.GeneralJobController do
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
    jobs = Jobs.list_jobs_general(filter)
    total = Jobs.count_jobs_general(filter)
    industries = Jobs.list_industries_options()
    render(conn, :index, jobs: jobs, industries: industries, filter: filter, total: total)
  end

  def show(conn, %{"id" => id}) do
    job = Jobs.get_job!(id)
    render(conn, :show, job: job)
  end
end

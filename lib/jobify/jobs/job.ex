defmodule Jobify.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Jobify.Jobs.Industry
  use Filterable.Phoenix.Model


  # filterable do
  #   filter industry(query, value, _conn) do
  #     query |> where(industry_id: ^value)
  #   end
  # end

  schema "jobs" do
    field :country, :string
    field :description, :string
    field :published, :boolean, default: false
    field :title, :string
    belongs_to :industry, Industry

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:title, :description, :country, :published, :industry_id])
    |> validate_required([:title, :description, :country, :industry_id])
    |> assoc_constraint(:industry, message: "This Industry ID does not exist!!")
  end

  def industry(query, nil) do
    query
  end

  def industry(query, term) do
    from(job in query, where: job.industry_id == ^term)
  end

  def pagination(query, nil) do
    pagination(query, 1)
  end

  def pagination(query, page) do
    limit = 10
    offset = (page - 1) * limit

    query
    |> offset(^offset)
    |> limit(^limit)
  end
end

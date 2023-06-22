defmodule Jobify.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Jobify.Jobs.Industry
  use Filterable.Phoenix.Model

  filterable do
    paginateable(per_page: 5)

    filter industry(query, value) do
      query |> where(industry_id: ^value)
    end

    filter search(query, value) do
      wildcard_search = "%#{value}%"
      query |> where([job], ilike(job.title, ^wildcard_search))
    end
  end

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
end

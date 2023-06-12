defmodule Jobify.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jobify.Jobs.Industry

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

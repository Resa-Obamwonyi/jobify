defmodule Jobify.Jobs.Industry do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jobify.Jobs.Job

  schema "industries" do
    field :name, :string
    has_many :jobs, Job

    timestamps()
  end

  @doc false
  def changeset(industry, attrs) do
    industry
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

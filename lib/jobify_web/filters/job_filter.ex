defmodule JobifyWeb.Filters.JobFilter do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:industry, :integer)
    field(:page, :integer, default: 1)
  end

  def changeset(nil) do
    changeset(%{})
  end

  def changeset(params) do
    changeset =
      %__MODULE__{}
      |> cast(params, [:industry, :page])
      |> validate_number(:page, greater_than: 0)

    {changeset, apply_changes(changeset)}
  end
end

defmodule Jobify.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :description, :string
      add :country, :string
      add :published, :boolean, default: false, null: false
      add :industry_id, references(:industries)
      timestamps()
    end
  end
end

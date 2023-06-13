defmodule Jobify.Repo.Migrations.AlterDescriptionField do
  use Ecto.Migration

  def change do
    alter table("jobs") do
      modify :description, :text
    end
  end
end

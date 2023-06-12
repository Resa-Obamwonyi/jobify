defmodule JobifyWeb.IndustryController do
  use JobifyWeb, :controller

  alias Jobify.Jobs
  alias Jobify.Jobs.Industry

  def index(conn, _params) do
    industries = Jobs.list_industries()
    render(conn, :index, industries: industries)
  end

  def new(conn, _params) do
    changeset = Jobs.change_industry(%Industry{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"industry" => industry_params}) do
    case Jobs.create_industry(industry_params) do
      {:ok, industry} ->
        conn
        |> put_flash(:info, "Industry created successfully.")
        |> redirect(to: ~p"/industries/#{industry}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    industry = Jobs.get_industry!(id)
    render(conn, :show, industry: industry)
  end

  def edit(conn, %{"id" => id}) do
    industry = Jobs.get_industry!(id)
    changeset = Jobs.change_industry(industry)
    render(conn, :edit, industry: industry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "industry" => industry_params}) do
    industry = Jobs.get_industry!(id)

    case Jobs.update_industry(industry, industry_params) do
      {:ok, industry} ->
        conn
        |> put_flash(:info, "Industry updated successfully.")
        |> redirect(to: ~p"/industries/#{industry}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, industry: industry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    industry = Jobs.get_industry!(id)
    {:ok, _industry} = Jobs.delete_industry(industry)

    conn
    |> put_flash(:info, "Industry deleted successfully.")
    |> redirect(to: ~p"/industries")
  end
end

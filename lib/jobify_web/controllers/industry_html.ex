defmodule JobifyWeb.IndustryHTML do
  use JobifyWeb, :html

  embed_templates "industry_html/*"

  @doc """
  Renders a industry form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def industry_form(assigns)
end

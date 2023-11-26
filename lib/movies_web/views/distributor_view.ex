defmodule MoviesWeb.DistributorView do
  use MoviesWeb, :view
  alias MoviesWeb.DistributorView

  def render("index.json", %{distributors: distributors}) do
    %{data: render_many(distributors, DistributorView, "distributor.json")}
  end

  def render("show.json", %{distributor: distributor}) do
    %{data: render_one(distributor, DistributorView, "distributor.json")}
  end

  def render("distributor.json", %{distributor: distributor}) do
    %{
      id: distributor.id,
      name: distributor.name
    }
  end
end

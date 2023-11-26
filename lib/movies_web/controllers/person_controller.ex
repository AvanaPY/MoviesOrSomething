defmodule MoviesWeb.PersonController do
  use MoviesWeb, :controller

  alias Movies.People
  alias Movies.People.Person

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    people = People.list_people()
    render(conn, "index.json", people: people)
  end

  def create(conn, %{"person" => person_params}) do
    with {:ok, %Person{} = person} <- People.create_person(person_params) do
      conn
      |> put_status(:created)
      |> render("show.json", person: person)
    end
  end

  def show(conn, %{"id" => id}) do
    person = People.get_person!(id)
    render(conn, "show.json", person: person)
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    person = People.get_person!(id)

    with {:ok, %Person{} = person} <- People.update_person(person, person_params) do
      render(conn, "show.json", person: person)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = People.get_person!(id)

    with {:ok, %Person{}} <- People.delete_person(person) do
      send_resp(conn, :no_content, "")
    end
  end
end

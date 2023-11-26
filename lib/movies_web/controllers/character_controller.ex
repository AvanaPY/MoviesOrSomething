defmodule MoviesWeb.CharacterController do
  use MoviesWeb, :controller

  alias Movies.Characters
  alias Movies.Characters.Character

  action_fallback MoviesWeb.FallbackController

  def index(conn, _params) do
    characters = Characters.list_characters()
    render(conn, "index.json", characters: characters)
  end

  def create(conn, %{"character" => character_params}) do
    with {:ok, %Character{} = character} <- Characters.create_character(character_params) do
      conn
      |> put_status(:created)
      |> render("show.json", character: character)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Characters.get_character!(id)
    render(conn, "show.json", character: character)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character = Characters.get_character!(id)

    with {:ok, %Character{} = character} <- Characters.update_character(character, character_params) do
      render(conn, "show.json", character: character)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Characters.get_character!(id)

    with {:ok, %Character{}} <- Characters.delete_character(character) do
      send_resp(conn, :no_content, "")
    end
  end
end

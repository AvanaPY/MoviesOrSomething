
defmodule Movies.Debugger do
  defmodule Converter do
    def convert!("true"), do: true
    def convert!("false"), do: false
    def convert!(nil), do: nil
    def convert!(_), do: false
  end

  defmacro debug(message) do
    IO.puts System.get_env("DEBUG", "false")
    if Converter.convert!(System.get_env("DEBUG", "false")) == true do
      IO.puts "DEBUG!"
      quote do
        IO.puts "[DEBUG] #{unquote(message)}"
      end
    end
  end

  defmacro info(message) do
    if Converter.convert!(System.get_env("DEBUG", "false")) == true  do
      quote do
        IO.puts "[INFO] #{unquote(message)}"
      end
    end
  end
end

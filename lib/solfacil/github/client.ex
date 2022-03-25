defmodule Solfacil.Github.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"User-Agent", "Mozilla/5.0"}]
  plug Tesla.Middleware.JSON

  def get_dev(username) do
    "/users/#{username}"
    |> get()
    |> handle_response()
    |> to_dev_attrs()
    |> IO.inspect()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 404}}), do: {:error, "dev not found"}
  defp handle_response({:error, _reason} = error), do: error

  defp to_dev_attrs({:ok, %{"login" => username} = attrs}) do
    {:ok, Map.put(attrs, "username", username)}
  end

  defp to_dev_attrs(error), do: error
end

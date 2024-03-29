defmodule NektoClient.HTTPClient do
  @moduledoc """
  Provides functions for Nekto.me HTTP API
  """

  alias NektoClient.Headers
  alias NektoClient.Cookies

  @doc """
  Gets headers from nekto chat and parses chat_token
  """
  def chat_token!(host) do
    HTTPoison.head!(chat_url(host)).headers
    |> Headers.find("Set-Cookie")
    |> Enum.join("; ")
    |> Cookies.parse
    |> List.keyfind("chat_token", 0)
    |> elem(1)
  end

  defp chat_url(host) do
    "#{host}/chat"
  end
end

defmodule Scraper do
  @html_path File.cwd!() <> "/files/van-gogh-paintings.html"
  @google_prefix "https://www.google.com"

  def get_artworks(file_path \\ @html_path) do
    file_path
    |> read_html
    |> parse_images
  end

  defp read_html(file_path) do
    file_path
    |> File.read!()
    |> Floki.parse()
  end

  defp parse_images(html) do
    html
    |> Floki.find("a.klitem")
    |> Enum.map(fn a ->
      result = %{
        "name" => get_name(a),
        "extensions" => get_extensions(a),
        "link" => get_link(a),
        "thumbnail" => get_thumbnail(a)
      }
    end)
  end

  defp get_name(a), do: Floki.attribute(a, "aria-label") |> List.first()

  defp get_extensions(a), do: Floki.find(a, ".klmeta") |> Enum.map(&Floki.text/1)

  defp get_thumbnail(a), do: Floki.find(a, "img") |> Floki.attribute("data-key") |> List.first()

  defp get_link(a) do
    url = Floki.attribute(a, "href") |> List.first()

    case String.starts_with?(url, @google_prefix) do
      true -> url
      false -> @google_prefix <> url
    end
  end
end

defmodule ScraperTest do
  use ExUnit.Case
  doctest Scraper

  @html_wassily_path File.cwd!() <> "/files/wassily-kandinsky-paintings.html"
  @expected_json_path File.cwd!() <> "/files/expected-array.json"

  test "compare against sample result set" do
    exp_result = get_expected_json()["artworks"]
    result = Scraper.get_artworks()

    Enum.each(exp_result, fn artwork ->
      found = find_artwork(artwork, result)

      assert artwork["name"] == found["name"]
      assert artwork["link"] == found["link"]

      case is_list(artwork["extensions"]) do
        true ->
          assert artwork["extensions"] |> List.first() === found["extensions"] |> List.first()

        false ->
          assert is_nil(artwork["extensions"])
          assert found["extensions"] == []
      end
    end)
  end

  test "compare against different html" do
    artworks = Scraper.get_artworks()
    first_artwork = artworks |> List.first()

    assert first_artwork["name"] == "The Starry Night"
    assert first_artwork["extensions"] == ["1889"]

    assert first_artwork["link"] ==
             "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"

    assert first_artwork["thumbnail"] ==
             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0"

    Enum.each(artworks, fn artwork ->
      assert is_binary(artwork["name"])
      assert is_list(artwork["extensions"])
      assert artwork["link"] =~ "https://www.google.com"
    end)
  end

  defp get_expected_json do
    @expected_json_path
    |> File.read!()
    |> Poison.decode!()
  end

  defp find_artwork(%{"link" => link}, artworks) do
    Enum.find(artworks, &(&1["link"] == link))
  end
end

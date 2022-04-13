defmodule MelpWeb.PageController do
  use MelpWeb, :controller

  import Ecto.Query
  alias Melp.Repo
  import Geo.PostGIS
  alias Melp.Apimelp
  alias Melp.Apimelp.Restaurant

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def statics(conn, %{"latitude" => latitude, "longitude" => longitude, "radius" => radius}) do
    count =
      filter_count(latitude |> String.to_float(), longitude |> String.to_float(), radius |> String.to_integer)
        |> IO.inspect(label: "Result")
    avg =
      filter_avg(latitude |> String.to_float(), longitude |> String.to_float(), radius |> String.to_integer)
        |> IO.inspect(label: "Result")

    final =
      %{
        count: count,
        avg: avg
      }


    json put_status(conn, 200), final
  end

  def statics(conn, _) do
    json put_status(conn, 200), %{"message" => "Error"}
  end


  def filter_count(x, y, z) do
    z = z * 0.00001
    query = from r in Restaurant, select: count(r), where: st_intersects(st_buffer(st_set_srid(st_point(^x, ^y), 4326), ^z), r.geom)
    Repo.all(query)
  end

  def filter_avg(x, y, z) do
    z = z * 0.00001
    query = from r in Restaurant, select: avg(r.rating), where: st_intersects(st_buffer(st_set_srid(st_point(^x, ^y), 4326), ^z), r.geom)
    Repo.all(query)
  end


  defp to_watever([], new_format), do: new_format
  defp to_watever([value|rest], new_format) do
    to_watever(rest,
      new_format ++ [
        %{
          code: value.query,
          city: value.query2,
          site: value.site
        }
      ]
    )
  end


end

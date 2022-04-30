defmodule Pratipad.Example.Processor.Precipitation do
  alias Pratipad.Processor
  use Processor

  @default_interval 30 * 60 * 1_000

  @impl GenServer
  def init(opts \\ []) do
    interval = opts[:interval] || @default_interval
    schedule(0)

    {:ok,
     %{
       interval: interval,
       precipitation: nil
     }}
  end

  @impl Processor
  def process(data, state) do
    Map.put(data, :precipitation, retrieve_precipitation(state))
  end

  @impl GenServer
  def handle_info(:retrieve_precipitation, state) do
    precipitation = retrieve_precipitation(%{state | precipitation: nil})
    schedule(state.interval)
    {:noreply, %{state | precipitation: precipitation}}
  end

  defp schedule(interval) do
    Process.send_after(self(), :retrieve_precipitation, interval)
  end

  defp retrieve_precipitation(state) do
    if state.precipitation do
      state.precipitation
    else
      # 気象庁｜最新の気象データ | CSVダウンロード | データ部掲載内容
      # https://www.data.jma.go.jp/obd/stats/data/mdrr/docs/csv_dl_format_prenh.html
      precipitation =
        "https://www.data.jma.go.jp/obd/stats/data/mdrr/pre_rct/alltable/pre1h00_rct.csv"
        |> Req.get!()
        |> Map.get(:body)
        |> Enum.find(fn [num | _] ->
          num == "44132"
        end)
        |> Enum.at(9)
        |> String.to_float()

      precipitation / 1
    end
  end
end

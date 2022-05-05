defmodule Benchmark do
  def start(opts) do
    Benchmark.Worker.start_link(opts)
  end

  def stop(pid) do
    send(pid, :stop)
  end
end

defmodule Pratipad.Example.Dataflow.Demand do
  use Pratipad.Dataflow
  alias Pratipad.Dataflow.{Demand, Output}
  alias Pratipad.Example.Processor.Precipitation

  def declare() do
    Demand ~> Precipitation ~> Output
  end
end

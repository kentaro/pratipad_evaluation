defmodule Pratipad.Example.Dataflow.Push do
  use Pratipad.Dataflow
  alias Pratipad.Dataflow.{Push, Output}
  alias Pratipad.Example.Processor.Precipitation

  def declare() do
    Push ~> Precipitation ~> Output
  end
end

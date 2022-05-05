Logger.configure(level: :info)
:ets.new(:counter, [:set, :protected, :named_table])
:ets.insert_new(:counter, {:count, 0})
:ets.lookup(:counter, :count)

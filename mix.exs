defmodule MyApp.MixFile do
  use Mix.Project
  def project do
    [app: :kvs,
     version: "0.0.1"]
  end
  def application do
    [mod: {KvsApp,[]},
     applications: [:sasl ],
     registered: [:kvs],
     description: 'Hello Server App']

  end
end

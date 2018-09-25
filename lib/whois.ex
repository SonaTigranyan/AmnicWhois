defmodule Whois do
  require Logger

  def connect(domain_name) do
    host = 'whois.amnic.net'
    case :gen_tcp.connect(host, 43, [packet: 0, active: false]) do
      {:ok, socket} ->
        send(socket, domain_name)
      {:error, errno} ->
        Logger.error "connction error"
    end
  end

  def send(socket, domain_name) do
    case :gen_tcp.send(socket, domain_name) do
      {:ok, socket} ->

      {:error, errno} ->
        Logger.error "send error"
      end
  end

  def recv() do
  end
end

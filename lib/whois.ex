defmodule Whois do
  require Logger


  def is_avail? (domain_name) do
    do_connect(domain_name)
  end

  def do_connect(domain_name) do
    host = 'whois.amnic.net'
    case :gen_tcp.connect(host, 43, [packet: 0, active: false]) do
      {:ok, socket} ->
        do_send(socket, domain_name)
      {:error, errno} ->
        Logger.error errno
    end
  end

  def do_send(socket, domain_name) do
    case :gen_tcp.send(socket, domain_name ++ '\r\n') do
      :ok ->
        do_recv(socket, 0)
      {:error, errno} -> 
        Logger.error errno
      end
  end

  def do_recv(socket, length) do
    case :gen_tcp.recv(socket, length) do
      {:ok, data} -> 
        data_handler(data)
      {:error, errno} -> 
        Logger.error errno
    end
  end

  def data_handler(data) do
    data |> to_string |> String.ends_with?("\n\nNo match\n\n")
  end

end

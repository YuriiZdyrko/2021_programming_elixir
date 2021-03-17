defmodule MultiProcess do
  def process(parent_id) do
    # 1 - parent receives :hi in it's mailbox
    # send(parent_id, :hi)

    # 2, 3 - parent goes down, or receives :DOWN
    # raise "I fail"
  end
  def run do
    # 2 - parent goes down
    # spawn_link(MultiProcess, :process, [self()])

    # 3 - parent receives :DOWN message
    spawn_monitor(MultiProcess, :process, [self()])

    :timer.sleep 500
    receive_loop()
  end

  def receive_loop do
    receive do
      msg ->
        IO.inspect(msg)
        receive_loop()
      after
        1000 ->
          IO.inspect("stop receiving")
    end
  end
end

class SayController < ApplicationController
  def hello
    @time = Time.now
    @three = 1 + 2
  end

  def goodbye
  end

end

class Polaroid::Stack < Bridgetown::Component
  def initialize(album, stack: 5)
    @album = album
    @stack = stack
  end
end
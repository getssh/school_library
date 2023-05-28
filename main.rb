require_relative 'app'

def main
  app = App.new
  app.run
end

main if $PROGRAM_NAME == __FILE__

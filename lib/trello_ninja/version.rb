module TrelloNinja
  class Version
    MAJOR = 0 unless defined? BasecampNinja::MAJOR
    MINOR = 1 unless defined? BasecampNinja::MINOR
    PATCH = 0 unless defined? BasecampNinja::PATCH
    PRE   = 1 unless defined? BasecampNinja::PRE

    class << self

      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
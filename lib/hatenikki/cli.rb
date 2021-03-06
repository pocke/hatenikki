module Hatenikki
  class CLI
    CONFIG_DIR = Pathname(File.expand_path("~/.config/hatenikki"))
    HATENABLOG_CONFIG_PATH = CONFIG_DIR / 'hatenablog.yaml'

    def initialize(argv)
      @argv = argv
    end

    def run
      case subcommand
      when 'load', 'save', 'publish'
        __send__ subcommand
      else
        raise "Unknown subcommand: #{subcommand}"
      end
    end

    # Load today's diary.
    private def load
      if entry = todays_entry
        if match = entry.title.match(/ - (?<subtitle>.+)/)
          puts "title: #{match[:subtitle]}"
        end
        puts entry.content
      end
    end

    # Save today's diary as draft
    private def save
      content = STDIN.read
      categories = []

      title, content = title_and_content(content)

      if entry = todays_entry
        client.update_entry(
          entry.id,
          title,
          content,
          categories,
          entry.draft,
        )
      else
        client.post_entry(
          title,
          content,
          categories,
          'yes', # draft
        )
      end
    end

    private def title_and_content(content)
      if match = content.match(/\Atitle: (?<subtitle>.+)/)
        ["#{today} - #{match[:subtitle]}", content.sub(/.+\n/, '')]
      else
        [today, content]
      end
    end

    # Publish drafts except today's
    private def publish
      client.entries.each do |e|
        next unless e.draft?
        next if e.title == today

        draft = 'no'
        client.update_entry(e.id, e.title, e.content, e.categories, draft)
        puts "#{e.title} has been published."
      end
    end

    private def client
      @client ||= Hatenablog::Client.create(HATENABLOG_CONFIG_PATH)
    end

    private def subcommand
      @argv[0]
    end

    private def todays_entry?(entry)
      entry.title.match?(/\A#{Regexp.escape(today)}\b/)
    end

    private def todays_entry
      client.entries.find{|entry| todays_entry?(entry) }
    end

    private def today
      # TODO: configurable the offset
      @today ||= (Time.now - 4 * 60 * 60).strftime('%Y-%m-%d')
    end
  end
end

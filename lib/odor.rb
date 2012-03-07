require "odor/version"

module Odor
  def self.run(*args)
    changed_files = %x[git status -s #{path}]
  end

  def check_file(filename)
    changes = %x[git diff -U0 #{filename}]
    puts changes
    issues = %x[rails_best_practices -f text #{filename}]
    puts issues
  end
end

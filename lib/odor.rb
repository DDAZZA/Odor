require "odor/version"

module Odor
  def self.run(*args)
    changed_files = %x[git status -s]
    changed_files.split("\n").each do |line|
      line = line.split
      check_file(line.last)
    end
  end

  def self.check_file(filename)
    changes = %x[git diff -U0 #{filename}]
    
    puts changes.split("\n")
    issues = %x[rails_best_practices -f text #{filename}]
    puts issues   
  end
end

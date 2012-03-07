require "odor/version"

module Odor
  def self.run(*args)
    changed_files = %x[git status -s]

    changed_files.split("\n").each do |line|
      line = line.split
      check_file(line.last)
    end

    puts "No smells found" unless @smell_detected
  end

  def self.check_file(filename)
    line_numbers = line_changes(filename)
    issues = %x[rails_best_practices -f text #{filename} --silent --without-color].split("\n")

    issues.each do |hint|
      line_numbers.each do |num|
        number = num.to_s
        if hint.include?(number)
          puts hint
          @smell_detected = true
          break
        end
      end
    end
  end

  def self.line_changes(filename)
    changes = %x[git diff -U0 #{filename}]
    changes = changes.split("\n")
    changes.shift(4)
    #changes = changes.map{ |c| c if !c.nil? && c.start_with?('@') }

    line_changes = []
    changes.each do |c|
      line_changes << c if !c.nil? && c.start_with?('@')
    end

    lines = []

    line_changes.each do |s|
      s = s.split

      s.shift(2)
      li = s.first[1, 50].split(',')

      li.last.to_i.times do |i|
        lines << li.first.to_i + i
      end
    end

#    s = changes.first.split
#    s.shift(2)
#    li = s.first[1, 50].split(',')
#
#    li.last.to_i.times do |i|
#      lines << li.first.to_i + i
#    end
    return lines
  end
end

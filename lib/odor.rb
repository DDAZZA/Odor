require "odor/version"

module Odor
  def self.run(*args)
    %x[git status -s].split("\n").each do |line|
      check_file(line.split.last)
    end

    puts "No smells found" unless @smell_detected
  end

  def self.check_file(file_name)
    issues(file_name).each do |hint|
      line_changes(file_name).each do |num|
        if hint.include?(num.to_s)
          puts hint
          @smell_detected = true
          break
        end
      end
    end
  end

  def self.issues(file_name)
    %x[rails_best_practices -f text #{file_name} --silent --without-color].split("\n")
  end

  def self.file_diff(file_name)
    changes = %x[git diff -U0 #{file_name}].split("\n")
    changes.shift(4)

    line_changes = []
    changes.each { |c| line_changes << c if !c.nil? && c.start_with?('@') }
    return line_changes
  end

  # TODO split into mutiple methods
  def self.line_changes(file_name)
    lines = []

    file_diff(file_name).each do |s|
      s = s.split
      s.shift(2)

      li = s.first[1, 12].split(',')
      li.last.to_i.times do |i|
        lines << li.first.to_i + i
      end
    end

    return lines
  end
end

require 'colorize'

# Directory of the dotfiles repo
DOTFILESDIR = File.dirname __FILE__

# files will be linked to user's home dir.
DESTDIR = ENV['HOME']

task :default => 'dotfiles:make_symlinks'
task :install => 'dotfiles:install'

namespace :dotfiles do

  ###
  # Installs the dotfiles into the destination directory.
  task :install do

    puts "Pulling dependencies...".colorize(:white)
    system "git -C #{DOTFILESDIR} submodule init"
    system "git -C #{DOTFILESDIR} submodule update"
    
    Rake::Task["dotfiles:make_symlinks"].invoke
  end

  ###
  # Creates symlinks for all files in ~/.dotfiles
  task :make_symlinks do

    puts "Making symlinks for dotfiles...".colorize(:white)

    # list of files to symlink
    files = Dir.glob "#{DOTFILESDIR}/**/*.symlink"

    files.each do |filepath|

      # extract just the filename from the path
      filename = File.basename(filepath, File.extname(filepath))

      # create the symlinks, overriding any existing links/files.
      dest = "#{DESTDIR}/.#{filename}"

      # create the symlink and check result
      res = system "ln -snFf #{filepath} #{dest}"
      puts "ERROR (#{$?.exitstatus})".colorize(:red) unless res

      # output
      puts "#{filepath} -> #{dest}".colorize(:green)
    end
  end

  task :rm_symlinks do

    puts "Removing symlinks for dotfiles...".colorize(:white)

    # list of files to symlink
    files = Dir.glob "#{DOTFILESDIR}/**/*.symlink"

    files.each do |filepath|

      # extract just the filename from the path
      filename = File.basename(filepath, File.extname(filepath))

      # create the symlinks, overriding any existing links/files.
      dest = "#{DESTDIR}/.#{filename}"

      # create the symlink and check result
      res = system "rm #{dest}"

      # output
      puts "Deleted #{dest}".colorize(:green) if res
    end
  end
end

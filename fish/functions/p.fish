function p
  if test (count $argv) = 0
    zvm upgrade
    zvm use 0.14.0
    paru --assume-installed zig -Syu
    zvm use master
  else if test (count $argv) = 1 && test $argv[1] = "--helix"
    zvm upgrade
    zvm use 0.14.0
    paru --assume-installed zig -Syu
    zvm use master
    update-helix
  else
    paru $argv
  end
end

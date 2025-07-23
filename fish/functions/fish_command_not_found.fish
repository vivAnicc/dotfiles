function fish_command_not_found
    set -l BR (set_color --bold red)
    set -l BG (set_color --bold green)
    set -l B (set_color blue)
    set -l BB (set_color --bold blue)
    set -l BY (set_color --bold yellow)
    set -l RESET (set_color normal)
    read -P "Search for package in repositories?$BY [y/N] $RESET" -l -n 1 search
    if test y != (string lower "$search")
        return 0
    end
    echo
    set package_name (p -F --machinereadable "/usr/bin/$argv[1]" "/usr/lib/$argv[1]" "/usr/lib32/$argv[1]" 2>/dev/null | awk -F"\0" "{print \$2;exit}")
    if test -z "$package_name"
        echo -s $BR "Couldn't find the package containing the" $B " $argv[1]" $BR " command\n"
        return 1
    end
    echo -s $BG "Command" $B " $argv[1]" $BG " not found, but was found in the" $BY " $package_name" $BG " package.\n"
    read -P "Would you like to install it?$BY [y/N] $RESET" -n 1 confirm
    if test y = (string lower "$confirm")
        p -S --needed "$package_name"
    end
end

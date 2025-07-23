function setup_ssh
    # nordvpn disconnect
    lights off
    bash -c 'read -rsn1 -p "" tmp'
    lights on
    # nordvpn connect
end
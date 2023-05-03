let python3_custom = '/home/ilan.schemoul/.nix-profile/bin/python3.10'

if filereadable(python3_custom)
    let g:python3_host_prog = python3_custom
endif

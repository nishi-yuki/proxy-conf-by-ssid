function __proxy_conf_by_ssid_config
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    set -l config $XDG_CONFIG_HOME/ssid-proxy.conf
    python3 -c '
import configparser
import sys

config_file = sys.argv[1]
cmd = sys.argv[2]
args = sys.argv[3:]

config = configparser.ConfigParser()
#print(config_file)
config.read(config_file)

if cmd == "get":
    try:
        #print("get", args)
        print(config[args[0]][args[1]])
    except:
        exit(1)
elif cmd == "have":
    if len(args)>0 and args[0] in config.sections():
        exit(0)
    else:
        exit(1)
' $config $argv
return $status
end
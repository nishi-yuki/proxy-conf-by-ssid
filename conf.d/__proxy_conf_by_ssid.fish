function __proxy_conf_by_ssid_set_ssid --on-event fish_preexec
    if command -sq iwgetid
        set -l s (iwgetid --raw)
        test "$ssid" != "$s"; and set -g ssid $s
    else
        echo '[proxy-conf-by-ssid] Sorry. This system is not supported :(' 1>&2
        return
    end
end

function __proxy_conf_by_ssid_proxy_update --on-variable ssid
    echo 'update'
    if test -z "$ssid"
        set -e http_proxy
        set -e HTTP_PROXY
        set -e https_proxy
        set -e HTTPS_PROXY
        return 0
    end
    if __proxy_conf_by_ssid_config have $ssid
        set -gx http_proxy   (__proxy_conf_by_ssid_config get $ssid http_proxy)
        set -gx HTTP_PROXY   $http_proxy
        set -gx https_proxy  (__proxy_conf_by_ssid_config get $ssid http_proxy)
        set -gx HTTPS_PROXY  $https_proxy
    end
    return 0
end



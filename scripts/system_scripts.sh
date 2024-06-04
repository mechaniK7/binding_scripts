## Universal script for executing system commands with quick access ##

# This script works only with classic-build workspaces
function setsrc 
{
    echo "---- Setting source this package to bashrc ----"
    echo source $(pwd)/install/setup.bash >> ~/.bashrc
    echo "---- Result:"
    echo "source $(pwd)/install/setup.bash"
}

# This script
function showip
{
    echo "-------------------------------------------------------"

    # Получить имена сетевых устройств
    wifi_device=$(nmcli device status | grep 'wifi ' | awk '{print $1}')
    eth_device=$(nmcli device status | grep 'ethernet ' | awk '{print $1}')

    # Получить IP-адреса
    dynamic_wifi_ip=$(ip addr show | grep 'dynamic' | grep $wifi_device | awk '{print $2}' | cut -f1 -d'/')
    static_wifi_ip=$(ip addr show | grep -v 'dynamic' | grep 'inet\ .*noprefix' | grep $wifi_device | awk '{print $2}' | cut -f1 -d'/')

    dynamic_eth_ip=$(ip addr show | grep 'dynamic' | grep $eth_device | awk '{print $2}' | cut -f1 -d'/')
    static_eth_ip=$(ip addr show | grep -v 'dynamic' | grep 'inet\ .*noprefix' | grep $eth_device | awk '{print $2}' | cut -f1 -d'/')

    if [ ! -z "$dynamic_wifi_ip" ] && [ ! -z "$dynamic_eth_ip" ]; then
        echo "Динамический IP-адрес: $dynamic_wifi_ip | Тип подключения: Wifi | Устройство: $wifi_device"
        echo "Динамический IP-адрес: $dynamic_eth_ip | Тип подключения: Ethernet | Устройство: $eth_device"
        echo "Статический IP-адрес не установлен."
    else
        if [ ! -z "$static_wifi_ip" ] && [ ! -z "$static_eth_ip" ]; then
            echo "Динамический IP-адрес не установлен."
            echo "Статический IP-адрес: $static_wifi_ip | Тип подключения: Wifi | Устройство: $wifi_device"
            echo "Статический IP-адрес: $static_eth_ip | Тип подключения: Ethernet | Устройство: $eth_device"
        else
            ####
            # Получить IP-адреса
            dynamic_ip=$(ip addr show | grep 'dynamic' | awk '{print $2}' | cut -f1 -d'/')
            static_ip=$(ip addr show | grep -v 'dynamic' | grep 'inet\ .*noprefix' | awk '{print $2}' | cut -f1 -d'/')

            if [ -z "$dynamic_ip" ]; then
                echo "Динамический IP-адрес не установлен."
            else
                # Получить имя сетевого устройста в соответствии с полученным IP-адресом
                get_dynamic_device=$(ip addr show | grep $dynamic_ip | awk '{print $9}')
                
                if [ "$wifi_device" = "$get_dynamic_device" ]; then
                    net_info=Wifi
                else
                    net_info=Ethernet
                fi

                # Вывести динамический IP-адрес
                echo "Динамический IP-адрес: $dynamic_ip | Тип подключения: $net_info | Устройство: $get_dynamic_device"
            fi

            if [ -z "$static_ip" ]; then
                echo "Статический IP-адрес не установлен."
            else
                # Получить имя сетевого устройста в соответствии с полученным IP-адресом
                get_static_device=$(ip addr show | grep $static_ip | awk '{print $8}')

                if [ "$eth_device" = "$get_static_device" ]; then
                    net_info=Ethernet
                else
                    net_info=Wifi
                fi

                # Вывести статический IP-адрес
                echo "Статический IP-адрес: $static_ip | Тип подключения: $net_info | Устройство: $get_static_device"
            fi
            ####
        fi
    fi
}
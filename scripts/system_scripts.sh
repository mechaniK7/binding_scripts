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
    #ip address show $1

    # Получить имя сетевого интерфейса
    #interface=$(ip route get 8.8.8.8 | awk '{print $3}')
    interface=$1

    # Получить динамический IP-адрес
    dynamic_ip=$(ip addr show $interface | grep 'dynamic' | awk '{print $2}' | cut -f1 -d'/')

    # Проверить, установлен ли статический IP-адрес
    static_ip=$(ip addr show | grep -v "dynamic" | grep 'inet\ .*noprefix' | awk '{print $2}' | cut -f1 -d'/')

    if [ -z "$dynamic_ip" ]; then
        echo "Динамический IP-адрес не установлен."
    else
        # Вывести динамический IP-адрес
        echo "Динамический IP-адрес: $dynamic_ip"
    fi

    if [ -z "$static_ip" ]; then
        echo "Статический IP-адрес не установлен."
    else
        # Вывести статический IP-адрес
        echo "Статический IP-адрес: $static_ip"
    fi
}
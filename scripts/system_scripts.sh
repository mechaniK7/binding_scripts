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
    dynamic_ip=$(ip addr show $interface | grep 'inet\ .*dynamic' | awk '{print $2}')

    # Проверить, установлен ли статический IP-адрес
    static_ip=$(ip addr show $interface | grep 'inet\ .*brd' | awk '{print $2}')

    # Если статический IP-адрес не установлен, вывести сообщение
    if [ -z "$static_ip" ]; then
    echo "Статический IP-адрес не установлен."
    else
    # Вывести статический IP-адрес
    echo "Статический IP-адрес: $static_ip"
    fi

    # Вывести динамический IP-адрес
    echo "Динамический IP-адрес: $dynamic_ip"

}
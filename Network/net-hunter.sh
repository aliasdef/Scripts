#!/bin/bash
#Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

#Токен бота
BOT_TOKEN=""
CHAT_ID=""


# Очищаем экран
clear

# Генерация текущей даты и времени для логов
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo -e ${RED}"====================================================================="
echo " #     #    #    ####### ####### #     # #######                     "
echo " #     #   # #      #    #       ##   ## #                           "
echo " #     #  #   #     #    #       # # # # #                           "
echo " ####### #     #    #    #####   #  #  # #####                       "
echo " #     # #######    #    #       #     # #                           "
echo " #     # #     #    #    #       #     # #                           "
echo " #     # #     #    #    ####### #     # #######                     "
echo "                                                                     "
echo "                  [ HATEME NET-HUNTER v3.0 ]                         "
echo -e "====================================================================="${NC}
echo -e ${PURPLE}"[*] Operator: HATEME (Blue-Haired Cyberpunk Mode)"
echo -e ${PURPLE}"[*] Session Start: $CURRENT_DATE"
echo -e ${PURPLE}"=====================================================================" ${NC}
echo ""

sleep 1

#Проверка переменной на пустой ввод
read -p "[~]Enter IP taget --> " awe
    if [ -z "$awe" ]; then
       echo "Invalip IP"
       exit 1
    fi


clear

#Генерируем файл
OUTPUT_FILE="scan_${target}_$(date +%Y%m%d_%H%M%S).txt"

#Меню выбора
echo -e ${GREEN} =====================================================
echo -e ${GREEN}"1. Search vilnerablity"
echo -e ${GREEN}"2. Agressive mode"
echo -e ${GREEN}"3. Slow and Silent"
echo -e ${GREEN}"4. Top 1000 Ports"
echo -e ${GREEN}"5. Top 100 Ports"
echo -e ${GREEN}"6. OS/UPD Detect"${NC}
echo ""
echo -n "[->]Choose option > "
read mode

clear
sleep 1
echo -e ${RED}"All result scan write on file!"
echo "-----------------------------------------------------"
echo ""
echo "[*] Initializing network reconnaissance on $target..."
echo -e "------------------------------------------------------"${NC}

#Структура скрипта
case "$mode" in
    1)  
        echo "[*]Mode 1: Running search vilnerability..."
        nmap -sV -Pn --script vuln -v -T5 $awe -oN "$OUTPUT_FILE"
        ;;

    2)
        echo "[*]Mode 2: Running Agressive mode"
        nmap -Pn -A --min-rate 1000 $awe -oN "$OUTPUT_FILE"
        ;;
        
    
    3)
        echo "[*]Mode 5: Running Slow and Silent scan"
        nmap -T1 -sS -Pn -f $awe -oN "$OUTPUT_FILE"
        ;;

    
    4)
        echo "[*]Mode 4: Running Top 1000 ports scan..."  
        nmap --top-ports 1000 $awe -oN "$OUTPUT_FILE"
        ;;
    
    5) 
        echo "[*]Mode 6: Running top 100 ports scan..."
        nmap -F -Pn $awe -oN "$OUTPUT_FILE"
        ;;


    6)
        echo "[*]Mode 3: Running OS/UDP Detect"
        nmap -sC -O -sV -sU -Pn $awe -oN "$OUTPUT_FILE"${NC}
        ;;

esac


#Проверка на успешное сканирование
if [ $? -eq 0 ]; then
   echo -e ${RED}"[+] Scan finish.."
fi
echo -e "========================================================================"${NC}
# Отправка файла:
   curl -F "chat_id=$CHAT_ID" \
        -F "document=@$OUTPUT_FILE" \
        -F "caption=Scan result for $awe" \
        "https://api.telegram.org/bot$BOT_TOKEN/sendDocument"


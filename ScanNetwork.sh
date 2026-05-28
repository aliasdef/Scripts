#!/bin/bash  
#COLOR
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
PINK='\033[1;31m'
NC='\033[0m'

#Telegram sending
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="CHAT_ID"

#Picure
echo -e "${CYAN}"
echo "    .      .     .    "
echo "   / \    / \   / \   "
echo "  |   |  |   | |   |  "
echo -e "  ${PURPLE}XXXXX${CYAN}  ${PURPLE}XXXXX${CYAN}  ${PURPLE}XXXXX${CYAN}"
echo "  X   X  X   X  X   X "
echo -e "  X ${PINK}O${PURPLE} X  X ${PINK}O${PURPLE} X  X ${PINK}O${PURPLE} X  ${NC}<-- Jinx is watching..."
echo -e "${PURPLE}  XXXXX  XXXXX  XXXXX "
echo "   X      X      X    "
echo -e "    ${PINK}BYE BYE, TARGET!${NC}"
echo ""
echo "" 

sleep 1
#Main menu
echo -e ${RED}-------------------------
echo -e ${RED}----Scan network v2.0----
echo -e ${RED}------- By hateme--------
echo -e ${RED}-------------------------${NC}

echo -e ${GREEN}"1) Seaurch vulnerability \t  ${GREEN} 4) All ports" 
echo -e "2) Agressive mode \t          ${GREEN} 5) Fast silent scan"
echo -e "3) OS/UPD Detect"                   

#Check choise
read choise
if [ -z "$choise" ]; then
    echo -e "${RED}No scan type selected${NC}"
    exit 1
fi

#Imput IP
read -p "[~] Enter IP target >> " target
if  [ -z "$target" ]; then
     echo -e  ${RED}"Error, cheking ip"${NC}
     exit 1

fi

#Generate file name
OUTPUT_FILE="scan_${target}_$(date +%Y%m%d_%H%M%S).txt"

#Scan(Service Version, no ping, script)
if  [ "$choise" = "1" ]; then
    nmap -sV -Pn -sC -v -T5 "$target" -oN "$OUTPUT_FILE"
#Scan(no ping, agressive, 1000 packages in 1sec)
elif [ "$choise" = "2" ]; then
    nmap -Pn -A --min-rate 1000 "$target" -oN "$OUTPUT_FILE"
#Scan(Script, OS detection, servise verison, UDP scan)
elif [ "$choisee" = "3" ]; then
     nmap -sC -O -sV -sU "$target" -oN "$OUTPUT_FILE"
#Scan(No ping, all ports, time remplates)
elif [ "$choise" = "4" ]; then
     nmap  -Pn -p- -T4 "$target" -oN "$OUTPUT_FILE"
#Scan(SYN Scan, Service Version, No ping, time templates, Only open ports, view open ports)
elif [ "$choise" = "5" ]; then
     nmap -sS -sV -Pn -T1 --open -v "$target" -oN "$OUTPUT_FILE"
else 
#Error scan
    echo -e "${RED}Invalid scan type${NC}"
    exit 1
fi

# Check for done scan
if [ $? -eq 0 ]; then
   echo -e "${RED}[+] Scan finishe, sending to Telegram...${NC}"

   # Sending file
   curl -F "chat_id=$CHAT_ID" \
        -F "document=@$OUTPUT_FILE" \
        -F "caption=Scan result for $target" \
        "https://api.telegram.org/bot$BOT_TOKEN/sendDocument"


echo -e "${RED}[+] Done1${NC}"
else
echo -e "${RED}[~] Scan Failed${NC}"

fi

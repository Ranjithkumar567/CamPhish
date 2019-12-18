#!/bin/bash

#            --------------------------------------------------
#                              Camera Snapshot               
#            --------------------------------------------------
#                  Copyright (C) <2019>  <Entynetproject>      
#
#        This program is free software: you can redistribute it and/or modify
#        it under the terms of the GNU General Public License as published by
#        the Free Software Foundation, either version 3 of the License, or
#        any later version.
#
#        This program is distributed in the hope that it will be useful,
#        but WITHOUT ANY WARRANTY; without even the implied warranty of
#        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#        GNU General Public License for more details.
#
#        You should have received a copy of the GNU General Public License
#        along with this program.  If not, see <http://www.gnu.org/licenses/>.

#blue start 
	BS="-e \033[1;34m"
	BSA="\033[1;34m"
#color end
	CE="\033[0m"
#red start
	RS="-e \033[1;31m"
#green start
	GNS="-e \033[1;92m"
	GSA="\033[1;92m"
	RSA="\033[1;31m"
#white start
        WHS="\033[0;97m"
        
if [[ -d /data/data/com.termux ]]
then
if [[ -f /data/data/com.termux/files/usr/bin/camsnap ]]
then
UPD="true"
else
UPD="false"
fi
else 
if [[ -f /usr/local/bin/camsnap ]]
then
UPD="true"
else
UPD="false"
fi
fi
{
ASESR="$( curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' )"
} &> /dev/null
if [[ "$ASESR" = "" ]]
then 
sleep 1
echo ""$RS"["$CE"-"$RSA"] Download failed!"$CE""
sleep 1
exit
fi
if [[ $EUID -ne 0 ]]
then
sleep 1
echo ""$RS"["$CE"-"$RSA"] Permission denied!"$CE""
sleep 1
exit
fi
sleep 1
echo -e "\033[1;77m[\033[0m\033[1;93m*\033[0m\033[1;77m] Installing update...\033[0m"
{
mkdir ~/.camsnap
cp -r ~/camsnap/images ~/.camsnap
rm -rf ~/camsnap
rm /bin/camsnap
rm /usr/local/bin/camsnap
rm /data/data/com.termux/files/usr/bin/camsnap
cd ~
git clone https://github.com/entynetproject/camsnap.git
if [[ "$UPD" != "true" ]]
then
sleep 0
else
cd camsnap
chmod +x install.sh
./install.sh
fi
cp -r ~/.camsnap/images ~/camsnap
rm -rf ~/.camsnap
} &> /dev/null
echo -e "\033[1;92m[\033[0m\033[1;77m+\033[0m\033[1;92m] Successfully updated!"$CE""
sleep 1
exit

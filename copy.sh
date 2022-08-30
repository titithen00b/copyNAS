#! /bin/bash

source=/volume1/Sauvegarde/SauvSrv/Partage
destination=/volumeUSB/usbshare/BACKUP/

messhelp()
{
    echo "Script de sauvgarde des sauvegarde" 
    echo "Le script effectue une compression de la sauvegarde de la veille"
    echo "Pour lancer la copie après la sauvegarde passer l'option -c"
    echo "Pour la suppression automatique du fichier zip après la copie, merci de spécifier l'option -r"
 
}

helpcom()
{
    if [ $1 == "-h" ] || [ $1 == "--help" ]
        then messhelp && exit 0
    fi
}


date_j-1()
{
    #set de la varibale J-1 avec affichage : YYYYMMJJ
    j_1=`date -d "$(date +%Y-%m-%d) -1 day" +%Y%m%d`
    echo "$j_1"
}

formatdate_j-1()
{
    #Test J-1 pas samedi ni dimanche
    J=`date -d "-1 day" +%A`
        if [ $J == "Sunday" ] || [  $J == "Saturday" ] || [ $J == "dimanche" ] || [ $J == "samedi" ]
            then echo "Aucune sauvegarde le samedi/dimanche" && param=0
            else echo "Let's go !" && param=1
        fi
}

copie()
{
    if [ $1 == "-c" ] || [ $2 == "-c" ]
        then cp "$i.zip" $destination
        else echo "L'option -c n'a pas été spécifié, il n'y aura pas de copie automatique"
    fi
}


compression()
{
    cd $source
    for i in "$(ls -l  | cut -c 51- | grep $j_1)"
    do
        if [ "$param" = "1" ]
            then  zip -r "$i" "$i" && copie
            else echo "off"
        fi
    done
}


main()
{
    helpcom
    date_j-1
    formatdate_j-1
    compression    
}
 
 main

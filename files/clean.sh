!/bin/bash

echo "Removendo mp4 com mais de 180 dias" >>"${LOGFILE}"
find /mnt/nfsfiles/scalelite/var/bigbluebutton/published/download/ -type f -mtime +180 -delete

LOGFILE=/home/suporte/recording-cleanup.log
FILESYSTEM=/dev/mapper/vgnfs-nfs
CAPACITY=88
RECORD_DIR=/mnt/nfsfiles/scalelite/var/bigbluebutton/published/presentation

MINAGE=350
NOW=$(date +%s)

cd $RECORD_DIR

#COUNT=$(ls -ltrd */ | wc -l)

echo "[ `date +'%m-%d-%Y'` ] Verifica se o disco está cheio" >>"${LOGFILE}"
while [ $(df -P $FILESYSTEM | awk '{ gsub("%",""); capacity = $5 }; END { print capacity }') -gt $CAPACITY ]
do
    COUNT=$(ls -ltrd */ | wc -l)
    echo "$(df -P $FILESYSTEM | awk '{ gsub("%",""); capacity = $5 }; END { print capacity }')%" >>"${LOGFILE}"
    echo "Gravações restantes:... $COUNT" >>"${LOGFILE}"
    if [ "$COUNT" -gt 0 ]; then

        # Percorre todos os diretórios
        for d in `ls -ltrd */ | awk '{ print $9 }'`
        do
            # apt-get install libxml2-utils

            if [ -f "$d"metadata.xml ]; then
                origin=$(xmllint --xpath 'string(/recording/meta/bbb-origin)' "$d"metadata.xml)
                MTIME=$(stat -c %Y "$d"metadata.xml)
            else
                origin="empty"
                MTIME=$(stat -c %Y "${d}")
            fi

            # Se do Solar e com mais de 180 dias, pode apagar.
            # echo $origin
            # echo $(( ( $NOW - $MTIME ) / 86400 ))
            if [ "$origin" == "Solar" ] && [ $(( ( $NOW - $MTIME ) / 86400 )) -gt $MINAGE ]; then
                echo "[DEBUG] Apagando $d - $origin ($(( ( $NOW - $MTIME ) / 86400 )) dias)" >>"${LOGFILE}"
                rm -rf $d
                COUNT=$((COUNT-1))
                #let "COUNT--"
                break
            else
                echo "[DEBUG] Não pode apagar $d - $origin ($(( ( $NOW - $MTIME ) / 86400 )) dias)"
                COUNT=$((COUNT-1))
                #let "COUNT--"
            fi
        done
    else
        break
    fi
done

if [ $(df -P $FILESYSTEM | awk '{ gsub("%",""); capacity = $5 }; END { print capacity }') -gt $CAPACITY ]; then
    echo "[WARNING] Disco Cheio ($(df -P $FILESYSTEM | awk '{ gsub("%",""); capacity = $5 }; END { print capacity }')%). Finalizando..." >>"${LOGFILE}"
else
    echo "[SUCCESSFUL] Disco Ok ($(df -P $FILESYSTEM | awk '{ gsub("%",""); capacity = $5 }; END { print capacity }')%). Finalizando..." >>"${LOGFILE}"
fi

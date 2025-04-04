#!/system/bin/sh
busybox mount -o rw,remount /system
busybox mount -o rw,remount /data
busybox mount -o rw,remount /cache

echo "Starting FV Automatic Fstrim $( date +"%m-%d-%Y %H:%M:%S") " | tee -a $LOG_FILE;
fstrim -v /system
fstrim -v /data
fstrim -v /cache
echo "Automatic Fstrim finished at $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;

sleep 10

MODDIR=/data/adb/modules/devices_booster
LOG_FILE=/data/adb/modules/device_booster/booster.log;
ZIPALIGNDB=/data/adb/modules/device_booster/zipalign.db;

if [ -e $LOG_FILE ]; then
	rm $LOG_FILE;
fi;

if [ ! -f $ZIPALIGNDB ]; then
	touch $ZIPALIGNDB;
fi;

busybox mount -o rw,remount /system;

echo "Starting FV Automatic ZipAlign $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;

for DIR in /system/app/* /system/priv-app/* /data/app/*/*; do
	cd $DIR;
	for APK in *.apk; do
		if [ $APK -ot $ZIPALIGNDB ] && [ $(grep "$DIR/$APK" $ZIPALIGNDB|wc -l) -gt 0 ]; then
			echo "Already checked: $DIR/$APK" | tee -a $LOG_FILE;
		else
			ZIPCHECK=`/system/bin/zipalign -c -v 4 $APK | grep FAILED | wc -l`;
			if [ $ZIPCHECK == "1" ]; then
				echo "Now aligning: $DIR/$APK" | tee -a $LOG_FILE;
				/system/bin/zipalign -f 4 $APK /data/local/$APK;
				rc = "$?";
				if [ $rc -eq 0 ]; then
					if [ -e "/data/local/$APK" ]; then
						cp -f -p "/data/local/$APK" "$APK" | tee -a $LOG_FILE;
						rm -f "/data/local/$APK";
						grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB;
					else
						echo "ZipAligning $APK Failed (no output file)"  | tee -a $LOG_FILE;
					fi;
				else
					[ -f "/data/local/$APK" ] && rm -f "/data/local/$APK"
					echo "ZipAligning $APK Failed (rc: $rc)"  | tee -a $LOG_FILE;
				fi;
			else
				echo "Already aligned: $DIR/$APK" | tee -a $LOG_FILE;
				grep "$DIR/$APK" $ZIPALIGNDB > /dev/null || echo $DIR/$APK >> $ZIPALIGNDB;
			fi;
		fi;
	done;
done;

busybox mount -o ro,remount /system;
touch $ZIPALIGNDB;
echo "Automatic ZipAlign finished at $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;

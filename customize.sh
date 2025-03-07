SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=false
LATESTARTSERVICE=true

REPLACE = "
"

print_modname() {
   ui_print "*******************************"
   ui_print "       Device Booster          "
   ui_print "                               "
   ui_print "*******************************"
}

on_install() {
   ui_print "- Extracting module files"
   unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

set_permissions() {
  set_perm_recursive $MODPATH/system/usr/idc 0 0 0755 0644
      chmod 0644 $MODPATH/system/usr/idc/qwerty.idc
	     chmod 0644 $MODPATH/system/usr/idc/qwerty2.idc
       chmod 0755 $MODPATH/system/bin/zipalign
}

#!/system/bin/sh
# (c) 2025 mrdoge0, Free Software Licensed under Apache-2.0

# I don't know will anybody want this, but I get irritated from spoofed fingerprints.

# Gather props.
SYSTEMPROP="/system/build.prop"
VENDORPROP="/vendor/build.prop"
BRAND=$(grep -E 'ro.product.vendor.brand=' "$VENDORPROP" | cut -d'=' -f2)
DEVICE=$(grep -E 'ro.product.vendor.device=' "$VENDORPROP" | cut -d'=' -f2)
VER=$(grep -E 'ro.build.version.release_or_codename=' "$SYSTEMPROP" | cut -d'=' -f2)
ID=$(grep -E 'ro.build.id=' "$SYSTEMPROP" | cut -d'=' -f2)
INC=$(grep -E 'ro.build.version.incremental=' "$SYSTEMPROP" | cut -d'=' -f2)
TYPE=$(grep -E 'ro.build.type=' "$SYSTEMPROP" | cut -d'=' -f2)
TAGS=$(grep -E 'ro.build.tags=' "$SYSTEMPROP" | cut -d'=' -f2)

# Generate more props.
NAME="lineage_$DEVICE"
FLAVOR="$NAME-$TYPE"

# Generate ultimate props.
FP="$BRAND/$NAME/$DEVICE:$VER/$ID/$INC:$TYPE/$TAGS"
DESC="$FLAVOR $VER $ID $INC $TAGS"

# Apply fingerprint props.
resetprop -n ro.build.fingerprint "$FP"
resetprop -n ro.system.build.fingerprint "$FP"
resetprop -n ro.system_ext.build.fingerprint "$FP"
resetprop -n ro.product.build.fingerprint "$FP"
resetprop -n ro.odm.build.fingerprint "$FP"
resetprop -n ro.vendor.build.fingerprint "$FP"
resetprop -n ro.vendor_dlkm.build.fingerprint "$FP"

# Apply description props.
resetprop -n ro.build.description "$DESC"
resetprop -n ro.system.build.description "$DESC"
resetprop -n ro.system_ext.build.description "$DESC"
resetprop -n ro.product.build.description "$DESC"
resetprop -n ro.odm.build.description "$DESC"
resetprop -n ro.vendor.build.description "$DESC"
resetprop -n ro.vendor_dlkm.build.description "$DESC"

# Apply product.name props.
resetprop -n ro.product.name "$NAME"
resetprop -n ro.product.system.name "$NAME"
resetprop -n ro.product.product.name "$NAME"
resetprop -n ro.product.system_ext.name "$NAME"
resetprop -n ro.product.vendor.name "$NAME"
resetprop -n ro.product.vendor_dlkm.name "$NAME"
resetprop -n ro.product.odm.name "$NAME"

# Apply ro.build.flavor prop.
resetprop -n ro.build.flavor "$FLAVOR"

# Exit.
exit 0

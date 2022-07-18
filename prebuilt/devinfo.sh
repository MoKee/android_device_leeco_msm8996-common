#!/sbin/sh
# Copyright (c) 2020, The LineageOS Project
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the LineageOS Project nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# copy devinfo partition info to a vendor prop

# Check if this is MoKee Recovery
LOSRECOVERY=/sbin/toybox

if test -f "$LOSRECOVERY"; then
    toybox mount /dev/block/bootdevice/by-name/vendor -t ext4 /mnt/vendor
else
    /tmp/toybox mount /dev/block/bootdevice/by-name/vendor -t ext4 /mnt/vendor
fi

DEVINFO=$(strings /dev/block/sde21 | head -n 1)

echo "DEVINFO: ${DEVINFO}"

sed -i "s/ro.leeco.devinfo=NULL/ro.leeco.devinfo=$DEVINFO/g" "/mnt/vendor/build.prop"

if test -f "$LOSRECOVERY"; then
    toybox umount /mnt/vendor
else
    /tmp/toybox umount /mnt/vendor
fi

exit 0

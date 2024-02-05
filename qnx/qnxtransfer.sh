ip=$1
arch=$2
pw="root"

echo 'Remember to run export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/glog/.libs/'
sshpass -p $pw ssh root@$ip mkdir -p /data/glog/tmp /data/glog/.libs /data/glog/src /data/glog/test_subdir

# Transfer tests
sshpass -p $pw scp -r $QNX_TARGET/$arch/usr/bin/glog_tests/* root@$ip:/data/glog
sshpass -p $pw ssh root@$ip mv /data/glog/src/signalhandler_unittest.sh /data/glog
sshpass -p $pw ssh root@$ip mv /data/glog/signalhandler_unittest /data/glog/.libs

# Transfer libs
sshpass -p $pw scp $QNX_TARGET/$arch/usr/lib/libgmock* root@$ip:/data/glog/.libs
sshpass -p $pw scp $QNX_TARGET/$arch/usr/lib/libgflags* root@$ip:/data/glog/.libs
sshpass -p $pw scp $QNX_TARGET/$arch/usr/lib/libgtest* root@$ip:/data/glog/.libs
sshpass -p $pw scp $QNX_TARGET/$arch/usr/lib/libglog* root@$ip:/data/glog/.libs

sshpass -p $pw ssh root@$ip chmod +x /data/glog/*
sshpass -p $pw ssh root@$ip chmod +x /data/glog/.libs/signalhandler_unittest

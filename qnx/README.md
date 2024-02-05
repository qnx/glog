# Compile the port for QNX

**NOTE**: QNX ports are only supported from a Linux host operating system

- Setup your QNX SDP environment
- Install GFlags to your SDP environment
- Install GTest to your SDP environment
- From the root folder, type:
  - `OSLIST=nto make -C qnx/build install`

# Test glog on QNX

- Compile and install test dependencies by following the instructions above
- Run the `qnxtransfer.sh` script
- Run tests:
  - cd into `/data/glog`, and export LD_LIBRARY_PATH to include `/data/glog/.libs`
  - Run `GOOGLE_LOG_DIR=/data/glog/ ./cleanup_immediately_unittest` for 3 times (sleeping one second in between) and verify that only one `*foobar` file is in /data/glog
  - Run `./cleanup_with_absolute_prefix_unittest  -log_dir=/data/glog/` for 3 times (sleeping one second in between) and verify that only one `test_cleanup_*.barfoo` file is in /data/glog
  - Run `./cleanup_with_relative_prefix_unittest  -log_dir=/data/glog/` for 3 times (sleeping two seconds in between) and verify that only one `test_cleanup_*.relativefoo` file is in /data/glog/test_subdir
  - Run `./logging_unittest --test_srcdir="/data/glog" --test_tmpdir="/data/glog/tmp"`
  - Run `./logging_custom_prefix_unittest  --test_srcdir="/data/glog" --test_tmpdir="/data/glog/tmp"`
  - Run `./demangle_unittest --test_srcdir=/data/glog`. (This test is supposed to run with some other arguments, but we do not have the necessary dependency on QNX, so we just run the vanilla program).
  - Run the other tests without any args.

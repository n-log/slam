# CMake generated Testfile for 
# Source directory: /home/xlqmu/ws/src/RMUC24_real/sensor_interface/nmea_navsat_driver
# Build directory: /home/xlqmu/ws/build/nmea_navsat_driver
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_nmea_navsat_driver_roslint_package "/home/xlqmu/ws/build/nmea_navsat_driver/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/xlqmu/ws/build/nmea_navsat_driver/test_results/nmea_navsat_driver/roslint-nmea_navsat_driver.xml" "--working-dir" "/home/xlqmu/ws/build/nmea_navsat_driver" "--return-code" "/opt/ros/noetic/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/xlqmu/ws/build/nmea_navsat_driver/test_results/nmea_navsat_driver/roslint-nmea_navsat_driver.xml make roslint_nmea_navsat_driver")
set_tests_properties(_ctest_nmea_navsat_driver_roslint_package PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/roslint/cmake/roslint-extras.cmake;67;catkin_run_tests_target;/home/xlqmu/ws/src/RMUC24_real/sensor_interface/nmea_navsat_driver/CMakeLists.txt;25;roslint_add_test;/home/xlqmu/ws/src/RMUC24_real/sensor_interface/nmea_navsat_driver/CMakeLists.txt;0;")
subdirs("gtest")

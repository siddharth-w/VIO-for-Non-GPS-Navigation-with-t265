sudo chmod 666 /dev/ttyACM0
sudo chmod 666 /dev/ttyACM1
xterm -e "roslaunch realsense2_camera rs_t265.launch"&
sleep 6
xterm -e "roslaunch mavros apm.launch"&
sleep 3
xterm -e "roslaunch vision_to_mavros t265_tf_to_mavros.launch"&
sleep 3


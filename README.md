# Uses VIO tracking camera such as the Intel RealSense T265 used with ROS to facilitate non-GPS flight.


## Configure ArduPilot

Connect to the autopilot with a ground station (i.e. Mission Planner) and check that the following parameters are set:
For ArduPilot-4.1 (and later):



* **AHRS_EKF_TYPE** = 3 (EKF3)
* **EK2_ENABLE** = 0 (disabled)
* **EK3_ENABLE** = 1 (enabled)
* **EK3_SRC1_POSXY** = 6 (ExternalNav)
* **EK3_SRC1_VELXY** = 6 (ExternalNav)
* **EK3_SRC1_POSZ** = 1 (Baro which is safer because of the camera’s weakness to high vibrations)
* **EK3_SRC1_VELZ** = 6 (ExternalNav)
* **GPS_TYPE** = 0 to disable the GPS
* **VISO_TYPE** = 2 (IntelT265)

If you wish to use the camera’s heading:

**COMPASS_USE** = 0, **COMPASS_USE2** = 0, **COMPASS_USE3** = 0 to disable all compasses
**EK3_SRC1_YAW** = 6 (ExternalNav)


There are 3 ROS nodes running in this setup: realsense-ros, mavros and vision_to_mavros. Launch in 3 separated terminals on:
* realsense-ros node: roslaunch realsense2_camera rs_t265.launch.
The topic /camera/odom/sample/ and /tf should be published at 200Hz.
* mavros node: roslaunch mavros apm.launch (with fcu_url and other parameters in apm.launch modified to your setup).
rostopic echo /mavros/state should show that FCU is connected.
rostopic echo /mavros/vision_pose/pose is not published.
* vision_to_mavros node: roslaunch vision_to_mavros t265_tf_to_mavros.launch
rostopic echo /mavros/vision_pose/pose should now show pose data from the T265.
rostopic hz /mavros/vision_pose/pose should show that the topic is being published at 30Hz.





![](https://github.com/siddharth-w/gifs/blob/main/ezgif.com-video-to-gif.gif)



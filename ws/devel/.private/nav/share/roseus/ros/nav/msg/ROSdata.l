;; Auto-generated. Do not edit!


(when (boundp 'nav::ROSdata)
  (if (not (find-package "NAV"))
    (make-package "NAV"))
  (shadow 'ROSdata (find-package "NAV")))
(unless (find-package "NAV::ROSDATA")
  (make-package "NAV::ROSDATA"))

(in-package "ROS")
;;//! \htmlinclude ROSdata.msg.html


(defclass nav::ROSdata
  :super ros::object
  :slots (_yaw _pitch _dis _is_aimed _is_target_exists ))

(defmethod nav::ROSdata
  (:init
   (&key
    ((:yaw __yaw) 0.0)
    ((:pitch __pitch) 0.0)
    ((:dis __dis) 0.0)
    ((:is_aimed __is_aimed) nil)
    ((:is_target_exists __is_target_exists) nil)
    )
   (send-super :init)
   (setq _yaw (float __yaw))
   (setq _pitch (float __pitch))
   (setq _dis (float __dis))
   (setq _is_aimed __is_aimed)
   (setq _is_target_exists __is_target_exists)
   self)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:pitch
   (&optional __pitch)
   (if __pitch (setq _pitch __pitch)) _pitch)
  (:dis
   (&optional __dis)
   (if __dis (setq _dis __dis)) _dis)
  (:is_aimed
   (&optional (__is_aimed :null))
   (if (not (eq __is_aimed :null)) (setq _is_aimed __is_aimed)) _is_aimed)
  (:is_target_exists
   (&optional (__is_target_exists :null))
   (if (not (eq __is_target_exists :null)) (setq _is_target_exists __is_target_exists)) _is_target_exists)
  (:serialization-length
   ()
   (+
    ;; float32 _yaw
    4
    ;; float32 _pitch
    4
    ;; float32 _dis
    4
    ;; bool _is_aimed
    1
    ;; bool _is_target_exists
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pitch
       (sys::poke _pitch (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dis
       (sys::poke _dis (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _is_aimed
       (if _is_aimed (write-byte -1 s) (write-byte 0 s))
     ;; bool _is_target_exists
       (if _is_target_exists (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _yaw
     (setq _yaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pitch
     (setq _pitch (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dis
     (setq _dis (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _is_aimed
     (setq _is_aimed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _is_target_exists
     (setq _is_target_exists (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get nav::ROSdata :md5sum-) "dfeef41f7b4427e94c0ce4d2ec551822")
(setf (get nav::ROSdata :datatype-) "nav/ROSdata")
(setf (get nav::ROSdata :definition-)
      "float32 yaw
float32 pitch
float32 dis
bool is_aimed
bool is_target_exists

")



(provide :nav/ROSdata "dfeef41f7b4427e94c0ce4d2ec551822")



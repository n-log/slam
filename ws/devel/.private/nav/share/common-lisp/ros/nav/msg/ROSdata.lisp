; Auto-generated. Do not edit!


(cl:in-package nav-msg)


;//! \htmlinclude ROSdata.msg.html

(cl:defclass <ROSdata> (roslisp-msg-protocol:ros-message)
  ((yaw
    :reader yaw
    :initarg :yaw
    :type cl:float
    :initform 0.0)
   (pitch
    :reader pitch
    :initarg :pitch
    :type cl:float
    :initform 0.0)
   (dis
    :reader dis
    :initarg :dis
    :type cl:float
    :initform 0.0)
   (is_aimed
    :reader is_aimed
    :initarg :is_aimed
    :type cl:boolean
    :initform cl:nil)
   (is_target_exists
    :reader is_target_exists
    :initarg :is_target_exists
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ROSdata (<ROSdata>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ROSdata>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ROSdata)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name nav-msg:<ROSdata> is deprecated: use nav-msg:ROSdata instead.")))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <ROSdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav-msg:yaw-val is deprecated.  Use nav-msg:yaw instead.")
  (yaw m))

(cl:ensure-generic-function 'pitch-val :lambda-list '(m))
(cl:defmethod pitch-val ((m <ROSdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav-msg:pitch-val is deprecated.  Use nav-msg:pitch instead.")
  (pitch m))

(cl:ensure-generic-function 'dis-val :lambda-list '(m))
(cl:defmethod dis-val ((m <ROSdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav-msg:dis-val is deprecated.  Use nav-msg:dis instead.")
  (dis m))

(cl:ensure-generic-function 'is_aimed-val :lambda-list '(m))
(cl:defmethod is_aimed-val ((m <ROSdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav-msg:is_aimed-val is deprecated.  Use nav-msg:is_aimed instead.")
  (is_aimed m))

(cl:ensure-generic-function 'is_target_exists-val :lambda-list '(m))
(cl:defmethod is_target_exists-val ((m <ROSdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader nav-msg:is_target_exists-val is deprecated.  Use nav-msg:is_target_exists instead.")
  (is_target_exists m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ROSdata>) ostream)
  "Serializes a message object of type '<ROSdata>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pitch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dis))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_aimed) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_target_exists) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ROSdata>) istream)
  "Deserializes a message object of type '<ROSdata>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pitch) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dis) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'is_aimed) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'is_target_exists) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ROSdata>)))
  "Returns string type for a message object of type '<ROSdata>"
  "nav/ROSdata")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ROSdata)))
  "Returns string type for a message object of type 'ROSdata"
  "nav/ROSdata")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ROSdata>)))
  "Returns md5sum for a message object of type '<ROSdata>"
  "dfeef41f7b4427e94c0ce4d2ec551822")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ROSdata)))
  "Returns md5sum for a message object of type 'ROSdata"
  "dfeef41f7b4427e94c0ce4d2ec551822")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ROSdata>)))
  "Returns full string definition for message of type '<ROSdata>"
  (cl:format cl:nil "float32 yaw~%float32 pitch~%float32 dis~%bool is_aimed~%bool is_target_exists~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ROSdata)))
  "Returns full string definition for message of type 'ROSdata"
  (cl:format cl:nil "float32 yaw~%float32 pitch~%float32 dis~%bool is_aimed~%bool is_target_exists~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ROSdata>))
  (cl:+ 0
     4
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ROSdata>))
  "Converts a ROS message object to a list"
  (cl:list 'ROSdata
    (cl:cons ':yaw (yaw msg))
    (cl:cons ':pitch (pitch msg))
    (cl:cons ':dis (dis msg))
    (cl:cons ':is_aimed (is_aimed msg))
    (cl:cons ':is_target_exists (is_target_exists msg))
))

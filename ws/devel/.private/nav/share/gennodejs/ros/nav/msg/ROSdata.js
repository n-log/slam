// Auto-generated. Do not edit!

// (in-package nav.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ROSdata {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.yaw = null;
      this.pitch = null;
      this.dis = null;
      this.is_aimed = null;
      this.is_target_exists = null;
    }
    else {
      if (initObj.hasOwnProperty('yaw')) {
        this.yaw = initObj.yaw
      }
      else {
        this.yaw = 0.0;
      }
      if (initObj.hasOwnProperty('pitch')) {
        this.pitch = initObj.pitch
      }
      else {
        this.pitch = 0.0;
      }
      if (initObj.hasOwnProperty('dis')) {
        this.dis = initObj.dis
      }
      else {
        this.dis = 0.0;
      }
      if (initObj.hasOwnProperty('is_aimed')) {
        this.is_aimed = initObj.is_aimed
      }
      else {
        this.is_aimed = false;
      }
      if (initObj.hasOwnProperty('is_target_exists')) {
        this.is_target_exists = initObj.is_target_exists
      }
      else {
        this.is_target_exists = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ROSdata
    // Serialize message field [yaw]
    bufferOffset = _serializer.float32(obj.yaw, buffer, bufferOffset);
    // Serialize message field [pitch]
    bufferOffset = _serializer.float32(obj.pitch, buffer, bufferOffset);
    // Serialize message field [dis]
    bufferOffset = _serializer.float32(obj.dis, buffer, bufferOffset);
    // Serialize message field [is_aimed]
    bufferOffset = _serializer.bool(obj.is_aimed, buffer, bufferOffset);
    // Serialize message field [is_target_exists]
    bufferOffset = _serializer.bool(obj.is_target_exists, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ROSdata
    let len;
    let data = new ROSdata(null);
    // Deserialize message field [yaw]
    data.yaw = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pitch]
    data.pitch = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dis]
    data.dis = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [is_aimed]
    data.is_aimed = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [is_target_exists]
    data.is_target_exists = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 14;
  }

  static datatype() {
    // Returns string type for a message object
    return 'nav/ROSdata';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dfeef41f7b4427e94c0ce4d2ec551822';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 yaw
    float32 pitch
    float32 dis
    bool is_aimed
    bool is_target_exists
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ROSdata(null);
    if (msg.yaw !== undefined) {
      resolved.yaw = msg.yaw;
    }
    else {
      resolved.yaw = 0.0
    }

    if (msg.pitch !== undefined) {
      resolved.pitch = msg.pitch;
    }
    else {
      resolved.pitch = 0.0
    }

    if (msg.dis !== undefined) {
      resolved.dis = msg.dis;
    }
    else {
      resolved.dis = 0.0
    }

    if (msg.is_aimed !== undefined) {
      resolved.is_aimed = msg.is_aimed;
    }
    else {
      resolved.is_aimed = false
    }

    if (msg.is_target_exists !== undefined) {
      resolved.is_target_exists = msg.is_target_exists;
    }
    else {
      resolved.is_target_exists = false
    }

    return resolved;
    }
};

module.exports = ROSdata;

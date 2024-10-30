
(cl:in-package :asdf)

(defsystem "nav-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ROSdata" :depends-on ("_package_ROSdata"))
    (:file "_package_ROSdata" :depends-on ("_package"))
  ))
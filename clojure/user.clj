(ns user
  (:require
   [clj-commons.ansi :as ansi]))

(alter-var-root #'*warn-on-reflection* (constantly true))
(alter-var-root #'ansi/*color-enabled* (constantly false))

(print (str "\033[38;2;255;165;0m"
            "Local dev init complete"
            "\033[m\n"))


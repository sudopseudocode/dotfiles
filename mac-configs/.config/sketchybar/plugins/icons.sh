#!/bin/bash

icon_map() {
  case "$1" in
    "App Store") echo "" ;;
    "Google Chrome") echo "󰊯" ;;
    "Chromium") echo "󰴂" ;; # Playwright
    "Finder") echo "󰀶" ;;
    "Firefox") echo "" ;;
    "Safari") echo "󰀹" ;;
    "Calendar") echo "󰸗" ;;
    "Google Calendar") echo "󰸗" ;;
    "Slack") echo "󰒱" ;;
    "Alacritty") echo "" ;;
    "kitty") echo "" ;;
    "Terminal") echo "" ;;
    "Proton Mail") echo "󰴃" ;;
    "Todoist") echo "" ;;
    "Notion") echo "" ;;
    "Messages") echo "󰻞" ;;
    "Discord") echo "󰙯" ;;
    "System Settings") echo "" ;;
    "zoom.us") echo "󰕧" ;;
    *) echo "" ;;
  esac
}
icon_map "$1"

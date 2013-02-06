# Proxy
# mcabber can use a proxy if it supports the CONNECT method
# The proxy_user/proxy_pass variables are optional.
#set proxy_host = "localhost"
#set proxy_port = 8118
#set proxy_user = "username"
#set proxy_pass = "password"

# mcabber can store the list of unread messages in a state file,
# so that the message flags are set back at next startup.
# Note that 'logging' must be enabled for this feature to work.
set statefile = ~/.cache/mcabber/state

# External command for events
# You can specify a script or process to be launched when an event occurs.
# Set 'events_ignore_active_window' to 1 if you don't want the script to
# be run for a message to the current active window (default: 0).
#
# If 'event_log_files' is set, a file is created and contains the body of
# the message (incoming messages only); the file name is the last parameter.
# If you enable this, you can specify the directory mcabber will use to
# create these messages with the 'event_log_dir' variable (default is the
# system temp dir, or MCABBERTMPDIR environment variable).  Please note
# that mcabber won't delete these files, it's your script's job.
#
# The command is called the following way:
#   $events_command MSG IN jabber@id [file] (when receiving a message)
#   $events_command MSG OUT jabber@id       (when sending a message)
#   $events_command MSG MUC room_id [file]  (when receiving a MUC message)
#   $events_command STATUS X jabber@id      (new buddy status is X)
#   $events_command UNREAD N                (number of unread buddy buffers)
# See sample script in contrib/ directory.
set events_command = ~/.local/share/mcabber/eventcmd
#
#set events_ignore_active_window = 0
#
#set event_log_files = 0
#set event_log_dir = ~/.cache/mcabber/event_files

# If you set 'eventcmd_use_nickname' to 1, mcabber will pass the nickname
# (if it is defined) to the event script instead of the JID (default: 0).
#set eventcmd_use_nickname = 0

# External command status check
# You can request mcabber to inspect exit status value after each
# events_command.  If this option is set, mcabber will beep if the
# exit value is 2.
#set eventcmd_checkstatus = 0

# Internal hooks
# You can ask mcabber to execute an internal command when a special event
# occurs (for example when it connects to the server).
#
# 'hook-post-connect' is executed when mcabber has connected to the server
# and the roster has been received.
#set hook-post-connect = status dnd
#
# 'hook-pre-disconnect' is executed just before mcabber disconnects from
# the server.
#set hook-pre-disconnect = say_to foo@bar Goodbye!

# FIFO
# mcabber can create a FIFO named pipe and listen to this pipe for commands.
# Default: disabled.
# Set 'fifo_hide_commands' to 1 if you don't want to see the FIFO commands
# in the log window (they will still be written to the tracelog file).
# When FIFO  is configured, you can turn it off and on in real time with
# the 'fifo_ignore' option (default: 0).  When set to 1, the FIFO input is
# still read but it is discarded.
#set fifo_name = ~/.cache/mcabber/mcabber.fifo
#set fifo_hide_commands = 0
#set fifo_ignore = 0


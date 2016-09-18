# bash

LOGGER_VERSION=0.9.0

# Constants: Log Levels
#  Do not modify these values
LOG_DEBUG=1
LOG_INFO=2
LOG_WARN=3
LOG_ERROR=4

# Global Log Level
#  You can overwrite this with constants above
LOG_LEVEL=${LOG_LEVEL:-${LOG_INFO}}

_log.base() {
  local msg="$1"
  local level="${2:-${LOG_INFO}}"
  local date="$(date +'%F %T')"
  local label col ext

  # Suppress logging for lower log levels
  (( $level >= $LOG_LEVEL )) || return 0

  case "$level" in
    "$LOG_DEBUG" )
      label="DEBUG"; col=37; ext=0;;
    "$LOG_INFO" )
      label="INFO";  col=32; ext=1;;
    "$LOG_WARN" )
      label="WARN";  col=33; ext=1;;
    "$LOG_ERROR" )
      label="ERROR"; col=31; ext=1;;
    * )
      label="UNKNOWN"; col=0; ext=1;;
  esac
  if [[ -t 1 ]]; then
    printf "\e[%d;%dm$date [$label] $msg\e[0m\n" $ext $col
  else
    printf "$date [$label] $msg\n"
  fi
}

log.debug() {
  local msg="$1"
  _log.base "$msg" $LOG_DEBUG
}

log.info() {
  local msg="$1"
  _log.base "$msg" $LOG_INFO
}

log.warn() {
  local msg="$1"
  _log.base "$msg" $LOG_WARN
}

log.error() {
  local msg="$1"
  _log.base "$msg" $LOG_ERROR
}

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<logger.bashrc> - Log functions for Bash

=head1 SYNOPSYS

    source logger.bashrc

    LOG_LEVEL=$LOG_DEBUG # Defaults to $LOG_INFO

    log.debug "debug message"
    log.info "info message"
    log.warn "warning message"
    log.error "error message"

=head1 DESCRIPTION

This library provides logging functions.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2016 IKEDA Kiyoshi

=cut

__EOF__


. logger.bashrc

T_SUB "When LOG_LEVEL is INFO" ((
  LOG_LEVEL=$LOG_INFO
  log.debug "debug log"
  t_is $? 0 "log.debug succeeds"
  out=$(log.debug "debug log")
  t_ng "$out" "Nothing put out"
  log.info "info log" | grep info &>/dev/null
  t_is $? 0 "Info log put out"
))

# vim:set ft=sh :

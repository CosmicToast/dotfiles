type -qf ssh || exit
alias ossh 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=Error'

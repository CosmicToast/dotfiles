string match -q '*antlr*' $CLASSPATH || return
alias antlr4 "java -Xmx500M org.antlr.v4.Tool"
alias grun   "java -Xmx500M org.antlr.v4.gui.TestRig"

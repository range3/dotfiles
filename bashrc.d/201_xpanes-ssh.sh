# xpanes

function xpanes-cluster() { cat $@ | xpanes --ssh -C 4 ;}

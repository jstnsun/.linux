# .zshrc
#
# Interactive-use configuration file for the Z shell (Zsh).
# See https://zsh.sourceforge.io/Intro/intro_3.html for more information.
#
# jstnsun

fastfetch
for file in "${ZCOREDIR}"/*(NOn) "${ZEXTRADIR}"/*(N); do source "$file"; done

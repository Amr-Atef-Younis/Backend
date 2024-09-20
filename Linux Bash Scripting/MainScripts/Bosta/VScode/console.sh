#!/bin/bash

x="$(xsel -b | tr '' '\n')"


y="console.log(\`########################## $x ####################\`)
\t\tconsole.log($x)
\t\tconsole.log(\`########################## $x ####################\`)"
echo -e "$y" | xclip -selection c


# printf "%b\n" "$y" | xclip -selection c

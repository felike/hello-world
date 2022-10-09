#!/usr/bin/wish

ttk::treeview .tree -columns "Creator Day Year" -displaycolumns "Year Day Creator" 
.tree heading Creator -text "Creator" -anchor center
.tree heading Year -text "Year" -anchor center
.tree heading Day -text "Day" -anchor center
pack .tree
.tree insert {} end -id Languages -text "Languages"
.tree insert Languages end -text C -values [list "Dennis Ritchie" "1990" "90"]
.tree insert Languages end -text B -values [list "Dennis Ritchie" "1990" "90"]
proc scaleMe {mywidget scaleValue} {
	$mywidget configure -length $scaleValue
} 
pack [scale .s2  -from 100.0 -to 200.0 -length 100 -background yellow -borderwidth 5 \
   -foreground red -width 40 -relief ridge -orien horizontal \
   -variable a -command "scaleMe .s2" ]
pack [ttk::progressbar .p1 -orient horizontal -length 200 -mode indeterminate -value 90]
pack [ttk::progressbar .p2 -orient horizontal -length 200 -mode determinate -variable a \
   -maximum 75 -value 20]

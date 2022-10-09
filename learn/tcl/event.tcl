#!/usr/bin/wish

proc myEvent { } {
   puts "Event triggered"
}
pack [button .myButton1  -text "Button 1"   -command myEvent]
#bind .  ".myButton1 invoke"

::  This needs a better SDN solution.  Every ship should have an IP
::  address, and we should eventually test changing those IP
::  addresses.
::
::  For now, we broadcast every packet to every ship and rely on them
::  to drop them.
::
/-  aquarium, spider
/+  aqua-vane-thread
=,  aquarium
=|  ships=(list ship)
|%
++  emit-aqua-events
  |=  [our=ship aes=(list aqua-event)]
  ^-  (list card:agent:gall)
  [%pass /aqua-events %agent [our %aqua] %poke %aqua-events !>(aes)]~
::
++  handle-restore
  |=  [our=ship who=@p]
  ^-  (quip card:agent:gall _ships)
  :_  ships
  %+  emit-aqua-events  our
  [%event who [//newt/0v1n.2m9vh %born ~]]~
::
++  handle-send
  |=  [our=ship now=@da way=wire sendr=@p %send lan=lane:ames pac=@]
  ^-  (quip card:agent:gall _ships)
  =/  rcvr=ship  (lane-to-ship lan)
  =/  hear-lane  (ship-to-lane sndr)
  :_  ships
  %+  emit-aqua-events  our
  %+  turn  ships
  |=  who=ship
    [%event rcvr //newt/0v1n.2m9vh %hear hear-lane pac]~
::  +lane-to-ship: decode a ship from an aqua lane
::
++  lane-to-ship
  |=  =lane:ames
  ^-  ship
  ::
  ?-  -.lane
    %&  p.lane
    %|  `ship``@`p.lane
  ==
::  +ship-to-lane: encode a lane to look like it came from .ship
::
::    Never shows up as a galaxy, because Vere wouldn't know that either.
::
++  ship-to-lane
  |=  =ship
  ^-  lane:ames
  ::
  [%| `address:ames``@`ship]
--
::
%-  aqua-vane-thread
|_  =bowl:spider
+*  this  .
++  handle-unix-effect
  |=  [who=@p ue=unix-effect]
  ^-  (quip card:agent:gall _this)
  =^  cards  ships
    ?+  -.q.ue  `ships
      %restore  (handle-restore our.bowl who)
      %send     (handle-send our.bowl now.bowl who ue)
    ==
  [cards this]
::
++  handle-arvo-response  _!!
--

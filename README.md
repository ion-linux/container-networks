# container-networks
[Youtube](https://www.youtube.com/watch?v=6v_BDHIgOY8)

- Single network namespace
- Single node, 2 namespaces
- Multiple nodes, same L2 network
- Multiple nodes, overlay network


```
##############################
#  xxxxxxxxxxxxxxxxxxxxxxxx  #
#  x     container        x  #
#  x                      x  #
#  x   xxxxxxxxxxxxxxxx   x  #
#  x   x    VETH2     x   x  #
#  x   x 172.16.0.0.1 x   x  #
#  xxxxxxxxxxxxxxxxxxxxxxxx  #
#             | routes to    #
#             |  VETH1       #
#             v              #
#      xxxxxxxxxxxxxxxx      #
#      x    VETH1     x      #
#      x              x      #
#      xxxxxxxxxxxxxxxx      #
#             | routes to    #
#             |  default ns  #
#             v              #
#       xxxxxxxxxxxxxxx      #
#       x    ens5     x      #
#       x  10.0.0.10  x      #
##############################
```

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


```
######################################################################################
#   Single Node, 2 Namespaces                                                                                 #
#      xxxxxxxxxxxxxxxxxxxxxxxx         xxxxxxxxxxxxxxxxxxxxxxxx                     #
#      x                      x         x                      x                     #
#      x                      x         x                      x                     #
#      x      container 1     x         x      container 2     x                     #
#      x                      x         x                      x                     #
#      x     172.16.0.0.2     x         x     172.16.0.0.3     x                     #
#      xxxxx              xxxxx         xxxxx              xxxxx                     #
#          x    VETH11    x                 x    VETH21    x                         #
#          xxxxxxxxxxxxxxxx                 xxxxxxxxxxxxxxxx                         #
#                 |                                 |  default via 172.16.0.1 veth21 #
#                 |                                 |  172.16.0.0/24 veth21          #
#                 v                                 v                                #
#             xxxxxxxxxx                        xxxxxxxxxx                           #
#             x VETH10 x                        x VETH20 x                           #
#      xxxxxxxx        xxxxxxxxxxxxxxxxxxxxxxxxxx        xxxxxxx                     #
#      x                       172.16.0.1                      x                     #
#      x                           br0                         x                     #
#      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                     #
#                                   | routes 172.16.0.0/24 to                        #
#                                   |  default ns                                    #
#                                   v                                                #
#                             xxxxxxxxxxxxxxx                                        #
#                             x    ens5     x   ens5 is in default namespace         #
#                             x  10.0.0.10  x                                        #
######################################################################################
```

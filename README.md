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
Single Node, 2 Namespaces 
######################################################################################
#                                                                                    #
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

```
Multiple Nodes, Same L2 Network

routes CON1
default via 172.16.0.1 veth11
172.16.0.0/24 veth11

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
x                                x   x                                x
x xxxxxxxxxxxxxx xxxxxxxxxxxxxx  x   x xxxxxxxxxxxxxx xxxxxxxxxxxxxx  x
x x    CON1    x x    CON2    x  x   x x    CON1    x x    CON2    x  x
x x 172.16.0.2 x x 172.16.0.3 x  x   x x 172.16.1.2 x x 172.16.1.3 x  x
x xxxxxxxxxxxxxx xxxxxxxxxxxxxx  x   x xxxxxxxxxxxxxx xxxxxxxxxxxxxx  x
x   veth11 |        |  veth21        x    veth11 |        |  veth21   x
x          |        |                x           |        |           x
x          |        |                x           |        |           x
x          |        |                x           |        |           x
x   veth10 |        |  veth20    x   x    veth10 |        |  veth20   x
x        xxxxxxxxxxxxxxx         x   x        xxxxxxxxxxxxxxx         x
x        x    BR0      x         x   x        x    BR0      x         x
x        x 172.16.0.1  x         x   x        x 172.16.1.1  x         x
x        xxxxxxxxxxxxxxx         x   x        xxxxxxxxxxxxxxx         x
x                |               x   x                |               x
x                |               x   x                |               x
x          xxxxxxxxxxxxx         x   x          xxxxxxxxxxxxx         x
x          x    ens5   x         x   x          x    ens5   x         x
x          x 10.0.0.10 x         x   x          x 10.0.0.20 x         x
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                  |                                    |
                  |            xxxxxxxxxx              |
                  ------------x  SWITCH  x-------------|
                               xxxxxxxxxx

  routes                               routes
  172.16.0.0/24 BR0                    172.16.1.0/24 BR0
  172.16.1.0/24 via 10.0.0.20 ens5     172.16.0.0/24 via 10.0.0.10 ens5
  10.0.0.0/16 ens5                     10.0.0.0/16 ens5
```

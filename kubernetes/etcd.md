# ETCD

From <https://www.youtube.com/watch?v=L9xkXzpEY6Q>

It is a key-value store. That's it ?

## Service

```
./etcd # And it runs.
```

## Client

```
# but.... which document ?

./etcdctl set key1 value1

./etcdctl get key1
```

## Distribution

Can have the store accross various servers

etcd ensures consitency across nodes

A leader is elected during initial start. All writes go to the leader, and then distributes written data

RAFT protocol

Random timer runs on each node, and leader is found. Leader continually identifies itself. If it goes, new leader vote is run.

If a peer does not get written to one node, write is only complete if `floor(N/2+1)` nodes have received the data. etcd cluster needs 3 nodes minimum to ensure reliance. Select odd number to ensure quorum of original cluster in case of network segmentation.

## install

see 12:55

## etcdctl

```
export ETCDCTL_API=3

etcdctl put name jay # alternative to "set" from v2 ?
etcdctl get name
```


test:
	kubectl rollout status statefulset/zk
	sleep 10
	(kubectl exec zk-0 -- /bin/sh -c "echo stat | nc 127.0.0.1 2181" | grep 'Node count: 4')
	(kubectl exec zk-1 -- /bin/sh -c "echo stat | nc 127.0.0.1 2181" | grep 'Node count: 4')
	(kubectl exec zk-2 -- /bin/sh -c "echo stat | nc 127.0.0.1 2181" | grep 'Node count: 4')
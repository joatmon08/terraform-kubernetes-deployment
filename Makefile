test:
	kubectl exec zk-0 zkCli.sh create /hello world
	kubectl exec zk-1 zkCli.sh get /hello
test:
	kubectl exec zk-0 zkCli.sh create /hello world
	kubectl exec zk-1 zkCli.sh get /hello
	kubectl exec zk-2 zkCli.sh get /hello
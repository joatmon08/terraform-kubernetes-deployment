test:
	kubectl rollout status statefulset/zk
	sleep 10
	(kubectl exec zk-0 -- /bin/sh -c "echo stat | nc 127.0.0.1 2181" | grep 'Node count: 4')
	(kubectl exec zk-1 -- /bin/sh -c "echo stat | nc 127.0.0.1 2181" | grep 'Node count: 4')
	(kubectl exec zk-2 -- /bin/sh -c "echo stat | nc 127.0.0.1 2181" | grep 'Node count: 4')

demo:
	minikube start --cpus 4 --memory 8192
	open https://app.terraform.io/signup
	open https://app.terraform.io/app/hashicorp-team-demo/workspaces
	open https://www.hashicorp.com/blog/announcing-terraform-0-12
	open https://github.com/joatmon08/terraform0.12-cloud

clean:
	terraform destroy -var-file=nginx.tfvars --force
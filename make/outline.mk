outline-get-keys:
	curl --insecure "https://localhost:8081/api/access-keys"; echo

outline-create-key:
	curl --insecure -X POST "https://localhost:8081/api/access-keys" \
		-H "Content-Type: application/json" \
		-d '{
			"name": "${name}"
		}'; echo

outline-delete-key:
	curl --insecure -X DELETE "https://localhost:8081/api/access-keys/${id}"; echo
reconfigure:
	ansible-playbook -i inventory.ini htcplaybook.yml --ask-become-pass --start-at-task "Set condor config"
restart-condor:
	sudo systemctl restart condor
status:
	sudo systemctl status condor
logs:
	sudo tail -30 /var/log/condor/MasterLog


0. mellanox root = /root/nfs-devstack/mellanox
	# cd /root/nfs-devstack/mellanox

*** Nova VIF
1. edit conf/mlnx-nova.conf

2. cd bin

3. run install-nova.sh
	# ./install-nova.sh

4. run config-nova.sh
	# ./config-nova.sh

*** eSwitch Daemon 

1. edit conf/mlnx-eswitchd.conf	

2. cd bin

3. run install-eswitchd.sh"
	# ./install-eswitchd.sh

4. run config-eswitchd.sh
	# ./config-eswitchd.sh

*** Mellanox Quantum Agent

1. edit conf/mlnx-quantum-agent.conf

2. cd bin

3. run install-quantum-agent.sh
	# ./install-quantum-agent.sh

4. run config-quantum-agent.sh
	# ./config-qauntum-agent.sh


netperf -t TCP_STREAM -H 50.50.1.254 -C -c -l 30 -f G -D
netperf -t UDP_STREAM -H 50.50.1.254 -C -c -l 30 -f G -D -- -m 65000 -S 32768
netperf -t TCP_STREAM -H 50.50.1.254 -C -c -l 30 -f G -D 
netperf -t UDP_STREAM -H 50.50.1.254 -C -c -l 30 -f G -D -- -m 1472 -s 4M -S 4M
netperf -t UDP_STREAM -H 50.50.1.254 -C -c -l 30 -f G -D -- -m 1000



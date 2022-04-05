# Installing tor, torsocks, wget 

Install tools and download db1000n 
```bash
sudo apt-get -y update && \
sudo apt-get -y install tor torsocks wget curl && \
wget https://github.com/Arriven/db1000n/releases/download/v0.8.17/db1000n_0.8.17_linux_amd64.tar.gz -O db1000n.tar.gz && \
tar xvzf db1000n.tar.gz -C ./
```

# Setting up basic tor options 

Separate IP per torsocks process:
```bash
cat /etc/tor/torsocks.conf | sed 's/#IsolatePID/IsolatePID/g' | sudo tee /etc/tor/torsocks.conf > /dev/null 
```

And max connections limit up to max possible value:
```bash
echo "ConnLimit 32267" | sudo tee -a /etc/tor/torrc > /dev/null
```

# Start tor service
```bash
sudo service tor start
```

# Check you have eah time new IP used
Repeat this command multiple times to verify youd indeed have each time new IP address used:
```bash
torsocks curl -L jsonip.com
```

# Run
```bash
torsocks ./db1000n 
```


#  Find Tor Nodes in specific country
Go to https://metrics.torproject.org/rs.html#search/ru

To use specific Nodes from the search result you may use Node's fingerprint or IP address in ExitNodes entry of the torrc config.

So to use Nodes 95.214.54.70, 82.165.116.173 and 185.32.222.237 addthe following entry to `/etc/tor/torrc` file:
```
ExitNodes 95.214.54.70,82.165.116.173,185.32.222.237
```

# More information about configuring Tor
- [torrc man page](https://manpages.debian.org/testing/tor/torrc.5.en.html)
- [torsocks.conf details](https://linux.die.net/man/5/torsocks.conf)

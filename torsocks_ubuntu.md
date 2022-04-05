# Installing tor, torsocks, wget 

```bash
sudo apt-get -y update && \
sudo apt-get install tor torsocks wget && \
wget https://github.com/Arriven/db1000n/releases/download/v0.8.17/db1000n_0.8.17_linux_amd64.tar.gz -O db1000n.tar.gz && \
tar xvz db1000n.tar.gz -C ./db1000n
```

# Setting up basic tor options (separate IP per torsocks process + raise connections limit up to max value)
```bash
cat /etc/tor/torsocks.conf | sed 's/#IsolatePID/IsolatePID/g' | sudo tee /etc/tor/torsocks.conf > /dev/null 
echo "ConnLimit 32267" | sudo tee -a /etc/tor/torrc > /dev/null
```

# Start tor service
```bash
sudo service tor start
```

# Run
```bash
torsocks ./db1000n/db1000n 
```

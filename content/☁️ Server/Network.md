	 Absolutely. Since your **mido + postmarketOS + OpenRC + wpa_supplicant** setup is now working, here's a practical Wi-Fi command reference specifically for your phone.

# 📶 postmarketOS Wi-Fi Cheat Sheet

Your setup:

```text
Wi-Fi interface : wlan0
Wi-Fi manager   : wpa_supplicant
Service manager : OpenRC
DHCP client     : udhcpc
```

---

## 1. Check Wi-Fi interface

```bash
ip link show wlan0
```

More detailed:

```bash
ip addr show wlan0
```

You want:

```text
state UP
```

and, after DHCP:

```text
inet 192.168.1.x/24
```

---

# 2. Turn Wi-Fi ON/OFF

### Turn ON

```bash
sudo ip link set wlan0 up
```

### Turn OFF

```bash
sudo ip link set wlan0 down
```

Check:

```bash
ip link show wlan0
```

---

# 3. Check wpa_supplicant

### Status

```bash
sudo rc-service wpa_supplicant status
```

### Start

```bash
sudo rc-service wpa_supplicant start
```

### Stop

```bash
sudo rc-service wpa_supplicant stop
```

### Restart

```bash
sudo rc-service wpa_supplicant restart
```

### See process

```bash
ps aux | grep '[w]pa_supplicant'
```

---

# 4. Check current Wi-Fi connection

```bash
sudo wpa_cli -i wlan0 status
```

Successful:

```text
wpa_state=COMPLETED
ssid=A103_5G
freq=5180
```

Common states:

```text
SCANNING
ASSOCIATING
ASSOCIATED
COMPLETED
DISCONNECTED
```

---

# 5. Scan for Wi-Fi networks

Start scan:

```bash
sudo wpa_cli -i wlan0 scan
```

Wait:

```bash
sleep 3
```

Show results:

```bash
sudo wpa_cli -i wlan0 scan_results
```

Example:

```text
A103_2.4G
A103_5G
A107
```

---

# 6. List saved Wi-Fi networks

Correct command:

```bash
sudo wpa_cli -i wlan0 list_networks
```

Example:

```text
network id / ssid / bssid / flags
0    A103_2.4G    any
1    A103_5G      any
```

Remember:

```text
0 = A103_2.4G
1 = A103_5G
```

The numbers are **network IDs**, not Wi-Fi channels.

---

# 7. Connect to a saved network

### A103_2.4G

```bash
sudo wpa_cli -i wlan0 select_network 0
```

### A103_5G

```bash
sudo wpa_cli -i wlan0 select_network 1
```

Then:

```bash
sudo wpa_cli -i wlan0 status
```

---

# 8. Enable/disable a saved network

Enable:

```bash
sudo wpa_cli -i wlan0 enable_network 1
```

Disable:

```bash
sudo wpa_cli -i wlan0 disable_network 1
```

For example:

```bash
sudo wpa_cli -i wlan0 disable_network 0
```

---

# 9. Disconnect Wi-Fi

```bash
sudo wpa_cli -i wlan0 disconnect
```

Reconnect:

```bash
sudo wpa_cli -i wlan0 reconnect
```

---

# 10. Add a new Wi-Fi network

Create:

```bash
sudo wpa_cli -i wlan0 add_network
```

Suppose it returns:

```text
2
```

Then:

```bash
sudo wpa_cli -i wlan0 set_network 2 ssid '"A107"'
```

Password:

```bash
sudo wpa_cli -i wlan0 set_network 2 psk '"YOUR_PASSWORD"'
```

Enable:

```bash
sudo wpa_cli -i wlan0 enable_network 2
```

Connect:

```bash
sudo wpa_cli -i wlan0 select_network 2
```

Check:

```bash
sudo wpa_cli -i wlan0 status
```

---

# 11. Remove a saved network

First:

```bash
sudo wpa_cli -i wlan0 list_networks
```

Then:

```bash
sudo wpa_cli -i wlan0 remove_network 2
```

Save:

```bash
sudo wpa_cli -i wlan0 save_config
```

---

# 12. Save Wi-Fi configuration

After adding/changing networks:

```bash
sudo wpa_cli -i wlan0 save_config
```

Check configuration:

```bash
sudo cat /etc/wpa_supplicant/wpa_supplicant.conf
```

⚠️ **Don't share that file**, because it can contain your Wi-Fi password.

---

# 13. DHCP / IP address

Get an IP:

```bash
sudo udhcpc -i wlan0
```

Check IP:

```bash
ip addr show wlan0
```

Your current one:

```text
192.168.1.13
```

Check routing:

```bash
ip route
```

You should see something similar to:

```text
default via 192.168.1.1 dev wlan0
```

---

# 14. Renew DHCP

```bash
sudo udhcpc -i wlan0
```

If you want to clear the existing address first:

```bash
sudo ip addr flush dev wlan0
sudo udhcpc -i wlan0
```

---

# 15. Test network connectivity

### Test phone → router

```bash
ping -c 4 192.168.1.1
```

### Test Internet without DNS

```bash
ping -c 4 1.1.1.1
```

### Test DNS + Internet

```bash
ping -c 4 google.com
```

This gives you a very useful troubleshooting sequence:

```text
ping router
     ↓
works?
     ↓
ping 1.1.1.1
     ↓
works?
     ↓
ping google.com
```

---

# 16. Check DNS

```bash
cat /etc/resolv.conf
```

You may see:

```text
nameserver 192.168.1.1
```

or another DNS server.

---

# 17. Check routes

```bash
ip route
```

You want something like:

```text
default via 192.168.1.1 dev wlan0
192.168.1.0/24 dev wlan0
```

If there is **no `default` route**, Internet access won't work.

---

# 18. Check Wi-Fi control socket

This is useful because we previously had this problem.

```bash
ls -l /var/run/wpa_supplicant/
```

You want:

```text
wlan0
```

If it's missing:

```bash
sudo rc-service wpa_supplicant restart
```

Then:

```bash
ls -l /var/run/wpa_supplicant/
```

---

# 19. If `wpa_cli` says socket doesn't exist

For example:

```text
Failed to connect to non-global ctrl_ifname
```

Check:

```bash
sudo rc-service wpa_supplicant status
```

Then:

```bash
ps aux | grep '[w]pa_supplicant'
```

Then:

```bash
ls -l /var/run/wpa_supplicant/
```

If `wlan0` isn't there:

```bash
sudo rc-service wpa_supplicant restart
```

---

# 20. If Wi-Fi is stuck on `SCANNING`

Check:

```bash
sudo wpa_cli -i wlan0 status
```

Then:

```bash
sudo wpa_cli -i wlan0 scan
sleep 5
sudo wpa_cli -i wlan0 scan_results
```

If your network appears but doesn't connect, check:

```bash
sudo wpa_cli -i wlan0 list_networks
```

A network showing:

```text
[TEMP-DISABLED]
```

usually means `wpa_supplicant` temporarily disabled it after a connection failure.

You can try:

```bash
sudo wpa_cli -i wlan0 enable_network ID
sudo wpa_cli -i wlan0 select_network ID
```

---

# 21. If authentication/password fails

Remove the network:

```bash
sudo wpa_cli -i wlan0 remove_network ID
```

Create it again:

```bash
sudo wpa_cli -i wlan0 add_network
```

Then:

```bash
sudo wpa_cli -i wlan0 set_network ID ssid '"YOUR_SSID"'
sudo wpa_cli -i wlan0 set_network ID psk '"YOUR_PASSWORD"'
sudo wpa_cli -i wlan0 enable_network ID
sudo wpa_cli -i wlan0 select_network ID
```

---

# 22. Complete Wi-Fi restart

If everything gets messed up, use:

```bash
sudo wpa_cli -i wlan0 disconnect
sudo ip addr flush dev wlan0
sudo ip link set wlan0 down
sudo ip link set wlan0 up
sudo rc-service wpa_supplicant restart
sudo wpa_cli -i wlan0 reconnect
sudo udhcpc -i wlan0
```

Then:

```bash
sudo wpa_cli -i wlan0 status
ip addr show wlan0
ip route
```

---

# 23. Nuclear Wi-Fi reset

If you're completely stuck:

```bash
sudo rc-service wpa_supplicant stop
sudo ip addr flush dev wlan0
sudo ip link set wlan0 down
sudo rc-service wpa_supplicant start
sudo ip link set wlan0 up
```

Then:

```bash
sudo wpa_cli -i wlan0 scan
sleep 3
sudo wpa_cli -i wlan0 scan_results
```

Then connect to a saved network.

---

# 24. Check Wi-Fi hardware

```bash
ip link
```

You should see:

```text
wlan0
```

Also:

```bash
ls /sys/class/net/wlan0/
```

And:

```bash
dmesg | grep -Ei 'wlan|wifi|firmware|ath|qcom'
```

This can be useful if Wi-Fi suddenly stops working after a reboot.

---

# 25. USB SSH backup

Since you're using the phone as a server, this is **very useful**.

Your USB connection:

```text
Fedora → USB → mido
```

Phone:

```text
172.16.42.1
```

SSH:

```bash
ssh parag@172.16.42.1
```

Wi-Fi:

```text
192.168.1.13
```

SSH:

```bash
ssh parag@192.168.1.13
```

### When changing Wi-Fi

Always prefer:

```text
USB SSH
   ↓
change Wi-Fi
   ↓
Wi-Fi SSH may disconnect
   ↓
USB SSH remains available
```

---

# 🧰 The 15 commands I'd actually memorize

You don't need to memorize the entire list.

```bash
# Interface
ip addr show wlan0

# ON/OFF
sudo ip link set wlan0 up
sudo ip link set wlan0 down

# Wi-Fi status
sudo wpa_cli -i wlan0 status

# Scan
sudo wpa_cli -i wlan0 scan
sudo wpa_cli -i wlan0 scan_results

# Saved networks
sudo wpa_cli -i wlan0 list_networks

# Connect
sudo wpa_cli -i wlan0 select_network ID

# Disconnect/reconnect
sudo wpa_cli -i wlan0 disconnect
sudo wpa_cli -i wlan0 reconnect

# DHCP
sudo udhcpc -i wlan0

# Routing
ip route

# Internet test
ping -c 4 1.1.1.1
ping -c 4 google.com

# Restart Wi-Fi manager
sudo rc-service wpa_supplicant restart

# Save configuration
sudo wpa_cli -i wlan0 save_config
```

### Your mental model

```text
wlan0
  │
  │  wpa_supplicant
  ▼
Wi-Fi network
  │
  │  DHCP / udhcpc
  ▼
192.168.1.x
  │
  │  ip route
  ▼
192.168.1.1
  │
  ▼
Internet
```

And once we install **Tailscale**, we'll add one more layer on top:

```text
Internet
   │
Tailscale
   │
   ▼
mido
   │
SSH
   ▼
Your server
```

That will make this Redmi Note 4 much more practical as an **always-on remotely accessible Linux server**.
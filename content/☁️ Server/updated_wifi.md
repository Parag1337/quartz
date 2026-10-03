sudo nmcli device wifi connect "A103_2.4G"Yes. Now that **NetworkManager is managing Wi-Fi**, let's use only `nmcli` for Wi-Fi from now on.

## 📶 Current Wi-Fi commands

### Check Wi-Fi status

```bash
nmcli device status
```

### See nearby Wi-Fi networks

```bash
nmcli device wifi list
```

### See saved Wi-Fi connections

```bash
nmcli connection show
```

---

## 🔄 Switch Wi-Fi

### Switch to 5 GHz

```bash
sudo nmcli connection up "A103_5G"
```

### Switch to 2.4 GHz

```bash
sudo nmcli connection up "A103_2.4G"
```

### Check which one is active
	
```bash
nmcli connection show --active
```

or:

```bash
nmcli device status
```

---

## 📡 Disconnect / reconnect

### Disconnect Wi-Fi

```bash
sudo nmcli device disconnect wlan0
```

### Reconnect to a saved network

```bash
sudo nmcli connection up "A103_5G"
```

or:

```bash
sudo nmcli connection up "A103_2.4G"
```

### Turn Wi-Fi radio off

```bash
sudo nmcli radio wifi off
```

### Turn Wi-Fi radio back on

```bash
sudo nmcli radio wifi on
```

---

## 🌐 IP/network information

### Check IP

```bash
ip addr show wlan0
```

### Check routes

```bash
ip route
```

### Check DNS

```bash
nmcli device show wlan0 | grep DNS
```

### Test Internet

```bash
ping -c 4 1.1.1.1
```

```bash
ping -c 4 google.com
```

---

## 🔧 NetworkManager service

Check:

```bash
sudo rc-service networkmanager status
```

Restart:

```bash
sudo rc-service networkmanager restart
```

Enable at boot:

```bash
sudo rc-update add networkmanager default
```

---

## 🔐 Add a new Wi-Fi network

If you encounter another Wi-Fi:

```bash
sudo nmcli device wifi connect "WIFI_NAME" --ask
```

It will ask for the password.

---

## 🗑️ Forget a saved Wi-Fi

First:

```bash
nmcli connection show
```

Then:

```bash
sudo nmcli connection delete "WIFI_NAME"
```

---

# 🚫 Commands we don't need anymore

Since NetworkManager is now handling Wi-Fi, **don't normally use**:

```bash
wpa_cli
udhcpc
ip route add default
```

NetworkManager handles those automatically.

### Your new simple workflow

```text
Check:
nmcli device status

Scan:
nmcli device wifi list

Switch:
sudo nmcli connection up "A103_5G"

Disconnect:
sudo nmcli device disconnect wlan0

Reconnect:
sudo nmcli connection up "A103_5G"

IP:
ip addr show wlan0

Internet:
ping -c 4 google.com
```

---

## Next step for our server

Now that Wi-Fi is managed properly, I recommend we **clean up the old manual Wi-Fi configuration and test a reboot**.

After the reboot, we want:

```text
Phone boots
   ↓
NetworkManager starts
   ↓
wlan0 connects automatically
   ↓
DHCP
   ↓
Internet
   ↓
SSH
```

Once that works, **Tailscale is the next step**.
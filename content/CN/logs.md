Now that Wi-Fi is working, **the next step should be Tailscale**. Your phone is already a functioning Alpine/postmarketOS server; Tailscale will give it a stable private network identity so you can SSH to it without relying on `192.168.1.13`.

I checked the current Alpine packages: **Tailscale is available for Alpine 3.24/aarch64**, which matches your phone, and there is an OpenRC package for it. ([Alpine Linux Packages](https://pkgs.alpinelinux.org/package/v3.24/community/aarch64/tailscale-doc?utm_source=chatgpt.com "tailscale-doc - Alpine Linux packages"))

## Step 1 — First make Wi-Fi persistent

Before Tailscale, let's make sure Wi-Fi automatically comes back after reboot.

On `mido` run:

```bash
sudo rc-update add wpa_supplicant boot
sudo rc-update add networking boot
```

And because your installation includes `/etc/wpa_supplicant/wpa_cli.sh`, enable the DHCP helper:

```bash
sudo rc-update add wpa_cli default
```

Alpine's documentation recommends enabling `wpa_supplicant` and `networking` at boot, and the `wpa_cli` helper can automatically trigger DHCP when the Wi-Fi association changes. ([Alpine Linux Wiki](https://wiki.alpinelinux.org/wiki/Wifi?utm_source=chatgpt.com "Wi-Fi - Alpine Linux"))

Check:

```bash
rc-update
```

---

# Step 2 — Make sure `apk` works

Now that Internet works:

```bash
sudo apk update
```

Then:

```bash
sudo apk upgrade
```

Let it finish.

**Don't reboot yet.**

---

# Step 3 — Install Tailscale

Run:

```bash
sudo apk add tailscale tailscale-openrc
```

The Alpine package provides both `tailscale` and `tailscaled`, and the `tailscale-openrc` subpackage provides the OpenRC service integration. ([Alpine Linux Packages](https://pkgs.alpinelinux.org/package/v3.24/community/aarch64/tailscale-doc?utm_source=chatgpt.com "tailscale-doc - Alpine Linux packages"))

Verify:

```bash
tailscale version
```

---

# Step 4 — Start Tailscale

Because we're using **OpenRC**, don't use `systemctl`.

Run:

```bash
sudo rc-service tailscaled start
```

Then:

```bash
sudo rc-service tailscaled status
```

If it says started, enable it permanently:

```bash
sudo rc-update add tailscaled default
```

OpenRC is the correct service manager for the Alpine-based system you're running. ([Alpine Linux Wiki](https://wiki.alpinelinux.org/wiki/OpenRC?utm_source=chatgpt.com "OpenRC - Alpine Linux"))

---

# Step 5 — Connect the phone to your Tailscale account

Run:

```bash
sudo tailscale up
```

It should give you a URL.

Open that URL on your Fedora browser and authenticate with your Tailscale account.

Tailscale's official Linux flow uses `tailscale up` after the client is installed. ([Tailscale](https://tailscale.com/docs/install?utm_source=chatgpt.com "Install Tailscale · Tailscale Docs"))

---

# Step 6 — Find the Tailscale IP

After authentication:

```bash
tailscale ip
```

You'll get something like:

```text
100.x.x.x
```

Also:

```bash
tailscale status
```

You should see your mido device.

---

# Step 7 — SSH through Tailscale

From Fedora:

```bash
ssh parag@100.x.x.x
```

Replace `100.x.x.x` with the address returned by:

```bash
tailscale ip
```

If that works, you've achieved the main goal:

```text
             Tailscale network
                    │
        ┌───────────┴───────────┐
        │                       │
      Fedora                   mido
        │                       │
        │                   Redmi Note 4
        │                   postmarketOS
        │                   Alpine Linux
        │                       │
        └────── SSH ────────────┘
```

You won't need:

```text
192.168.1.13
```

anymore for remote access.

---

## Our next roadmap

After Tailscale is working, I'd set the server up in this order:

```text
✅ postmarketOS
✅ Alpine Linux
✅ OpenRC
✅ Wi-Fi
⬜ Wi-Fi automatic on boot
⬜ Tailscale
⬜ SSH over Tailscale
⬜ SSH key authentication
⬜ Disable password SSH
⬜ Install Git
⬜ Install Python
⬜ Install Docker/Podman if actually needed
⬜ Run your server applications
⬜ Automatic service startup
⬜ Monitoring/logging
⬜ Power/thermal optimization
```

**For now, don't do all of that.** Run just:

```bash
sudo rc-update add wpa_supplicant boot
sudo rc-update add networking boot
sudo rc-update add wpa_cli default
sudo apk update
```

Then paste the output of `sudo apk update`. We'll proceed one step at a time.
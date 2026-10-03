Good. The agent's inspection gives you the **actual run procedure**, and importantly it didn't modify anything.

For your setup, I would use **debug mode first**, because the agent found that the current release APK is missing the main `INTERNET` permission.

### Your normal development setup

**Terminal 1 — backend**

```bash
cd ~/Projects/ReddSlide/backend
source .venv/bin/activate
python main.py
```

Backend:

```text
http://localhost:8000
```

**Terminal 2 — Flutter**

```bash
cd ~/Projects/ReddSlide
flutter run
```

### If you're using your physical Android phone

The easiest method over USB is:

```bash
adb reverse tcp:8000 tcp:8000
```

Then inside the app:

```text
Settings → Backend URL

http://127.0.0.1:8000
```

This avoids dealing with your LAN IP.

### Verify backend first

Before opening the app:

```bash
curl http://localhost:8000/api/health
```

Then:

```bash
curl http://localhost:8000/api/feed | head -c 300
```

If those work, start Flutter.

### One thing I would fix later

The agent found this:

> Release APK currently lacks `INTERNET` permission.

So **don't build/use the release APK yet** for actual backend-connected testing. `flutter run` debug is fine according to the inspection.

And don't randomly modify it now since your current goal was to preserve the app. When you're ready, we can make that specific Android manifest fix and verify it without touching the rest of the application.
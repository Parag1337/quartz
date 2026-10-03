---
title: what is this assingment 4
date: 2026-09-07
tags:
---
	Yes. You actually have **four different networking / data-link concepts** in that message:

1. **1-bit Alternating Bit Protocol**
    
2. **Go-Back-N ARQ**
    
3. **Selective Repeat ARQ**
    
4. **TCP Client–Server program in Java**
    

The first three are **reliable data-link/ARQ protocol simulations**. The last one is an actual **network socket program** using TCP.

I'll explain everything from the absolute basics, then connect each explanation directly to your code.

---

# 1. First: What problem are these programs solving?

Imagine you want to send:

```text
HELLO
```

from one computer to another.

You might think:

```text
Sender ───────────────► Receiver
          HELLO
```

But real networks are not perfect.

Data can:

- get lost
    
- arrive late
    
- arrive corrupted
    
- arrive multiple times
    
- arrive out of order
    

So we need mechanisms that make communication **reliable**.

A basic solution is:

```text
Sender                    Receiver
  │                          │
  │────── Frame 0 ─────────►│
  │                          │
  │◄────── ACK 0 ───────────│
  │                          │
  │────── Frame 1 ─────────►│
  │                          │
  │◄────── ACK 1 ───────────│
```

The sender sends a frame.

The receiver replies:

> "I received it."

That reply is called an **ACK — Acknowledgement**.

If the sender doesn't receive the ACK within some time:

```text
Sender                    Receiver
  │                          │
  │────── Frame 0 ─────────►│
  │                          X
  │
  │       timeout
  │
  │────── Frame 0 ─────────►│
```

The sender retransmits.

This general concept is called **ARQ**.

---

# 2. What is ARQ?

**ARQ = Automatic Repeat reQuest**

It is a mechanism for reliable transmission.

The basic idea:

```text
SEND
 ↓
Wait for ACK
 ↓
ACK received?
 ├── YES → Continue
 └── NO  → Retransmit
```

There are several ARQ protocols.

The ones in your programs are:

```text
                 ARQ
                  │
        ┌─────────┴─────────┐
        │                   │
   Stop-and-Wait        Sliding Window
        │                   │
  Alternating Bit     ┌─────┴─────┐
                       │           │
                  Go-Back-N   Selective Repeat
```

Your three C++ programs simulate these.

---

# 3. Before 1-bit: What is a frame?

A **frame** is a unit of data transmitted at the data-link layer.

Suppose you have:

```text
HELLOWORLD
```

and frame size = 4.

You can divide it:

```text
Frame 0 → HELL
Frame 1 → OWOR
Frame 2 → LD
```

So instead of sending the entire data at once:

```text
HELLOWORLD
```

we send:

```text
HELL
OWOR
LD
```

Each piece is a **frame**.

---

# 4. What is an ACK?

ACK means:

> "I successfully received this."

For example:

```text
Sender                         Receiver
   │                              │
   │──── Frame 0 ───────────────►│
   │                              │
   │◄──────── ACK 0 ─────────────│
   │                              │
```

Then:

```text
Sender                         Receiver
   │                              │
   │──── Frame 1 ───────────────►│
   │                              │
   │◄──────── ACK 1 ─────────────│
```

---

# 5. What is a timeout?

The sender cannot wait forever.

Suppose:

```text
Sender                         Receiver
   │                              │
   │──── Frame 0 ───────────────►│
   │                              │
   │                              │
   │                              │
```

No ACK comes.

Eventually:

```text
TIMEOUT
```

The sender assumes:

> "Something went wrong."

So it retransmits.

```text
Sender                         Receiver
   │                              │
   │──── Frame 0 ───────────────►│
   │                              │
   │◄──────── ACK 0 ─────────────│
```

Your programs simplify this by asking:

```text
Enter transmission time:
```

and comparing it with:

```cpp
if (time <= limit)
```

So your `limit` is acting like a simplified **timeout limit**.

---

# 6. 1-Bit Alternating Bit Protocol

Now we reach your first C++ program.

This is basically **Stop-and-Wait ARQ with a 1-bit sequence number**.

The important concept is:

```text
0
1
0
1
0
1
...
```

That's why it's called **1-bit**.

---

# 7. Why do we need a bit?

Consider this problem.

Sender sends:

```text
Frame A
```

Receiver receives it:

```text
Frame A
```

Receiver sends:

```text
ACK
```

But suppose the ACK gets lost.

Sender thinks:

> "The frame was lost."

So sender retransmits:

```text
Frame A
```

Receiver receives it again.

How does receiver know whether this is:

```text
a new Frame A
```

or:

```text
the old Frame A being retransmitted?
```

That's the problem.

We add a sequence number.

For example:

```text
Frame 0
Frame 1
Frame 0
Frame 1
...
```

Now the receiver can distinguish them.

---

# 8. Why only one bit?

We only need two values:

```text
0
1
```

So one bit is enough.

Instead of:

```text
Frame 0
Frame 1
Frame 2
Frame 3
```

we use:

```text
Bit 0
Bit 1
Bit 0
Bit 1
```

Hence:

**Alternating Bit Protocol**

---

# 9. Your 1-bit code

Your important line is:

```cpp
int bit = 0;
```

Initially:

```text
bit = 0
```

Then:

```cpp
cout << "Sending Frame " << i
     << " (Bit " << bit << ")" << endl;
```

So you might get:

```text
Sending Frame 1 (Bit 0)
Sending Frame 2 (Bit 1)
Sending Frame 3 (Bit 0)
Sending Frame 4 (Bit 1)
```

Then:

```cpp
bit = 1 - bit;
```

This is a clever way to toggle:

```text
0 → 1
1 → 0
```

For example:

```text
bit = 0

1 - 0 = 1

1 - 1 = 0
```

Therefore:

```text
0 → 1 → 0 → 1 → 0
```

---

# 10. Your timeout logic

You have:

```cpp
if (time <= limit) {
    cout << "ACK received" << endl;
}
```

Meaning:

```text
Transmission time <= timeout limit
             ↓
         successful
             ↓
         ACK received
```

Otherwise:

```cpp
else {
    cout << "TIMEOUT - Frame lost" << endl;
    cout << "Retransmitting Frame " << i << endl;
    cout << "ACK received" << endl;
}
```

Conceptually:

```text
Frame
 │
 ▼
Transmission
 │
 ├── time <= limit
 │       │
 │       ▼
 │      ACK
 │
 └── time > limit
         │
         ▼
      TIMEOUT
         │
         ▼
     Retransmit
         │
         ▼
        ACK
```

### Important limitation of your simulation

Your program **does not actually simulate a receiver**.

It simply asks you for a transmission time.

For example:

```text
Enter transmission time: 12
```

If:

```text
limit = 10
```

it says:

```text
TIMEOUT - Frame lost
Retransmitting Frame 1
ACK received
```

So this is an **educational simulation**, not a real implementation of the Alternating Bit Protocol.

---

# 11. Why is Alternating Bit also called Stop-and-Wait?

Because the sender does:

```text
SEND FRAME
     ↓
STOP
     ↓
WAIT FOR ACK
     ↓
SEND NEXT FRAME
```

For example:

```text
Frame 0
   ↓
WAIT
   ↓
ACK 0
   ↓
Frame 1
   ↓
WAIT
   ↓
ACK 1
   ↓
Frame 0
```

Only one frame is outstanding at a time.

That's why:

**Alternating Bit Protocol = Stop-and-Wait ARQ + 1-bit sequence number**

---

# 12. Go-Back-N

Now we move to your second program.

The major difference is:

> **We can send multiple frames before waiting for all ACKs.**

This is called a **sliding window protocol**.

Suppose:

```text
Frames:

0 1 2 3 4 5 6 7
```

Window size:

```text
3
```

We can send:

```text
[0 1 2]
```

instead of:

```text
0
ACK
1
ACK
2
ACK
```

Then:

```text
[3 4 5]
```

Then:

```text
[6 7]
```

This is much faster.

---

# 13. What is a window?

Imagine you have:

```text
0 1 2 3 4 5 6 7
```

Window size = 3.

Initially:

```text
[0 1 2] 3 4 5 6 7
```

After successfully processing them:

```text
0 1 2 [3 4 5] 6 7
```

Then:

```text
0 1 2 3 4 5 [6 7]
```

This is why it's called a **sliding window**.

The window moves forward.

---

# 14. Your Go-Back-N code

You calculate the number of frames:

```cpp
int n = (data.length() + size - 1) / size;
```

Suppose:

```text
data = HELLOWORLD
size = 4
```

Length = 10.

Then:

```text
(10 + 4 - 1) / 4
= 13 / 4
= 3
```

So:

```text
Number of frames = 3
```

---

# 15. The window

Your code:

```cpp
int i = 0;

while (i < n) {

    int end = i + window;

    if (end > n)
        end = n;
```

Suppose:

```text
n = 8
window = 3
```

Initially:

```text
i = 0
```

Therefore:

```text
end = 3
```

Window:

```text
0 1 2
```

Then after successful transmission:

```text
i = 3
```

Next:

```text
3 4 5
```

Then:

```text
i = 6
```

Next:

```text
6 7
```

---

# 16. What happens if Frame 1 fails?

This is the most important part of Go-Back-N.

Suppose:

```text
Window:

[0 1 2 3]
```

Sender sends:

```text
Frame 0 ✓
Frame 1 ✗
Frame 2 ?
Frame 3 ?
```

In Go-Back-N, if Frame 1 fails:

> We go back to Frame 1 and retransmit Frame 1 **and all subsequent frames in that window**.

Hence:

**Go-Back-N**

Example:

```text
0 ✓
1 ✗
2 ?
3 ?
```

Then:

```text
RETRANSMIT:

1
2
3
```

---

# 17. Your code for Go-Back-N

You have:

```cpp
else {
    cout << "TIMEOUT - Frame " << j << " lost" << endl;

    cout << "Go-Back-N: Retransmitting from Frame "
         << j << endl;

    i = j;
    break;
}
```

The important line:

```cpp
i = j;
```

Suppose:

```text
i = 0
j = 1
```

Frame 1 fails.

You set:

```text
i = 1
```

Then the outer loop starts again from Frame 1.

So it retransmits:

```text
1
2
3
...
```

That's the idea behind Go-Back-N.

---

# 18. Example of Go-Back-N

Suppose:

```text
Data = ABCDEFGHIJ
Frame size = 1
Window = 4
```

Frames:

```text
0 1 2 3 4 5 6 7 8 9
```

First window:

```text
[0 1 2 3]
```

Suppose:

```text
Frame 0 → successful
Frame 1 → successful
Frame 2 → TIMEOUT
```

Then:

```text
0 ✓
1 ✓
2 ✗
3 ?
```

Go-Back-N says:

```text
Retransmit 2
Retransmit 3
```

Then continue.

---

# 19. Selective Repeat

Now your third C++ program.

Selective Repeat is also a **sliding-window protocol**.

But it behaves differently when a frame is lost.

Suppose:

```text
[0 1 2 3]
```

and:

```text
0 ✓
1 ✓
2 ✗
3 ✓
```

Go-Back-N:

```text
Retransmit:
2
3
```

Selective Repeat:

```text
Retransmit:
2 only
```

That's the fundamental difference.

---

# 20. Why is it called Selective Repeat?

Because you **select only the failed frame** and repeat it.

Example:

```text
Frame 0 ✓
Frame 1 ✓
Frame 2 ✗
Frame 3 ✓
```

Only:

```text
Frame 2
```

is retransmitted.

---

# 21. Your Selective Repeat code

The key part is:

```cpp
else {
    cout << "TIMEOUT - Frame "
         << j << " lost" << endl;

    cout << "Selective Repeat: "
         << "Retransmitting only Frame "
         << j << endl;

    cout << "ACK " << j << endl;
}
```

Notice what your code **doesn't do**.

It doesn't change:

```cpp
i
```

It doesn't restart the window.

It simply retransmits:

```text
Frame j
```

Therefore:

```text
Frame 0 ✓
Frame 1 ✓
Frame 2 ✗
Frame 3 ✓

Retransmit → Frame 2
```

---

# 22. Go-Back-N vs Selective Repeat

This is extremely important for exams.

Suppose window:

```text
[0 1 2 3]
```

and Frame 1 is lost:

```text
0 ✓
1 ✗
2 ✓
3 ✓
```

### Go-Back-N

```text
Retransmit:

1
2
3
```

### Selective Repeat

```text
Retransmit:

1 only
```

So:

|Feature|Go-Back-N|Selective Repeat|
|---|---|---|
|Multiple frames|Yes|Yes|
|Window|Yes|Yes|
|Lost frame|Retransmit failed + following|Retransmit failed only|
|Efficiency|Lower when errors occur|Higher|
|Receiver complexity|Lower|Higher|
|Out-of-order frames|Generally discarded|Can be buffered|
|Retransmission|More|Less|

---

# 23. Why is Selective Repeat more efficient?

Suppose you send:

```text
100 frames
```

and Frame 50 is lost.

With Go-Back-N, you might need:

```text
50
51
52
53
...
```

again.

If the window contains many frames, that's a lot of unnecessary retransmission.

Selective Repeat says:

```text
Only Frame 50 was lost.

Send Frame 50 again.
```

Much more efficient.

---

# 24. But why isn't everyone using Selective Repeat?

Because it's more complicated.

The receiver may need to remember frames that arrive out of order.

Example:

```text
0 ✓
1 ✗
2 ✓
3 ✓
```

The receiver can store:

```text
2
3
```

while waiting for:

```text
1
```

Then when 1 arrives:

```text
1 arrives
 ↓
0 1 2 3
 ↓
deliver in order
```

That requires more memory and more logic.

---

# 25. Now: what exactly is your Java Client–Server?

This is a completely different type of program.

Your Java programs implement:

**TCP client-server communication using sockets.**

You have:

```text
ClientTCP.java
```

and:

```text
ServerTCP.java
```

They communicate through:

```text
TCP
```

---

# 26. What is a client?

A **client** is a program that initiates a connection to another program.

Examples:

```text
Web browser → Web server
WhatsApp → WhatsApp server
SSH client → SSH server
```

Your:

```text
ClientTCP.java
```

is the client.

---

# 27. What is a server?

A **server** waits for incoming connections.

Your:

```text
ServerTCP.java
```

is the server.

Conceptually:

```text
             Network
                │
       ┌────────┴────────┐
       │                 │
    CLIENT             SERVER
       │                 │
       │──── connect ───►│
       │                 │
       │◄──── data ─────►│
```

---

# 28. What is a socket?

A **socket** is an endpoint for network communication.

Think of it like a telephone.

Server:

```text
"Here is my phone number."
```

Client:

```text
"I want to call that number."
```

In networking, the equivalent is approximately:

```text
IP address + port
```

Your server uses:

```java
ServerSocket ss = new ServerSocket(3333);
```

So it listens on:

```text
Port 3333
```

---

# 29. What is the IP address in your code?

Your client has:

```java
Socket s = new Socket("10.20.19.47", 3333);
```

This means:

> Connect to the computer having IP address `10.20.19.47` on port `3333`.

So:

```text
IP = 10.20.19.47
Port = 3333
```

Together:

```text
10.20.19.47:3333
```

---

# 30. What is a port?

An IP address identifies a machine/interface.

A port identifies a particular network service/application endpoint on that machine.

For example:

```text
Computer
192.168.1.10
    │
    ├── port 22   → SSH
    ├── port 80   → HTTP
    ├── port 443  → HTTPS
    └── port 3333 → Your Java server
```

So your Java server says:

```java
new ServerSocket(3333);
```

meaning:

> "Listen for TCP connections on port 3333."

---

# 31. How your server works

Your first important line:

```java
ServerSocket ss = new ServerSocket(3333);
```

This creates a server socket.

Then:

```java
Socket s = ss.accept();
```

This is VERY important.

`accept()` waits until a client connects.

So:

```text
Server starts
      ↓
Listen on port 3333
      ↓
accept()
      ↓
WAIT...
      ↓
Client connects
      ↓
accept() returns Socket
```

---

# 32. How your client works

Your client executes:

```java
Socket s = new Socket("10.20.19.47",3333);
```

This means:

```text
Client
   │
   │ TCP connection request
   ▼
10.20.19.47:3333
   │
   ▼
Server
```

If the server is listening:

```text
Connection established
```

Now both programs have a socket.

---

# 33. What are DataInputStream and DataOutputStream?

Your client:

```java
DataInputStream din =
    new DataInputStream(s.getInputStream());

DataOutputStream dout =
    new DataOutputStream(s.getOutputStream());
```

Think:

```text
Socket
 │
 ├── InputStream  → receive data
 │
 └── OutputStream → send data
```

So:

```java
dout
```

is used to **send**.

And:

```java
din
```

is used to **receive**.

---

# 34. What does writeUTF do?

Your client does:

```java
dout.writeUTF(str);
```

Suppose you type:

```text
Hello
```

Then:

```java
writeUTF("Hello")
```

sends the string through the socket.

Server receives it using:

```java
str = din.readUTF();
```

So:

```text
CLIENT                          SERVER

"Hello"
   │
   │ writeUTF()
   │
   ├──────────────────────────►
   │                            readUTF()
   │                            ↓
   │                         "Hello"
```

---

# 35. Then the server responds

Your server:

```java
System.out.println("client says: " + str);
```

prints:

```text
client says: Hello
```

Then:

```java
str2 = br.readLine();
```

The server operator types a response.

For example:

```text
Hi client
```

Then:

```java
dout.writeUTF(str2);
```

sends:

```text
Hi client
```

back.

Client does:

```java
str2 = din.readUTF();
```

and prints:

```text
Server says: Hi client
```

---

# 36. Your Java program is basically a chat

It works like:

```text
CLIENT                         SERVER

Type: Hello
     │
     ├──────────────►          client says: Hello
     │
     │                         Type: Hi
     │◄───────────────         Server says: Hi
     │
Type: How are you?
     │
     ├──────────────►          client says: How are you?
     │
     │                         Type: Good
     │◄───────────────         Server says: Good
```

It's essentially a very simple **two-way TCP text communication program**.

---

# 37. What does `stop` do?

Client:

```java
while(!str.equals("stop")){
```

This means:

```text
while str is NOT "stop"
```

If you type:

```text
stop
```

the loop condition becomes false after that iteration.

So the client eventually exits.

The server has:

```java
while(!str.equals("stop")){
```

too.

Therefore both are designed to stop when:

```text
stop
```

is sent.

---

# 38. TCP itself

Now this is where your Java program differs from the C++ ARQ simulations.

Your Java program uses:

**TCP — Transmission Control Protocol**

TCP provides reliable communication.

It handles things such as:

- sequencing
    
- acknowledgements
    
- retransmission
    
- flow control
    
- congestion control
    
- ordering
    
- duplicate handling
    

So TCP is doing a lot of reliability work internally.

Your Java code doesn't manually implement Go-Back-N or Selective Repeat.

The operating system's TCP stack handles TCP's reliability mechanisms.

---

# 39. Very important distinction

Your C++ programs are **simulations of protocols**.

Your Java programs are **actual network communication**.

Compare:

### C++ 1-bit

```text
You enter:
transmission time

Program decides:
ACK / TIMEOUT
```

No actual network transmission occurs.

### C++ Go-Back-N

```text
You enter:
time

Program simulates:
ACK / TIMEOUT / retransmission
```

Again, no actual network transmission.

### C++ Selective Repeat

Same:

```text
Simulation
```

### Java TCP

Actually:

```text
Computer A
     │
     │ TCP
     │
     ▼
Computer B
```

Real packets travel through the network.

---

# 40. Relationship between all four

Think of your syllabus like this:

```text
                    NETWORK COMMUNICATION
                           │
                           ▼
                    Data transmission
                           │
                  ┌────────┴────────┐
                  │                 │
             Reliability        Applications
                  │                 │
                 ARQ               TCP
                  │                 │
       ┌──────────┼──────────┐      │
       │          │          │      │
   1-bit ABP   Go-Back-N  Selective │
       │          │          │      │
   Stop-Wait   Sliding     Sliding  │
               Window      Window   │
                                    │
                                    ▼
                              Client/Server
                                Java Socket
```

---

# 41. The most important difference: Stop-and-Wait vs Sliding Window

### Stop-and-Wait

Only one frame is sent.

```text
Frame 0
   ↓
WAIT
   ↓
ACK
   ↓
Frame 1
   ↓
WAIT
   ↓
ACK
```

Slow but simple.

---

### Sliding Window

Multiple frames can be sent.

```text
[0 1 2 3]
```

Then:

```text
[4 5 6 7]
```

Much more efficient.

---

# 42. Why does sliding window exist?

Imagine a network with a large delay.

Suppose:

```text
Frame transmission = 1 ms
Round-trip time = 100 ms
```

Stop-and-wait:

```text
Send
 ↓
wait 100 ms
 ↓
ACK
 ↓
next frame
```

The network sits idle most of the time.

Sliding window allows:

```text
Frame 0 ──►
Frame 1 ──►
Frame 2 ──►
Frame 3 ──►
Frame 4 ──►
```

while ACKs are coming back.

So the link is utilized much better.

---

# 43. Sequence numbers

Sequence numbers identify frames.

For example:

```text
Frame 0
Frame 1
Frame 2
Frame 3
```

They allow the receiver to determine:

- which frame arrived
    
- which frame is missing
    
- whether a frame is duplicated
    
- what order frames belong in
    

Your Alternating Bit Protocol uses only:

```text
0
1
```

because only two sequence states are needed.

Go-Back-N and Selective Repeat normally use a larger sequence-number space.

---

# 44. ACKs in Go-Back-N

Suppose:

```text
0 ✓
1 ✓
2 ✗
3 ✓
```

Go-Back-N generally uses cumulative acknowledgements.

The receiver effectively says:

> "I have everything up through Frame 1."

So Frame 2 needs retransmission, and subsequent frames may need retransmission depending on the protocol state.

This is why Go-Back-N can waste bandwidth.

---

# 45. ACKs in Selective Repeat

Selective Repeat typically uses individual acknowledgements.

For example:

```text
ACK 0
ACK 1
ACK 3
```

The receiver knows:

```text
0 received
1 received
2 missing
3 received
```

Therefore it only needs:

```text
Frame 2
```

again.

---

# 46. Your three programs side-by-side

### 1-bit Alternating Bit

```text
Window = 1

Send 0
 ↓
ACK
 ↓
Send 1
 ↓
ACK
 ↓
Send 0
```

### Go-Back-N

```text
Window = multiple

Send 0 1 2 3

Suppose 2 fails:

0 ✓
1 ✓
2 ✗
3 ?

Retransmit:

2 3
```

### Selective Repeat

```text
Window = multiple

Send 0 1 2 3

Suppose 2 fails:

0 ✓
1 ✓
2 ✗
3 ✓

Retransmit:

2 only
```

---

# 47. The easiest way to remember them

### 1-bit

**"One frame at a time."**

```text
SEND → WAIT → ACK → SEND
```

### Go-Back-N

**"Error? Go back and resend from there."**

```text
0 1 X 3
    ↓
    1 2 3 again
```

### Selective Repeat

**"Error? Select only that frame."**

```text
0 1 X 3
    ↓
    2 again
```

---

# 48. One major issue with your Go-Back-N code

Your educational code is simplifying the actual protocol.

This section:

```cpp
if (time <= limit) {
    cout << "ACK " << j << endl;
}
```

assumes an ACK immediately arrives if transmission time is below the limit.

Real Go-Back-N is more complicated.

A real implementation would involve:

- sender window
    
- receiver window
    
- sequence numbers
    
- ACK numbers
    
- timers
    
- retransmission
    
- cumulative ACKs
    
- packet loss
    
- possibly out-of-order packets
    

Your code is designed to **demonstrate the basic idea**, not implement the full protocol.

Same applies to your Selective Repeat program.

---

# 49. Another important issue in your Selective Repeat code

Your code says:

```cpp
cout << "Selective Repeat: "
     << "Retransmitting only Frame "
     << j << endl;

cout << "ACK " << j << endl;
```

But it doesn't actually perform a second transmission.

It's essentially saying:

```text
Frame lost
 ↓
pretend retransmission happened
 ↓
pretend ACK arrived
```

A full simulation would actually have to represent that retransmission.

So don't describe this in an exam as:

> "This is a complete implementation of Selective Repeat."

Better:

> **"This program simulates the basic operation of Selective Repeat ARQ."**

---

# 50. And your first program is also a simulation

Same thing.

This:

```cpp
cout << "TIMEOUT - Frame lost"
```

doesn't mean an actual packet was lost.

You manually entered a time greater than the limit.

So:

```text
time > limit
```

is being used to **simulate timeout/loss**.

---

# 51. Now understand Client vs Server from zero

Imagine two computers:

```text
Computer A                     Computer B
──────────                     ──────────

Client                         Server
  │                               │
  │                               │
  │──── connection request ──────►│
  │                               │
  │◄──── connection accepted ─────│
  │                               │
  │──── Hello ───────────────────►│
  │                               │
  │◄──── Hi ──────────────────────│
```

The server must start first.

Why?

Because the client needs something to connect to.

---

# 52. Correct execution order

First run:

```text
ServerTCP
```

It reaches:

```java
ss.accept();
```

and waits.

Then run:

```text
ClientTCP
```

Client executes:

```java
new Socket("10.20.19.47",3333);
```

Connection occurs.

Then communication starts.

---

# 53. What happens inside TCP?

Very simplified:

```text
Client                         Server

     SYN ────────────────────►
         ◄──────────────── SYN-ACK
     ACK ────────────────────►

       TCP connection established
```

This is the famous **TCP three-way handshake**.

Then your Java application sends data.

---

# 54. Your complete architecture

Your Java application looks like:

```text
                APPLICATION
                    │
              Java program
                    │
                    ▼
                 Socket
                    │
                    ▼
                   TCP
                    │
                    ▼
                   IP
                    │
                    ▼
              Network / Wi-Fi
                    │
                    ▼
                   IP
                    │
                    ▼
                   TCP
                    │
                    ▼
                 Socket
                    │
                    ▼
              Java program
```

The Java program doesn't directly control TCP packet retransmissions.

The OS networking stack does that.

---

# 55. Where do your ARQ protocols fit?

Conceptually, reliability can exist at different layers.

Your C++ programs are demonstrating **data-link-layer ARQ concepts**.

TCP is a **transport-layer protocol** that also provides reliable delivery.

So:

```text
Application
     │
     ▼
    TCP
     │
     ▼
    IP
     │
     ▼
Data Link
     │
     ▼
Physical
```

TCP provides its own reliable byte-stream behavior, while lower layers may have their own mechanisms too.

---

# 56. Very important: TCP is NOT the same as Go-Back-N

Don't answer:

> "TCP is Go-Back-N."

That's incorrect.

TCP has:

- sequence numbers
    
- acknowledgements
    
- retransmissions
    
- sliding windows
    

so it may **look conceptually similar** to ARQ protocols.

But TCP has its own mechanisms and congestion-control behavior; it isn't simply your Go-Back-N implementation.

---

# 57. Difference between your Java client and your C++ protocols

||1-bit ABP|Go-Back-N|Selective Repeat|Java TCP|
|---|---|---|---|---|
|Language|C++|C++|C++|Java|
|Real network?|❌|❌|❌|✅|
|Main concept|Stop-and-wait|Sliding window|Sliding window|Client/server communication|
|ACK|Simulated|Simulated|Simulated|TCP handles it|
|Timeout|Simulated|Simulated|Simulated|TCP handles it|
|Retransmission|Simulated|Simulated|Simulated|TCP handles it|
|Window|1|Multiple|Multiple|TCP receive/congestion windows|
|Purpose|Learn ARQ|Learn ARQ|Learn ARQ|Network programming|

---

# 58. One simple real-world analogy

Imagine you're sending boxes through a courier.

### 1-bit / Stop-and-Wait

You send:

```text
Box 0
```

Wait until courier says:

```text
Received.
```

Then:

```text
Box 1
```

Very safe, but slow.

---

### Go-Back-N

You are allowed to send 4 boxes:

```text
Box 0
Box 1
Box 2
Box 3
```

Suppose Box 2 gets lost.

You say:

```text
Send Box 2 again
Send Box 3 again
```

Even if Box 3 was actually received.

---

### Selective Repeat

Box 2 gets lost:

```text
Box 0 ✓
Box 1 ✓
Box 2 ✗
Box 3 ✓
```

You say:

```text
Send Box 2 again.
```

Much more efficient.

---

### TCP Client/Server

Now imagine you don't care about the boxes, ACKs, retransmission, etc.

You simply say:

```text
Client:
"Send this message."

TCP:
"I'll take care of reliable delivery."
```

Your Java application uses:

```java
Socket
```

and TCP handles the underlying reliable transport.

---

# 59. What you should know for an exam/viva

If your teacher asks:

### "What is 1-bit protocol?"

Answer:

> **The Alternating Bit Protocol is a Stop-and-Wait ARQ protocol that uses a 1-bit sequence number, alternating between 0 and 1, to distinguish new frames from retransmitted duplicate frames.**

---

### "What is Go-Back-N?"

> **Go-Back-N is a sliding-window ARQ protocol where multiple frames can be transmitted without waiting for individual ACKs. If a frame is lost or times out, that frame and subsequent outstanding frames are retransmitted.**

---

### "What is Selective Repeat?"

> **Selective Repeat is a sliding-window ARQ protocol where only the lost or damaged frame is retransmitted, while correctly received frames can be retained by the receiver.**

---

### "Difference between GBN and SR?"

> **Go-Back-N retransmits the failed frame and subsequent frames, whereas Selective Repeat retransmits only the failed frame.**

---

### "What is a client?"

> **A client is a program that initiates a connection to a server to request or exchange services/data.**

---

### "What is a server?"

> **A server is a program that listens for incoming client connections and provides a service or exchanges data with clients.**

---

### "What is a socket?"

> **A socket is a software endpoint used by applications for network communication.**

---

### "What is a port?"

> **A port is a logical number used to identify a particular network service/application endpoint on a host.**

---

### "What does `ServerSocket(3333)` mean?"

```java
ServerSocket ss = new ServerSocket(3333);
```

Answer:

> **It creates a server socket that listens for TCP connections on port 3333.**

---

### "What does `accept()` do?"

```java
Socket s = ss.accept();
```

Answer:

> **It waits for an incoming client connection and returns a Socket representing the established connection.**

---

### "What does this mean?"

```java
new Socket("10.20.19.47",3333);
```

Answer:

> **It creates a TCP socket and attempts to connect to the host at IP address `10.20.19.47` on port `3333`.**

---

### "What does `writeUTF()` do?"

```java
dout.writeUTF(str);
```

> **It writes a UTF-encoded string to the output stream so that it can be received by the other side using `readUTF()`.**

---

# 60. The entire thing in one picture

This is probably the most useful mental model to remember:

```text
                     RELIABLE COMMUNICATION
                             │
              ┌──────────────┴──────────────┐
              │                             │
          ARQ CONCEPTS                  TCP PROGRAM
              │                             │
      ┌───────┴────────┐              ┌─────┴─────┐
      │                │              │           │
 Stop-and-Wait    Sliding Window    Client      Server
      │                │              │           │
      │          ┌─────┴─────┐        │           │
      │          │           │        │           │
      │      Go-Back-N   Selective R  │           │
      │          │           │        │           │
      ▼          ▼           ▼        ▼           ▼
   1-bit       resend      resend   Socket     ServerSocket
   0/1         from error  only     connect    accept
      │
      ▼
 SEND → WAIT → ACK
```

And the **single most important distinction** is:

```text
1-bit ABP
     ↓
ONE frame at a time

Go-Back-N
     ↓
MANY frames
     ↓
error → resend from error onward

Selective Repeat
     ↓
MANY frames
     ↓
error → resend ONLY that frame

Java TCP Client/Server
     ↓
ACTUAL network communication
     ↓
Socket ↔ TCP ↔ Socket
```

If you're studying these for a **CN lab/viva**, the next thing you should learn is the **actual frame-by-frame execution of all 3 protocols with diagrams**, including **sequence numbers, sender window, receiver window, ACK numbers, timeout, and exactly what happens when Frame 2 is lost**. That makes the differences between 1-bit, Go-Back-N, and Selective Repeat much easier to remember.




SUPERHIT
BUS300
	CASH300

	PRIMODAY


> [!summary] Tools Overview
> 
>   
> 
> - **`ping`:** Uses ICMP Echo Request/Reply messages to verify host reachability, measure round-trip time (RTT), and detect packet loss.
>     
>       
>     
> - **`traceroute` / `tracert`:** Maps the router-by-router path to a target host by incrementally increasing the IP header's **Time To Live (TTL)** value and listening for `ICMP Time Exceeded` responses.
>     
>       
>     

## Tool & Protocol Comparison

|**Feature**|**ping**|**traceroute (Linux)**|**tracert (Windows)**|**tcptraceroute**|
|---|---|---|---|---|
|**Primary Goal**|Host reachability & RTT|Path/hop discovery|Path/hop discovery|Hop discovery via TCP|
|**Default Protocol**|ICMP Echo Request|UDP (ports 33434+)|ICMP Echo Request|TCP SYN (e.g., Port 80/443)|
|**Firewall Evasion**|Poor (frequently blocked)|Moderate (`-I` or `-T` flags)|Poor (frequently blocked)|High (bypasses ICMP blocks)|
|**Hop Mapping**|No (single host test)|Yes (via TTL increments)|Yes (via TTL increments)|Yes (via TTL increments)|

## How Traceroute Works (TTL Mechanism)

1. **TTL = 1:** The source sends a probe with `TTL=1`. The first router decrements TTL to `0`, drops the packet, and returns an `ICMP Type 11` (**Time Exceeded**) message.
    
      
    
2. **TTL = 2:** The source sends a probe with `TTL=2`. The second router drops it and returns `ICMP Time Exceeded`.
    
      
    
3. **Destination Reached:** The probe reaches the target IP. The target responds with `ICMP Echo Reply` (or `Port Unreachable` if using UDP), completing the path trace.
    
      
    



```
Source                       Router 1 (TTL=1 -> 0)               Router 2 (TTL=2 -> 1 -> 0)               Target
  | --- Probe (TTL=1) ---------> | (Drops & returns ICMP 11)                                                |
  | <-- ICMP Time Exceeded ------ |                                                                          |
  |                                                                                                          |
  | --- Probe (TTL=2) ---------------------------------------------> | (Drops & returns ICMP 11)              |
  | <-- ICMP Time Exceeded ----------------------------------------- |                                        |
  |                                                                                                          |
  | --- Probe (TTL=3) -------------------------------------------------------------------------------------> |
  | <-- ICMP Echo Reply / Port Unreachable ----------------------------------------------------------------- |
```

## CLI Usage & Syntax

### 1. `ping` Commands



```Bash
# Basic reachability test (Linux ping runs indefinitely; Windows defaults to 4 packets)
ping 1.1.1.1

# Limit ping count (Linux)
ping -c 4 tryhackme.com

# Change ping interval in seconds (sudo required for <0.2s)
sudo ping -i 0.2 10.10.10.1

# Customize packet payload size in bytes
ping -s 1000 tryhackme.com
```

### 2. `traceroute` & `tracert` Commands



```Bash
# Standard Linux traceroute (UDP probes)
traceroute tryhackme.com

# Force ICMP Echo probes on Linux (behaves like Windows tracert)
traceroute -I tryhackme.com

# Force TCP SYN probes (bypasses firewalls blocking ICMP/UDP)
traceroute -T -p 443 tryhackme.com

# Windows tracert command
tracert tryhackme.com

# Disable reverse DNS lookup for faster traceroute execution
traceroute -n tryhackme.com
tracert -d tryhackme.com
```

### 3. Modern Hybrid: `mtr` (My TraceRoute)

Combines `ping` and `traceroute` into a continuous, real-time diagnostic dashboard showing live packet loss percentages and latency statistics for every hop.

  



```Bash
# Continuous real-time interactive trace
mtr tryhackme.com

# Generate report mode output (sends 10 cycles and exits)
mtr --report --report-cycles 10 tryhackme.com
```

## Security & Reconnaissance Insights

> [!tip] Analysis & Troubleshooting Focus
> 
>   
> 
> 1. **Asterisks (`* * *`) in Traceroute:** Indicates a hop firewall filtering ICMP/UDP probes or suppressing ICMP Time Exceeded responses. Switch to TCP traceroute (`traceroute -T -p 80/443`) to probe open web ports.
>     
>       
>     
> 2. **Network Filtering Diagnostics:** If `ping` fails but web services (HTTP/HTTPS) respond, ICMP is blocked at the perimeter firewall.
>     
>       
>     
> 3. **Latency Spikes:** Identify congested network segments by finding sharp RTT jumps between consecutive hops.
>     
>       
>     
> 4. **Asymmetric Routing:** Inbound and outbound traffic often follow different path topologies, resulting in unequal hop latency readouts.
>
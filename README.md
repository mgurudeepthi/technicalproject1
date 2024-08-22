# Monitoring Dashboard Script


## Description
 
 This script provides real-time monitoring of various system resources for a proxy server. It can display system metrics and allow users to call specific parts of the dashboard individually.


 ## Features

 1. **Top 10 Most Used Applications**: Shows the top applications by CPU and memory usage..
 2. **Network Monitoring**: Displays concurrent connections, packet drops, and network usage in MB.
 3. **Disk Usage**: Shows disk space usage by partitions and highlights those over 80% usage.
 4. **System Load**: Provides load average and CPU usage breakdown.
 5. **Memory Usage**: Displays total, used, free memory, and swap usage.
 6. **Process Monitoring**: Shows the number of active processes and top 5 processes by CPU and memory usage.
 7. **Service Monitoring**: Monitors the status of essential services like sshd, nginx/Apache, iptables.
 8. **Custom Dashboard**: Provides command-line options to view specific parts of the dashboard.



 ## Usage


 Make the script executable:
 

 To use the script, run it with one of the above switches:


 ### Example
 ```bash
 ./monitoring_dashboard.sh memory
 ./monitoring_dashboard.sh network


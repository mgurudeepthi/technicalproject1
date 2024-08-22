#!/bin/bash
# Function to display the top 10 most used applications by CPU and Memory
  display_top_apps() {
    echo "Top 10 Applications by CPU Usage:"
     ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11

     echo -e "\nTop 10 Applications by Memory Usage:"
      ps -eo pid,comm,%mem --sort=-%mem | head -n 11
		}

# Function to display network monitoring
   display_network_stats() {
      echo "Network Statistics:"
      echo "Concurrent Connections:"
      netstat -an | grep ESTABLISHED | wc -l



      echo -e "\nPacket Drops:"
      netstat -i | awk '/^e/ {print $1, $3, $4}'


      echo -e "\nNetwork Usage (MB):"
      ifstat -i eth0 1 1 | awk 'NR==3 {print "Received: " $1 " MB, Transmitted: " $2 " MB"}'

   }
			   
			   
# Function to display disk usage
     display_disk_usage() {
echo "Disk Usage:"
df -h | awk '$5 > 80 {print $1, $5}' # Highlight partitions using more than 80% of the space
df -h
}


# Function to display system load and CPU usage
display_system_load() {
echo "System Load Average:"
uptime

echo -e "\nCPU Usage Breakdown:"
mpstat

}


# Function to display memory usage
  display_memory_usage() {
     echo "Memory Usage:"
     free -h


     echo -e "\nSwap Memory Usage:"

     # Check if 'swapon' command exists
    if command -v swapon &> /dev/null; then
	swapon --show

	else
	   # Alternative method to display swap usage if 'swapon' is not available
	if [ -f /proc/meminfo ]; then
	   awk '/SwapTotal:/ {total=$2} /SwapFree:/ {free=$2} END {used=total-free; printf "Total: %.2f MB\nUsed: %.2f MB\nFree: %.2f MB\n", total/1024, used/1024, free/1024}' /proc/meminfo
	else
	 
	  echo "Error: Unable to access /proc/meminfo. Check system configuration."

	fi
    fi
  }


# Function to display monitoring process
display_process_info() {
echo "Number of Active Processes:"
ps aux | wc -l

echo -e "\nTop 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6


echo -e "\nTop 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

}


# Function to display service monitoring status
display_service_status() {
echo "Service Status:"
for service in sshd nginx apache2 iptables; do
systemctl is-active --quiet $service && echo "$service is running" || echo "$service is not running"
    done

    }
# Function to display the custom dashboard
 display_dashboard() {
 case $1 in
 cpu)
    display_top_apps
    display_system_load
    ;;
 memory)
    display_memory_usage
    ;;
 network)
    display_network_stats
    ;;
 disk)
    display_disk_usage
    ;;
 process)
    display_process_info
    ;;
 services)
    display_service_status
    ;;
 all)
    display_top_apps
    display_network_stats
    display_disk_usage
    display_system_load
    display_memory_usage
    display_process_info
    display_service_status
    ;;
 *)
    echo "Invalid option. Available options: cpu, memory, network, disk, process, services, all"
    ;;
 

 esac

}


# Check command line arguments

  if [ $# -eq 0 ]; then
        echo "No arguments provided. Displaying full dashboard."
        display_dashboard all
  else
     display_dashboard $1

   fi
   

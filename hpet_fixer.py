import subprocess
import os

def main():
	
	has_hpet = False	

	detect = subprocess.Popen("cat /sys/devices/system/clocksource/clocksource0/available_clocksource", shell=True, stdout=subprocess.PIPE, )
	replace = {"b": "", "\\n": "", "\\n": "", "\'": ""}
	clocksource=str(detect.communicate()[0])
	for i, j in replace.items():
		clocksource = clocksource.replace(i, j)
	clocksource = list(clocksource.split())
	
	if "hpet" in clocksource:
		has_hpet=True
	else:
		print("System doesn't have a HPET timer! Exiting now")
		exit();
	
	
		
	# Set HPET as default clocksource
	os.system("echo hpet > /sys/devices/system/clocksource/clocksource0/current_clocksource")
		
	# Increase RTC and HPET command
	os.system("echo 2048 > /sys/class/rtc/rtc0/max_user_freq && echo 2048 > /proc/sys/dev/hpet/max-user-freq")

	print("HPET properties sucessfully setted")
 			
if __name__ == "__main__":
	main()

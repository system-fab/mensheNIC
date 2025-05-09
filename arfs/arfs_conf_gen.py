import sys
from binascii import hexlify
from scapy.all import *
from ctypes import *

def big_endian(hex_value):
     return_val = ""
     i=0
     while i+2 < len(hex_value):
        return_val = hex_value[i:i+2] + return_val
        i += 2
     return_val = hex_value[i:] + return_val
     if len(hex_value) != len(return_val):
     	raise Exception("Error during change in endianness!")
     return return_val

iface = "ens7f0"
dst_ip = "192.168.1.2"
command = 1
entry = 1
vlan_id = 1
if len(sys.argv)<6:
    raise Exception("Not enough arguments for the packet generation!\nNeeded: interface, destinetion IP, command, entry, vlan ID")
iface = sys.argv[1]
dst_ip = sys.argv[2]
command = int(sys.argv[3])
entry = int(sys.argv[4])
vlan_id = int(sys.argv[5])

sys.stdout = open("arfs_pkts.txt",'w')
print("from scapy.all import *")
print("conf.iface = \'"+iface+"\'")

data = '%0*x' % (4, command)
data += '%0*x' % (4, entry)
data = big_endian(data)
print("data = \""+data+"\"")
print("sendp(Dot1Q(vlan="+str(vlan_id)+")/IP(dst=\""+dst_ip+"\")/UDP(dport=0xf2f2)/bytes.fromhex(data))")

print()



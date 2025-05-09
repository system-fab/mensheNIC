import sys
from binascii import hexlify
from scapy.all import *
from ctypes import *


def convert_bstr_to_hstr(bstr):
    hstr = '%0*x' % ((len(bstr) + 3) // 4, int(bstr, 2))
    return hstr

def gen_ctrl_pkt(module_info, data):
    raw_load = bytes(4) + bytes.fromhex(module_info)
    raw_load = raw_load + bytes(15)      # padding + cookie
    raw_load = raw_load + bytes.fromhex(data)
    return raw_load

def big_endian(hex_value):
     return_val = bytearray(0)
     i=0
     while i+2 < len(hex_value):
        return_val[0:0] = hex_value[i:i+2]
        i += 2
     return_val[0:0] = hex_value[i:]
     if len(hex_value) != len(return_val):
     	raise Exception("Error during change in endianness!")
     return return_val

def print_pkt(pkt):
    pkt = hexlify(bytes(pkt)).decode()
    print("conf_pkt = \""+pkt+"\"")
    print("sendp(Ether(dst=\"00:0a:35:28:69:0a\")/IP(dst=\"192.168.40.123\")/UDP(dport=0xf1f2)/bytes.fromhex(conf_pkt))")
    return

def parse_configuration(filename):
    f = open(filename, "r")
    line = f.readline()
    while line:
        strs = line.strip().split(" ")
        #print ("process", strs[0])
        if (strs[0] == "Parser"):
            data = f.readline().strip()
            pkt = gen_ctrl_pkt(convert_bstr_to_hstr(strs[1]), convert_bstr_to_hstr(data))
            print_pkt(pkt)
            pkt = gen_ctrl_pkt(convert_bstr_to_hstr(strs[2]), convert_bstr_to_hstr(data))
            print_pkt(pkt)
        else:
            data = f.readline().strip()
            pkt = gen_ctrl_pkt(convert_bstr_to_hstr(strs[1]), convert_bstr_to_hstr(data))
            print_pkt(pkt)
        line = f.readline()
    return



programs_num = 1
if len(sys.argv)>1:
	programs_num = int(sys.argv[1])

sys.stdout = open("conf_packets.txt",'w')
print("from scapy.all import *")
print("conf.iface = \'ens7f0\'")


# CONFIGURATION PACKETS
for i in range(1, programs_num+1):
	parse_configuration("p4_generated/conf" + str(i) + ".txt")
#output_to_file("p4_generated/confsys.txt")
parse_configuration("p4_generated/stateconf.txt")
print()



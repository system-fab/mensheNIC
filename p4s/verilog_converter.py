import sys
from binascii import hexlify
from scapy.all import *
from ctypes import *


def convert_bstr_to_hstr(bstr):
    hstr = '%0*x' % ((len(bstr) + 3) // 4, int(bstr, 2))
    return hstr

def gen_ctrl_pkt(module_info, data):
    raw_load = bytes.fromhex(module_info)
    raw_load = raw_load + bytes(15)      # padding + cookie
    raw_load = raw_load + bytes.fromhex(data)
    pkt = Ether(src='00:01:02:03:04:05', dst='06:07:08:09:0a:0b')/Dot1Q(vlan=0xf) \
                /IP(src='111.111.111.111', dst='222.222.222.222')/UDP(sport=1234, dport=0xf1f2) \
                /Raw(load=raw_load)
    return pkt

def parse_configuration(filename):
    pkts = []
    f = open(filename, "r")
    line = f.readline()
    while line:
        strs = line.strip().split(" ")
        #print ("process", strs[0])
        if (strs[0] == "Parser"):
            data = f.readline().strip()
            pkt = gen_ctrl_pkt(convert_bstr_to_hstr(strs[1]), convert_bstr_to_hstr(data))
            pkts.append(pkt)
            pkt.tuser_sport = 1
            pkt = gen_ctrl_pkt(convert_bstr_to_hstr(strs[2]), convert_bstr_to_hstr(data))
            pkts.append(pkt)
            pkt.tuser_sport = 1
        else:
            data = f.readline().strip()
            pkt = gen_ctrl_pkt(convert_bstr_to_hstr(strs[1]), convert_bstr_to_hstr(data))
            pkt.tuser_sport = 1
            pkts.append(pkt)
        line = f.readline()
    return pkts

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

def pad_left_string_zeros(old_string, factor):
	return ("0"*(factor-len(old_string)+(len(old_string)//factor)*factor) + old_string) if len(old_string)%factor != 0 else old_string

def output_to_file(file_name):
	parsed_file = parse_configuration(file_name)
	print("// "+file_name.split("/")[-1] + ":")
	for chunk in parsed_file:
		original_val = bytearray(hexlify(bytes(chunk)))
		#print(str(original_val)[12:-2])
		changed = big_endian(original_val)
		if len(changed)%2 != 0:
			raise Exception("Error, conversion length is odd!")
		compare_val = hexlify((int.from_bytes(chunk, "little")).to_bytes(len(chunk), "big"))
		if(compare_val != changed):
			raise Exception("Error, conversion not consistent!")
		
		data_signal = str(changed)[12:-2]
		keep_signal = convert_bstr_to_hstr("1"*(len(changed)//2))
		# PADDING
		data_signal = pad_left_string_zeros(data_signal, 128)
		keep_signal = pad_left_string_zeros(keep_signal, 16)
		
		for_range = len(data_signal)//128
		for i in range(0, for_range):
			print("s_axis_tdata <= 512\'h"+data_signal[-i*128-128:len(data_signal)-i*128]+";")
			print("s_axis_tkeep <= 64\'h"+keep_signal[-i*16-16:len(keep_signal)-i*16]+";")
			print("s_axis_tvalid <= 1\'b1;")
			if i!=for_range-1:
				print("s_axis_tlast <= 1\'b0;")
				print("#(CYCLE)")
			else:
				print("s_axis_tlast <= 1\'b1;")
				print("#CYCLE")
				print("s_axis_tvalid <= 1\'b0;")
				print("s_axis_tlast <= 1\'b0;")
				print("#(30*CYCLE)")
	print("\n")




sys.stdout = open("vivado_format.txt",'w')

# CONFIGURATION PACKETS
output_to_file("p4_generated/conf1.txt")
#output_to_file("p4_generated/confsys.txt")
output_to_file("p4_generated/stateconf.txt")




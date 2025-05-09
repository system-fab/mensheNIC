#include <core.p4>
#include <fpga.p4>

/*
 * Define the headers the program will recognize
 */

/*
 * Standard ethernet header 
 */
header ethernet_t {
        bit<48> eth_dst_addr;
        bit<48> eth_src_addr;
        bit<16> eth_ethertype;
}

header vlan_t {
        bit<16> vlan_id;
        bit<16> vlan_ethertype;
}

header ipv4_t {
        bit<4>  version;
        bit<4>  ihl;
        bit<8>  diffserv;
        bit<16> total_len;
        bit<16> identification;
        bit<3>  flags;
        bit<13> frag_offset;
        bit<8>  ttl;
        bit<8>  protocol;
        bit<16> ip_checksum;
        bit<32> ip_src_addr;
        bit<32> ip_dst_addr;
}

header udp_t {
        bit<16> udp_src_port;
        bit<16> udp_dst_port;
        bit<16> hdr_length;
        bit<16> udp_checksum;
}

header p4calc_t {
        bit<16>  op;
        bit<32> operand_a;
        bit<32> operand_b;
        bit<32> res;
}

/*
 * All headers, used in the program needs to be assembed into a single struct.
 * We only need to declare the type, but there is no need to instantiate it,
 * because it is done "by the architecture", i.e. outside of P4 functions
 */
struct headers {
        ethernet_t      ethernet;
        vlan_t          vlan;
        ipv4_t          ipv4;
        udp_t           udp;
        p4calc_t        p4calc;
}

/*
 * All metadata, globally used in the program, also  needs to be assembed 
 * into a single struct. As in the case of the headers, we only need to 
 * declare the type, but there is no need to instantiate it,
 * because it is done "by the architecture", i.e. outside of P4 functions
 */
 
struct metadata {
        bit<128>  nothing;
        bit<1>    discard;
        bit<127>  still_nothing;
}

/*************************************************************************
 ***********************  P A R S E R  ***********************************
 *************************************************************************/
parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

        state start {
                packet.extract(hdr.ethernet);
                transition parse_vlan;
        }

        state parse_vlan {
                packet.extract(hdr.vlan);
                transition parse_ip;
        }

        state parse_ip {
                packet.extract(hdr.ipv4);
                transition parse_udp;
        }

        state parse_udp {
                packet.extract(hdr.udp);
                transition parse_custom;
        }
    
        state parse_custom {
                packet.extract(hdr.p4calc);
                transition accept;
        }
}

/*************************************************************************
 **************  I N G R E S S   P R O C E S S I N G   *******************
 *************************************************************************/
control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    action operation_add_a() {
        hdr.p4calc.res = hdr.p4calc.res + hdr.p4calc.operand_a;
    }
    
    action operation_sub_a() {
        hdr.p4calc.res = hdr.p4calc.res - hdr.p4calc.operand_a;
    }
    
    action operation_add_b() {
        hdr.p4calc.res = hdr.p4calc.res + hdr.p4calc.operand_b;
    }
    
    action operation_sub_b() {
        hdr.p4calc.res = hdr.p4calc.res - hdr.p4calc.operand_b;
    }
    
    action nothing(){ }
    
    table first {
        key = {
            hdr.p4calc.op : exact;
        }
        actions = {
            operation_add_a;
            operation_sub_a;
                        nothing;
        }
        const default_action = nothing();
        const entries = {
            13: operation_add_a();
            26: operation_sub_a();
        }
    }
    
    table second {
            key = {
                    hdr.p4calc.res : exact;
            }
            actions = {
            operation_add_b;
            operation_sub_b;
                        nothing;
        }
        const default_action = nothing();
        const entries = {
            50: operation_add_b();
            30: operation_sub_b();
        }
    }
    
    table third {
            key = {
                    hdr.p4calc.res : exact;
            }
            actions = {
            operation_add_a;
            operation_sub_a;
                        nothing;
        }
        const default_action = nothing();
        const entries = {
            55: operation_add_a();
                 25: operation_sub_a();
        }
    }

    table fourth {
            key = {
                    hdr.p4calc.res : exact;
            }
            actions = {
            operation_add_b;
            operation_sub_b;
                        nothing;
        }
        const default_action = nothing();
        const entries = {
            65: operation_add_b();
            15        : operation_sub_b();
        }
    }

    table fifth {
            key = {
                    hdr.p4calc.res : exact;
            }
            actions = {
            operation_add_a;
            operation_sub_a;
                        nothing;
        }
        const default_action = nothing();
        const entries = {
            70: operation_add_a();
                 10: operation_sub_a();
        }
    }
            
    apply {
        first.apply();
            second.apply();
            third.apply();
            fourth.apply();
            fifth.apply();
    } 
}


/*************************************************************************
 ***********************  S W I T T C H **********************************
 *************************************************************************/

FpgaSwitch(
MyParser(),
MyIngress()
) main;

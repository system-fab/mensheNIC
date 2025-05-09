#include <stdio.h>
#include <time.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h> 
#include <arpa/inet.h>
#define SERVER_IP "192.168.40.123"
#define SERVER_PORT 49200
#define MESSAGE_LENGTH 500


int main(void){
    int socket_desc;
    struct sockaddr_in server_addr, client_addr;
    char server_message[MESSAGE_LENGTH], client_message[MESSAGE_LENGTH];
    int client_struct_length = sizeof(client_addr);
    short stop_flag = 0;
    short test_started = 0;
    int n_times = 0;
    struct timespec c_resolution, latency_start, latency_stop, latency_res;
    latency_start.tv_sec = 0; latency_start.tv_nsec = 0;
    latency_stop.tv_sec = 0;  latency_stop.tv_nsec = 0;
    latency_res.tv_sec = 0;   latency_res.tv_nsec = 0;
    
    // Clean buffers:
    memset(server_message, '\0', sizeof(server_message));
    memset(client_message, '\0', sizeof(client_message));
    
    // Create UDP socket:
    socket_desc = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    
    if(socket_desc < 0){
        printf("Error while creating socket\n");
        return -1;
    }
    //printf("Socket created successfully\n");
    
    // Set port and IP:
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(SERVER_PORT);
    server_addr.sin_addr.s_addr = inet_addr(SERVER_IP);
    
    // Bind to the set port and IP:
    if(bind(socket_desc, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0){
        printf("Couldn't bind to the port\n");
        return -1;
    }
    //printf("Done with binding\n");
    
    printf("Listening for incoming messages...\n\n");
    
    printf("starting latency test\n");
    clock_getres(CLOCK_REALTIME, &c_resolution);
    printf("Clock resolution:  %ld.%.9ld s\n", c_resolution.tv_sec, c_resolution.tv_nsec);
    while(!stop_flag)
    {
        n_times++;
        test_started = 0;
        latency_start.tv_sec = 0; latency_start.tv_nsec = 0;
        latency_stop.tv_sec = 0;  latency_stop.tv_nsec = 0;
        memset(client_message, '\0', sizeof(client_message));
        
        while(!test_started)
        {
            // Receive client's message:
            if (recvfrom(socket_desc, client_message, sizeof(client_message), 0,
                 (struct sockaddr*)&client_addr, &client_struct_length) < 0)
            {
                printf("Couldn't receive\n");
                return -1;
            }
            //printf("Received message from IP: %s and port: %i\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));
            //printf("Msg from client: %s\n", client_message);
            // Begin latency ping test
            if(strcmp(client_message, "latency test") == 0)
            {
                // Respond to client:
                strcpy(server_message, client_message);
                test_started = 1;
                if((n_times+1)%1000 == 0)
                {
                    printf("test number: %d\n", n_times+1);
                    fflush(stdout);
                }
            }
        }
        clock_gettime(CLOCK_REALTIME, &latency_start);
        
        if (sendto(socket_desc, server_message, strlen(server_message), 0,
             (struct sockaddr*)&client_addr, client_struct_length) < 0)
        {
            printf("Can't send\n");
            return -1;
        }
        // Receive client's message:
        if (recvfrom(socket_desc, client_message, sizeof(client_message), 0,
             (struct sockaddr*)&client_addr, &client_struct_length) < 0)
        {
            printf("Couldn't receive\n");
            return -1;
        }
        clock_gettime(CLOCK_REALTIME, &latency_stop);
        // Receiving latency ping test
        if(strcmp(client_message, "latency test"))
        {
            printf("latency test interrupted!\n");
            return -1;
        }
        
        // Receiving latency test correctness
        if (recvfrom(socket_desc, client_message, sizeof(client_message), 0,
             (struct sockaddr*)&client_addr, &client_struct_length) < 0)
        {
            printf("Couldn't receive\n");
            return -1;
        }
        if(strcmp(client_message, "latency test OK"))
        {
            if(strcmp(client_message, "latency test STOP"))
            {
                printf("latency test interrupted!\n");
                return -1;
            }
            else
                stop_flag = 1;
        }
        
        latency_res.tv_sec = latency_res.tv_sec + (latency_stop.tv_sec - latency_start.tv_sec);
        if(latency_stop.tv_sec != latency_start.tv_sec)
            latency_res.tv_nsec = latency_res.tv_nsec + (1000000000-latency_start.tv_nsec + latency_stop.tv_nsec);
        else
            latency_res.tv_nsec = latency_res.tv_nsec + (latency_stop.tv_nsec - latency_start.tv_nsec);
    }
    
    latency_res.tv_sec = (latency_res.tv_sec)/n_times;
    latency_res.tv_nsec = (latency_res.tv_nsec)/n_times;
    printf("Latency test:  %ld.%.9ld s\n", latency_res.tv_sec, latency_res.tv_nsec);
    // Close the socket:
    close(socket_desc);
    
    return 0;
}


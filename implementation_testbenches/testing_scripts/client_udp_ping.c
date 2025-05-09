#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h> 
#include <arpa/inet.h>
#define SERVER_IP "192.168.40.123"
#define SERVER_PORT 49200
#define MESSAGE_LENGTH 500
#define N_TESTS 10000 

int main(void){
    int socket_desc;
    struct sockaddr_in server_addr;
    char server_message[MESSAGE_LENGTH], client_message[MESSAGE_LENGTH];
    int server_struct_length = sizeof(server_addr);
    
    // Clean buffers:
    memset(server_message, '\0', sizeof(server_message));
    memset(client_message, '\0', sizeof(client_message));
    
    // Create socket:
    socket_desc = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    
    if(socket_desc < 0)
    {
        printf("Error while creating socket\n");
        return -1;
    }
    //printf("Socket created successfully\n");
    
    // Set port and IP:
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(SERVER_PORT);
    server_addr.sin_addr.s_addr = inet_addr(SERVER_IP);
    
    printf("Starting latency test\n");
    for(int i=0; i<N_TESTS; i++)
    {
        strcpy(client_message, "latency test\0");
        if((i+1)%1000 == 0)
        {
            printf("test number: %d\n", i+1);
            fflush(stdout);
        }
        
        // Send the message to server:
        if(sendto(socket_desc, client_message, strlen(client_message), 0,
             (struct sockaddr*)&server_addr, server_struct_length) < 0)
        {
            printf("Unable to send message\n");
            return -1;
        }
        
        // Receive the server's response:
        if(recvfrom(socket_desc, server_message, sizeof(server_message), 0,
             (struct sockaddr*)&server_addr, &server_struct_length) < 0)
        {
            printf("Error while receiving server's msg\n");
            return -1;
        }
        // Send the message to server:
        if(sendto(socket_desc, client_message, strlen(client_message), 0,
             (struct sockaddr*)&server_addr, server_struct_length) < 0)
        {
            printf("Unable to send message\n");
            return -1;
        }
        
        if(strcmp(server_message, "latency test") == 0)
        {
            if(i == N_TESTS-1)
                strcpy(client_message, "latency test STOP\0");
            else
                strcpy(client_message, "latency test OK\0");
        }
        else
            strcpy(client_message, "latency test KO\0");
        
        // Send the message to server:
        if(sendto(socket_desc, client_message, strlen(client_message), 0,
             (struct sockaddr*)&server_addr, server_struct_length) < 0)
        {
            printf("Unable to send message\n");
            return -1;
        }
        usleep(1000);
    }
        
    
    printf("%s\n", client_message);
    
    // Close the socket:
    close(socket_desc);
    
    return 0;
}



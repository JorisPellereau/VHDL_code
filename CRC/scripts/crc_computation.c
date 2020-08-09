#include <stdio.h>
#include <stdlib.h>

int crc_serial(int *i_data, int *crc_serial, int *crc);
int crc_parallel(int N, int M, int *i_data, int *i_crc_serial, int *i_crc, int *M_out);

int main()
{

  int i_data[5] = {0,0,0,0,0};
  int i_crc[5] = {0,0,0,0,0};
  int i_crc_serial[5] = {0,0,0,0,0};
  int M_out[5] = {0,0,0,0,0};
  int poly_width = 5;
  int data_in_size = 4;
  int j = 0;
 


  int h1_matrix [5][5] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} };
  int h2_matrix [5][5] = { {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0}, {0,0,0,0,0} };


  // N = 0x01
  i_data[0] = 1;
  i_data[1] = 0;
  i_data[2] = 0;
  i_data[3] = 0;
  i_data[4] = 0;
  
  crc_parallel(data_in_size, poly_width, i_data, i_crc_serial, i_crc, M_out);



  for(j = 0; j < poly_width ; j++) {
    printf("M_out[%d] : %d \n", j , M_out[j]);
  }

  for(j = 0 ; j < 5 ; j++) {
    i_data[j] = 0;
    i_crc[j] = 0;
    i_crc_serial[j] = 0;
    M_out[j] = 0;
  }

 
  
  // N = 0x02
  i_data[0] = 0;
  i_data[1] = 1;
  i_data[2] = 0;
  i_data[3] = 0;
  i_data[4] = 0;
  
  crc_parallel(data_in_size, poly_width, i_data, i_crc_serial, i_crc, M_out);



  for(j = 0; j < poly_width ; j++) {
    printf("M_out[%d] : %d \n", j , M_out[j]);
  }

 for(j = 0 ; j < 5 ; j++) {
    i_data[j] = 0;
    i_crc[j] = 0;
    i_crc_serial[j] = 0;
    M_out[j] = 0;
  }

  // N = 0x04
  i_data[0] = 0;
  i_data[1] = 0;
  i_data[2] = 1;
  i_data[3] = 0;
  i_data[4] = 0;
  
  crc_parallel(data_in_size, poly_width, i_data, i_crc_serial, i_crc, M_out);



  for(j = 0; j < poly_width ; j++) {
    printf("M_out[%d] : %d \n", j , M_out[j]);
  }

 for(j = 0 ; j < 5 ; j++) {
    i_data[j] = 0;
    i_crc[j] = 0;
    i_crc_serial[j] = 0;
    M_out[j] = 0;
  }

  // N = 0x08
  i_data[0] = 0;
  i_data[1] = 0;
  i_data[2] = 0;
  i_data[3] = 1;
  i_data[4] = 0;
  
  crc_parallel(data_in_size, poly_width, i_data, i_crc_serial, i_crc, M_out);



  for(j = 0; j < poly_width ; j++) {
    printf("M_out[%d] : %d \n", j , M_out[j]);
  }
  
    return 0;
}


int crc_serial(int *i_data, int *crc_serial, int *crc) {

  int i = 0;

  crc_serial[0] = crc[4] ^ *i_data;
  crc_serial[1] = crc[0];
  crc_serial[2] = crc[1] ^ crc[4] ^ *i_data;
  crc_serial[3] = crc[2];
  crc_serial[4] = crc[3];

  // Update
  for(i = 0 ; i < 5 ; i++) {
    crc[i] = crc_serial[i];
  }

  printf("crc_serial : %d%d%d%d%d \n", crc_serial[4], crc_serial[3], crc_serial[2], crc_serial[1], crc_serial[0]);
  
  return 0;
}


int crc_parallel(int N, int M, int *i_data, int *i_crc_serial, int *i_crc, int *M_out) {

  int i = 0;
  int *data = 0;
  for(i = 0; i < N ; i ++) {
    data = i_data;
    *data = i_data[i];
    crc_serial(data, i_crc_serial, i_crc);    
  }
  
  for(i = 0; i < M ; i ++) {
   M_out[i] = i_crc_serial[i];
  }
  return 0;
}

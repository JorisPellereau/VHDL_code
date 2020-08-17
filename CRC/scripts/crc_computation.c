#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//#include "crc_functions.h"

// == PROTOTYPES ==
void crc_serial(int poly_width, int i_data, int *crc, int *crc_serial, int verbose);
void crc_parallel(int data_in_width, int poly_width, int *i_data, int *i_crc, int *i_crc_serial, int crc_par_verbose, int crc_serial_verbose);
void fill_h1(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h1_matrix, int h1_verbose, int crc_par_verbose, int crc_ser_verbose);
void fill_h2(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h2_matrix, int h2_verbose, int crc_par_verbose, int crc_ser_verbose);
// ================


int main(int argc, char **argv) {

  // DECLARATION

  int poly_width;
  int data_in_size;

  
  // CRC 16
  poly_width   = 16;  // to set with argv
  data_in_size = 8;
  
  int i_data[data_in_size];
  int i_crc[poly_width];
  int i_crc_serial[poly_width];
  int M_out[poly_width];  
  int j;
  int i;
  
  int verbose;


  // == INITIALIZATION ==
  j = 0;
  i = 0;
  verbose = 1;

  for(i = 0 ; i < data_in_size ; i++) {
    i_data[i] = 0;
  }

  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 0;
    i_crc_serial[i] = 0;
    M_out[i] = 0;
  }
  

  // H1 : data_size_in * Poly_width size
  int** h1_matrix = (int**)malloc(data_in_size * sizeof(int*));
  for (int index = 0 ; index < data_in_size ; ++index) {
    h1_matrix[index] = (int*)malloc(poly_width * sizeof(int));
  }

  // H2 : Poly_width * Poly_width size
  int** h2_matrix = (int**)malloc(poly_width * sizeof(int*));
  for (i = 0 ; i < poly_width ; ++i) {
    h2_matrix[i] = (int*)malloc(poly_width * sizeof(int));
  }
  
  // INIT Matrix
  for(i = 0 ; i < data_in_size ; i ++) {
    for(j = 0 ; j < poly_width ; j ++) {
      h1_matrix[i][j] = 0;
    }
  }

  for(i = 0 ; i < poly_width ; i ++) {
    for(j = 0 ; j < poly_width ; j ++) {
      h2_matrix[i][j] = 0;
    }
  }

  
  
  // == CRC SERIAL TEST ==
  /*i_data[0] = 1;
  i_crc[0]  = 1;
  crc_serial(poly_width, i_data[0], i_crc, i_crc_serial, verbose);
  i_data[0] = 0;  
  crc_serial(poly_width, i_data[0], i_crc, i_crc_serial, verbose);
  crc_serial(poly_width, i_data[0], i_crc, i_crc_serial, verbose);
  crc_serial(poly_width, i_data[0], i_crc, i_crc_serial, verbose);
  crc_serial(poly_width, i_data[0], i_crc, i_crc_serial, verbose);*/
  // =====================
  
  // == RAZ inputs ==
  for(i = 0 ; i < data_in_size ; i++) {
    i_data[i] = 0;
  }

  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 0;
    i_crc_serial[i] = 0;
    M_out[i] = 0;
  }
  // ===============
  
  
  // == CRC PARALELL TEST ==
  // CRC 16
  poly_width   = 16;  // to set with argv
  data_in_size = 8;
  
  // Input Data : 0xBB
  i_data[7] = 1;
  i_data[6] = 0;
  i_data[5] = 1;
  i_data[4] = 1;
  i_data[3] = 1;
  i_data[2] = 0;
  i_data[1] = 1;
  i_data[0] = 1;
  
  // CRC init = 0xFFFF
  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 1;
  }
  crc_parallel(data_in_size, poly_width, i_data, i_crc, i_crc_serial, 0, 0);
  // =======================
  

  // == RAZ inputs ==
  for(i = 0 ; i < data_in_size ; i++) {
    i_data[i] = 0;
  }

  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 0;
    i_crc_serial[i] = 0;
    M_out[i] = 0;
  }
  // ===============
  

  // == H1 FILL TEST ==

  // CRC 16
  poly_width   = 16;  // to set with argv
  data_in_size = 8;  
  
  // CRC init = 0xFFFF
  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 1;
  }
  
  fill_h1(data_in_size, poly_width, i_crc, i_crc_serial, h1_matrix, verbose, 0, 0);
  // ==================


  // == RAZ inputs ==
  for(i = 0 ; i < data_in_size ; i++) {
    i_data[i] = 0;
  }

  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 0;
    i_crc_serial[i] = 0;
    M_out[i] = 0;
  }
  // ===============
  

  // == FILL H2 TEST ==
  // CRC 16
  poly_width   = 16;  // to set with argv
  data_in_size = 8;  
  
  // CRC init = 0xFFFF
  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 1;
  }
  fill_h2(data_in_size, poly_width, i_crc, i_crc_serial, h2_matrix, verbose, 0, 0);
  // ==================
 

  for(i = 0 ; i < data_in_size ; i++) {
    i_data[i] = 0;
  }

  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i] = 0;
    i_crc_serial[i] = 0;
    M_out[i] = 0;
  }
  
  //fill_h2(data_in_size, poly_width, i_crc_serial, i_crc, M_out, h2_matrix);
  
  // Free H1
  for (i = 0; i < data_in_size; i++) {
      free(h1_matrix[i]);
  }
  free(h1_matrix);

  // Free H2
  for (i = 0; i < poly_width; i++) {
      free(h2_matrix[i]);
  }
  free(h2_matrix);
  

  
 
  return 0;
}

/*
*  CRC SERIAL Computation
*  i_data     : input        - Bit of data (0 or 1)
*  poly_width  : input        - CRC polynom Width
*  *crc        : input/output - Current CRC 
*  *crc_serial : output       - CRC result
*  verbose     : input        - 1 : Verbose On - 0 : Verbose Off
*/
void crc_serial(int poly_width, int i_data, int *crc, int *crc_serial, int verbose) {

  int i = 0;

  // CRC SERIAL - HArd Coded
  // CRC : x^5 + x^2 + 1
  /*crc_serial[0] = crc[4] ^ i_data;
  crc_serial[1] = crc[0];
  crc_serial[2] = crc[1] ^ crc[4] ^ i_data;
  crc_serial[3] = crc[2];
  crc_serial[4] = crc[3];*/
  
  
  // CRC : x^16 + x^12 + x^5 + 1
  /*crc_serial[0] = crc[15] ^ i_data;
  crc_serial[1] = crc[0];
  crc_serial[2] = crc[1];
  crc_serial[3] = crc[2];
  crc_serial[4] = crc[3];
  crc_serial[5] = crc[4] ^ crc[3] ^ crc[15];
  crc_serial[6] = crc[5];
  crc_serial[7] = crc[6];
  crc_serial[8] = crc[7];
  crc_serial[9] = crc[8];
  crc_serial[10] = crc[9];
  crc_serial[11] = crc[10];
  crc_serial[12] = crc[11] ^ crc[10] ^ crc[15];
  crc_serial[13] = crc[12];
  crc_serial[14] = crc[13];
  crc_serial[15] = crc[14] ^ crc[13] ^ crc[15];
  */
  
  /*crc_serial[0] = crc[15] ^ i_data;
  crc_serial[1] = crc[0];
  crc_serial[2] = crc[1];
  crc_serial[3] = crc[2];
  crc_serial[4] = crc[3];
  crc_serial[5] = crc[4]  ^ crc[15];
  crc_serial[6] = crc[5];
  crc_serial[7] = crc[6];
  crc_serial[8] = crc[7];
  crc_serial[9] = crc[8];
  crc_serial[10] = crc[9];
  crc_serial[11] = crc[10];
  crc_serial[12] = crc[11]  ^ crc[15];
  crc_serial[13] = crc[12];
  crc_serial[14] = crc[13];
  crc_serial[15] = crc[14]  ^ crc[15];*/

  crc_serial[0] = crc[15] ^ i_data;
  crc_serial[1] = crc[0];
  crc_serial[2] = crc[1];
  crc_serial[3] = crc[2];
  crc_serial[4] = crc[3];
  crc_serial[5] = crc[4]  ^ crc[15] ^ i_data;
  crc_serial[6] = crc[5];
  crc_serial[7] = crc[6];
  crc_serial[8] = crc[7];
  crc_serial[9] = crc[8];
  crc_serial[10] = crc[9];
  crc_serial[11] = crc[10];
  crc_serial[12] = crc[11]  ^ crc[15] ^ i_data;
  crc_serial[13] = crc[12];
  crc_serial[14] = crc[13];
  crc_serial[15] = crc[14];

  
  

  // Update
  for(i = 0 ; i < poly_width ; i++) {
    crc[i] = crc_serial[i];
  }

  // Verbose
  if(verbose == 1) {
    printf("crc_serial : ");
    for(i = poly_width - 1 ; i >= 0 ; i--) {    
      printf("%d", crc_serial[i]);  // MSB First
    }
    printf("\n");
  }
  else if(verbose == 0) {
  }
  else {
      printf("Verbose Error \n\n");
  }
   
}

/*
*  data_in_width      : input        - Data INPUT WIDTH
*  poly_width         : input        - CRC Polynom WIDTH
*  *i_data            : input        - Data input  (Array type)
*  *i_crc             : input/output - Current CRC
*  *i_crc_serial      : output       - CRC RESULT
*  crc_par_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
*  crc_serial_verbose : input        - 1 : Verbose On - 0 : Verbose Off
*
*/
void crc_parallel(int data_in_width, int poly_width, int *i_data, int *i_crc, int *i_crc_serial, int crc_par_verbose, int crc_serial_verbose) {//, int *M_out, int i_poly_width) {

  int i = 0;
  int crc_hex = 0;

  // MSB FIRST
  for(i = data_in_width - 1 ; i >= 0 ; i --) {  
    crc_serial(poly_width, i_data[i], i_crc, i_crc_serial, crc_serial_verbose);    
  }

  if(crc_par_verbose == 1) {
    printf("CRC PARALELL OUT : ");
    for(i = poly_width - 1 ; i >= 0 ; i --) {
      printf("%d", i_crc_serial[i]);
      crc_hex = crc_hex + i_crc_serial[i]*pow(2, i);
    }    
    printf("\nCRC PARALLEL OUT : 0x%x \n", crc_hex);
  }
  else if(crc_par_verbose == 0) {
  }
  else {
      printf("CRC SERIAL VERBOSE ERROR \n\n");
  }
  

}

/*
 *  data_in_width      : input        - Data in width
 *  poly_width         : input        - CRC Polynom Width
 *  *i_crc             : input/output - Current CRC
 *  *i_crc_serial      : output       - CRC Result
 *  **h1_matrix        : output       - H1 Matrix result
 *  h1_verbose         : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_par_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_ser_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
 *
 */
void fill_h1(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h1_matrix, int h1_verbose, int crc_par_verbose, int crc_ser_verbose) {
  
  int j = 0;
  int i = 0;
  int k = 0;
  int data[data_in_width];
  int *data_ptr;

  data_ptr = data; // INIT PTR

  // INIT DATA
  for(i = 0 ; i < data_in_width ; i++) {
    data[i] = 0;
  }

  data[0] = 1;
  *data_ptr = data[0];
  
  for(j = 0 ; j < data_in_width ; j++) {


    if(h1_verbose == 1) {
      printf("Data in CRC parallel (MSB first) : 0b");
      for(k = data_in_width - 1 ; k >= 0 ; k--) {
        printf("%d", data[k]);
      }
      printf("\n");
    }
    crc_parallel(data_in_width, poly_width, data, i_crc, i_crc_serial, crc_par_verbose, crc_ser_verbose);
    for(i = 0 ; i < poly_width ; i++) {
      h1_matrix[j][i] = i_crc_serial[i];
    }

    // RAZ inputs
    for(k = 0 ; k < poly_width ; k++) {
      data[k] = 0;
      i_crc[k] = 0;
      i_crc_serial[k] = 0;
    }

    // SHIFT i_data
    data[j+1] = 1;

  }

  if(h1_verbose == 1) {
    // PRINT H1
    for(j = 0 ; j < poly_width ; j++) {
      printf("Mout[%d] ", poly_width - 1 - j);
    }
    printf("\n");
  
    for(j = 0; j < data_in_width ; j++) {
      printf("Nin[%d]", j );
      for(i = 0 ; i < poly_width ; i++) {
        printf("     %d", h1_matrix[data_in_width - 1 - j][poly_width - 1 - i]);
      }
      printf("\n");
    }
  }
  else if(h1_verbose == 0) {
  }
  else {
    printf("Verbose H1 Fill ERROR \n\n");
  }
  
}

void fill_h2(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h2_matrix, int h2_verbose, int crc_par_verbose, int crc_ser_verbose) {
    
  int j = 0;
  int i = 0;
  int k = 0;
  
  int h2_data[data_in_width]; 
    
  // NIN = 0
  for(i = 0 ; i < data_in_width ; i++) {
      h2_data[i] = 0;
  }
  
  //i_data = h2_data; // PTR INIT
  
  i_crc[0] = 1; // MIN init
  for(j = 0 ; j < poly_width ; j++) {
      
    crc_parallel(data_in_width, poly_width, h2_data, i_crc, i_crc_serial, crc_par_verbose, crc_ser_verbose);

    for(i = 0 ; i < poly_width ; i++) {
      h2_matrix[j][i] = i_crc_serial[i];
    }
  
    
    // RAZ inputs
    for(k = 0 ; k < poly_width ; k++) {
      i_crc[k] = 0;
      i_crc_serial[k] = 0;
    }
  
  // SHIFT i_crc_serial
  i_crc[j+1] = 1;
      
  }
   // PRINT H2
  for(j = 0 ; j < poly_width ; j++) {
    printf("Mout[%d] ", poly_width - 1 - j);
  }
  printf("\n");
  
  for(j = 0; j < poly_width; j++) {
    printf("Min[%d]", j);
    for(i = 0 ; i < poly_width ; i++) {
      printf("     %d", h2_matrix[poly_width- 1 - j][poly_width - 1 - i]);
    }
    printf("\n");
  }
  
}

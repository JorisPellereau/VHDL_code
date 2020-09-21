/*
 * File   : crc_computation.c
 * Author : J.P
 * Date   : 19/08/2020
 *
 *
 * Description :
 *  CRC computation for a selected CRC
 *  Input file : file with data byte
 *  
 *
 *
 * Example utilisation : 
 * A) ./crc_computation.o 8 16 1 "input_file_path" 65535 0 => CRC INIT = 0xFFFF Print result without debug messages
 * B) ./crc_computation.o 8 16 1 "input_file_path" 65535 1 => CRC INIT = 0xFFFF Print result with debug messages
 *
 * argv[1] = Data In Size
 * argv[2] = Polynome Size
 * argv[3] = CRC Number of polynome size
 * argv[4] = input_file.txt - One data per line - Must be in accordance with Data In Size 
 * argv[5] = CRC init - Must be in accorance with poly_size
 * argv[6] = verbose
 * 
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//#include "crc_functions.h"


// == PROTOTYPES ==
void crc_serial(int poly_width, int i_data, int *crc, int *crc_serial, int verbose, int crc_number);
void crc_parallel(int data_in_width, int poly_width, int *i_data, int *i_crc, int *i_crc_serial, int crc_par_verbose, int crc_serial_verbose, int crc_number);
void fill_h1(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h1_matrix, int h1_verbose, int crc_par_verbose, int crc_ser_verbose, int crc_number);
void fill_h2(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h2_matrix, int h2_verbose, int crc_par_verbose, int crc_ser_verbose, int crc_number);
void print_impl_crc_par(int data_in_width, int poly_width, int **h1_matrix, int **h2_matrix);
// ================

int main(int argc, char **argv) {

  FILE *input_file;

  // DECLARATION

  int poly_width;
  int data_in_size;
  int crc_number;
  int crc_init;
  int verbose;

  int i; // INDEX

  char *input_file_path;
  char data_line[100];

  int data_file;
  int crc_hex;

  
  
  // CRC INPUTS
  data_in_size       = atoi(argv[1]);
  poly_width         = atoi(argv[2]);
  crc_number         = atoi(argv[3]);
  input_file_path    = argv[4];
  crc_init           = atoi(argv[5]);
  verbose            = atoi(argv[6]);

  int i_crc[poly_width];
  int i_crc_serial[poly_width];
  int i_data[data_in_size];
 

  // == INIT ==
  data_file = 0;
  crc_hex   = 0;
  
  for(i = 0 ; i < data_in_size ; i++) {
    i_data[i] = 0;
  }

  for(i = 0 ; i < poly_width ; i++) {
    i_crc[i]        = 0;
    i_crc_serial[i] = 0;
  }
  // ==========

  printf("Input CRC File path : %s \n", input_file_path);

  // == OPEN FILE in READ ONLY ==
  input_file = fopen(input_file_path, "r");
  if (input_file == NULL) {
        printf("Error: Input File Doesn't Exist");
  }

  // INIT CRC when /= 0
  if(crc_init != 0) {
    for(i = 0 ; i < poly_width ; i++) {
      i_crc[i] = crc_init & 1;  // Mask : Read LSB
      crc_init = crc_init >> 1; // 1 Right Shift
    }
  }
	 
  while(feof(input_file) == 0) {
    
    fgets(data_line, 100, input_file);  // Read the line

    if(verbose == 1) {
      printf("data_line : %s \n", data_line);
      printf("data_line atoi : %d \n", atoi(data_line));
    }
    data_file = atoi(data_line); // String to Int

    // Fill i_data array with data from file
    for(i = 0 ; i < data_in_size ; i++) {
      i_data[i] = data_file & 1;  // Mask : Read LSB
      data_file = data_file >> 1; // 1 Right Shift
    }

    if(verbose == 1) {
      printf("i_data (MSB first) : ");
      for(i = data_in_size - 1 ; i >= 0 ; i--) {
	printf("%d", i_data[i]);
      }
      printf("\n\n");
    }
    else if(verbose == 0) {
    }
    else {
      printf("Verbose ERROR \n");
    }

    // Compute CRC
    crc_parallel(data_in_size, poly_width, i_data, i_crc, i_crc_serial, verbose, verbose, crc_number);
  }
  

   fclose(input_file);

   // == Print result ==
   for(i = poly_width - 1 ; i >= 0 ; i--) { 
     crc_hex = crc_hex + i_crc_serial[i]*pow(2, i);
    }    
    printf("\nCRC PARALLEL OUT : 0x%x \n", crc_hex);
    
   if(verbose == 1) {
     printf("crc_computation DONE. \n\n");
   }
  
  return 0;
}


/*
*  CRC SERIAL Computation
*  i_data      : input        - Bit of data (0 or 1)
*  poly_width  : input        - CRC polynom Width
*  *crc        : input/output - Current CRC 
*  *crc_serial : output       - CRC result
*  verbose     : input        - 1 : Verbose On - 0 : Verbose Off
*  crc_numer   : input        - CRC Number selected
*/
void crc_serial(int poly_width, int i_data, int *crc, int *crc_serial, int verbose, int crc_number) {

  int i = 0;

  // HARD CODED CRC
  switch(poly_width) {
  case 5 :
    if(crc_number == 1) {

      // CRC : x^5 + x^2 + 1      
      crc_serial[0] = crc[4] ^ i_data;
      crc_serial[1] = crc[0];
      crc_serial[2] = crc[1] ^ crc[4] ^ i_data;
      crc_serial[3] = crc[2];
      crc_serial[4] = crc[3];

      break;
    }
    else {
      printf("CRC 5 ERROR \n\n");

      break;
    }
	
  case 8 :
    if(crc_number == 1) {
		
		// CRC : X^8 + X^2 + X + 1
		crc_serial[0] = crc[7] ^ i_data;
		crc_serial[1] = crc[0] ^ crc[7] ^ i_data;
		crc_serial[2] = crc[1] ^ crc[7] ^ i_data;
		crc_serial[3] = crc[2];
		crc_serial[4] = crc[3];
		crc_serial[5] = crc[4];
		crc_serial[6] = crc[5];
		crc_serial[7] = crc[6];
		
		break;
	}
	else {
		printf("CRC 8 ERROR \n\n");
		
		break;
	}
	

  case 16 :
    if(crc_number == 1) {

      // CRC : x^16 + x^12 + x^5 + 1      
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
      crc_serial[12] = crc[11] ^ crc[15] ^ i_data;
      crc_serial[13] = crc[12];
      crc_serial[14] = crc[13];
      crc_serial[15] = crc[14];

      break;
    }
    else if(crc_number == 2) {
      // CRC : x^16 + x^12 + x^5 + 1 - bis      
      crc_serial[0] = crc[15] ^ i_data;
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
      crc_serial[15] = crc[14];
      
      break;
    }
    else if(crc_number == 3) {
      // CRC : x^16 + x^12 + x^5 + 1 - ter      
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
      crc_serial[15] = crc[14] ^ crc[15] ^ i_data;
      
      break;
    }
    else {
      printf("CRC 16 ERROR \n\n");

      break;
    }

  default :
    printf("ERROR : CRC Not in the list \n\n");
   
    
  }

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
*  crc_number         : input        - CRC Number selected
*/
void crc_parallel(int data_in_width, int poly_width, int *i_data, int *i_crc, int *i_crc_serial, int crc_par_verbose, int crc_serial_verbose, int crc_number) {

  int i = 0;
  int crc_hex = 0;

  if(crc_par_verbose == 1) {
    printf("crc_parallel START \n\n");
  }

  // MSB FIRST
  for(i = data_in_width - 1 ; i >= 0 ; i --) {  
    crc_serial(poly_width, i_data[i], i_crc, i_crc_serial, crc_serial_verbose, crc_number);    
  }

  if(crc_par_verbose == 1) {
    printf("CRC PARALELL OUT : ");
    for(i = poly_width - 1 ; i >= 0 ; i --) {
      printf("%d", i_crc_serial[i]);
      crc_hex = crc_hex + i_crc_serial[i]*pow(2, i);
    }    
    printf("\nCRC PARALLEL OUT : 0x%x \n", crc_hex);
    printf("crc_parallel DONE. \n\n");
  }
  else if(crc_par_verbose == 0) {
  }
  else {
      printf("CRC SERIAL VERBOSE ERROR \n\n");
  }
  

}

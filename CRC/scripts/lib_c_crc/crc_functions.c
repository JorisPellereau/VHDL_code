/* 
 *  File   : crc_functions.c
 *  Author : J.P
 *  Date   : 19/08/2020
 *
 *  Description : Contains CRC functions
 *
 *
 *
 *
 */

#include "math.h"
#include "crc_functions.h"


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



/* /\* */
/* *  CRC SERIAL Computation */
/* *  i_data      : input        - Bit of data (0 or 1) */
/* *  poly_width  : input        - CRC polynom Width */
/* *  *crc        : input/output - Current CRC  */
/* *  *crc_serial : output       - CRC result */
/* *  verbose     : input        - 1 : Verbose On - 0 : Verbose Off */
/* *  crc_numer   : input        - CRC Number selected */
/* *\/ */
/* void crc_serial(int poly_width, int i_data, int *crc, int *crc_serial, int verbose, int crc_number) { */

/*   int i = 0; */

/*   // HARD CODED CRC */
/*   switch(poly_width) { */
/*   case 5 : */
/*     if(crc_number == 1) { */

/*       // CRC : x^5 + x^2 + 1 */
/*       crc_serial[0] = crc[4] ^ i_data; */
/*       crc_serial[1] = crc[0]; */
/*       crc_serial[2] = crc[1] ^ crc[4] ^ i_data; */
/*       crc_serial[3] = crc[2]; */
/*       crc_serial[4] = crc[3]; */

/*       break; */
/*     } */
/*     else { */
/*       printf("CRC 5 ERROR \n\n"); */

/*       break; */
/*     } */

/*   case 16 : */
/*     if(crc_number == 1) { */

/*       // CRC : x^16 + x^12 + x^5 + 1 */
/*       crc_serial[0] = crc[15] ^ i_data; */
/*       crc_serial[1] = crc[0]; */
/*       crc_serial[2] = crc[1]; */
/*       crc_serial[3] = crc[2]; */
/*       crc_serial[4] = crc[3]; */
/*       crc_serial[5] = crc[4]  ^ crc[15] ^ i_data; */
/*       crc_serial[6] = crc[5]; */
/*       crc_serial[7] = crc[6]; */
/*       crc_serial[8] = crc[7]; */
/*       crc_serial[9] = crc[8]; */
/*       crc_serial[10] = crc[9]; */
/*       crc_serial[11] = crc[10]; */
/*       crc_serial[12] = crc[11] ^ crc[15] ^ i_data; */
/*       crc_serial[13] = crc[12]; */
/*       crc_serial[14] = crc[13]; */
/*       crc_serial[15] = crc[14]; */

/*       break; */
/*     } */
/*     else if(crc_number == 2) { */
/*       // CRC : x^16 + x^12 + x^5 + 1 - bis */
/*       crc_serial[0] = crc[15] ^ i_data; */
/*       crc_serial[1] = crc[0]; */
/*       crc_serial[2] = crc[1]; */
/*       crc_serial[3] = crc[2]; */
/*       crc_serial[4] = crc[3]; */
/*       crc_serial[5] = crc[4]  ^ crc[15]; */
/*       crc_serial[6] = crc[5]; */
/*       crc_serial[7] = crc[6]; */
/*       crc_serial[8] = crc[7]; */
/*       crc_serial[9] = crc[8]; */
/*       crc_serial[10] = crc[9]; */
/*       crc_serial[11] = crc[10]; */
/*       crc_serial[12] = crc[11]  ^ crc[15]; */
/*       crc_serial[13] = crc[12]; */
/*       crc_serial[14] = crc[13]; */
/*       crc_serial[15] = crc[14]; */
      
/*       break; */
/*     } */
/*     else if(crc_number == 3) { */
/*       // CRC : x^16 + x^12 + x^5 + 1 - ter */
/*       crc_serial[0] = crc[15] ^ i_data; */
/*       crc_serial[1] = crc[0]; */
/*       crc_serial[2] = crc[1]; */
/*       crc_serial[3] = crc[2]; */
/*       crc_serial[4] = crc[3]; */
/*       crc_serial[5] = crc[4]  ^ crc[15] ^ i_data; */
/*       crc_serial[6] = crc[5]; */
/*       crc_serial[7] = crc[6]; */
/*       crc_serial[8] = crc[7]; */
/*       crc_serial[9] = crc[8]; */
/*       crc_serial[10] = crc[9]; */
/*       crc_serial[11] = crc[10]; */
/*       crc_serial[12] = crc[11]  ^ crc[15] ^ i_data; */
/*       crc_serial[13] = crc[12]; */
/*       crc_serial[14] = crc[13]; */
/*       crc_serial[15] = crc[14] ^ crc[15] ^ i_data; */
      
/*       break; */
/*     } */
/*     else { */
/*       printf("CRC 16 ERROR \n\n"); */

/*       break; */
/*     } */

/*   default : */
/*     printf("ERROR : CRC Not in the list \n\n"); */
   
    
/*   } */

/*   // Update */
/*   for(i = 0 ; i < poly_width ; i++) { */
/*     crc[i] = crc_serial[i]; */
/*   } */

/*   // Verbose */
/*   if(verbose == 1) { */
/*     printf("crc_serial : "); */
/*     for(i = poly_width - 1 ; i >= 0 ; i--) {     */
/*       printf("%d", crc_serial[i]);  // MSB First */
/*     } */
/*     printf("\n"); */
/*   } */
/*   else if(verbose == 0) { */
/*   } */
/*   else { */
/*       printf("Verbose Error \n\n"); */
/*   } */
   
/* } */

/* /\* */
/* *  data_in_width      : input        - Data INPUT WIDTH */
/* *  poly_width         : input        - CRC Polynom WIDTH */
/* *  *i_data            : input        - Data input  (Array type) */
/* *  *i_crc             : input/output - Current CRC */
/* *  *i_crc_serial      : output       - CRC RESULT */
/* *  crc_par_verbose    : input        - 1 : Verbose On - 0 : Verbose Off */
/* *  crc_serial_verbose : input        - 1 : Verbose On - 0 : Verbose Off */
/* *  crc_number         : input        - CRC Number selected */
/* *\/ */
/* void crc_parallel(int data_in_width, int poly_width, int *i_data, int *i_crc, int *i_crc_serial, int crc_par_verbose, int crc_serial_verbose, int crc_number) { */

/*   int i = 0; */
/*   int crc_hex = 0; */

/*   // MSB FIRST */
/*   for(i = data_in_width - 1 ; i >= 0 ; i --) {   */
/*     crc_serial(poly_width, i_data[i], i_crc, i_crc_serial, crc_serial_verbose, crc_number);     */
/*   } */

/*   if(crc_par_verbose == 1) { */
/*     printf("CRC PARALELL OUT : "); */
/*     for(i = poly_width - 1 ; i >= 0 ; i --) { */
/*       printf("%d", i_crc_serial[i]); */
/*       crc_hex = crc_hex + i_crc_serial[i]*pow(2, i); */
/*     }     */
/*     printf("\nCRC PARALLEL OUT : 0x%x \n", crc_hex); */
/*   } */
/*   else if(crc_par_verbose == 0) { */
/*   } */
/*   else { */
/*       printf("CRC SERIAL VERBOSE ERROR \n\n"); */
/*   } */
  

/* } */

/*
 *  data_in_width      : input        - Data in width
 *  poly_width         : input        - CRC Polynom Width
 *  *i_crc             : input/output - Current CRC
 *  *i_crc_serial      : output       - CRC Result
 *  **h1_matrix        : output       - H1 Matrix result
 *  h1_verbose         : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_par_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_ser_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_number         : input        - CRC Number selected
 */
void fill_h1(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h1_matrix, int h1_verbose, int crc_par_verbose, int crc_ser_verbose, int crc_number) {
  
  int j = 0;
  int i = 0;
  int k = 0;
  int data[data_in_width];
  //int *data_ptr;

  //data_ptr = data; // INIT PTR

  // INIT DATA
  for(i = 0 ; i < data_in_width ; i++) {
    data[i] = 0;
  }

  data[0] = 1;
  //*data_ptr = data[0];
  
  for(j = 0 ; j < data_in_width ; j++) {


    if(h1_verbose == 1) {
      printf("Data in CRC parallel for H1 Matrix (MSB first) : 0b");
      for(k = data_in_width - 1 ; k >= 0 ; k--) {
        printf("%d", data[k]);
      }
      printf("\n");
    }
    
    crc_parallel(data_in_width, poly_width, data, i_crc, i_crc_serial, crc_par_verbose, crc_ser_verbose, crc_number);
    for(i = 0 ; i < poly_width ; i++) {
      h1_matrix[j][i] = i_crc_serial[i];
    }

    // RAZ inputs
    for(k = 0 ; k < poly_width ; k++) {
      i_crc[k] = 0;
      i_crc_serial[k] = 0;
    }
    for(k = 0 ; k < data_in_width ; k++) {
      //printf("data[%d] : %d ", k, data[k]);
      data[k] = 0;
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
        printf("     %d", h1_matrix[j][poly_width - 1 - i]);
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

/*
 *  data_in_width      : input        - Data in width
 *  poly_width         : input        - CRC Polynom Width
 *  *i_crc             : input/output - Current CRC
 *  *i_crc_serial      : output       - CRC Result
 *  **h2_matrix        : output       - H2 Matrix result
 *  h2_verbose         : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_par_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_ser_verbose    : input        - 1 : Verbose On - 0 : Verbose Off
 *  crc_number         : input        - CRC Number selected
 */
void fill_h2(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h2_matrix, int h2_verbose, int crc_par_verbose, int crc_ser_verbose, int crc_number) {
    
  int j = 0;
  int i = 0;
  int k = 0;
  
  int h2_data[data_in_width]; 
    
  // NIN = 0
  for(i = 0 ; i < data_in_width ; i++) {
      h2_data[i] = 0;
  }
  
  
  i_crc[0] = 1; // MIN init
  for(j = 0 ; j < poly_width ; j++) {

    if(h2_verbose == 1) {
      printf("CRC data in CRC parallel for H2 Matrix (MSB first) : 0b");
      for(k = data_in_width - 1 ; k >= 0 ; k--) {
        printf("%d", i_crc[k]);
      }
      printf("\n");
    }
      
    crc_parallel(data_in_width, poly_width, h2_data, i_crc, i_crc_serial, crc_par_verbose, crc_ser_verbose, crc_number);

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
      printf("     %d", h2_matrix[j][poly_width - 1 - i]);
    }
    printf("\n");
  }
  
}


void print_impl_crc_par(int data_in_width, int poly_width, int **h1_matrix, int **h2_matrix) {

  int i;
  int j;
  /*for(i = 0 ; i < data_in_width ; i++) {
    for(j = 0 ; j < poly_width ; j++) {
      printf("h1_matrix[%d][%d] : %d ", i, j, h1_matrix[i][j]);
    }
    printf("\n");
  }

  for(i = 0 ; i < poly_width ; i++) {
    for(j = 0 ; j < poly_width ; j++) {
      printf("h2_matrix[%d][%d] : %d", i, j, h2_matrix[i][j]);
    }
    printf("\n");
    }*/

  for(i = 0 ; i < poly_width ; i++) {
    printf("Mout[%d] = ", i);
    //if(i < data_in_width) {
      for(j = 0 ; j < data_in_width ; j++) {
        if(h1_matrix[j][i] == 1) {
  	  printf("Nin[%d] xor ", j);
        }
      }
      //}
    for(j = 0 ; j < poly_width ; j++) {
      if(h2_matrix[j][i] == 1) {
	printf("Min[%d] xor ", j);
      }
    }
    printf("\n");
    
  }
  
  
}

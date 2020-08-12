#include <stdio.h>
#include <stdlib.h>


// == PROTOTYPES ==
int crc_serial(int *i_data, int *crc_serial, int *crc, int poly_width);
int crc_parallel(int N, int M, int *i_data, int *i_crc_serial, int *i_crc, int *M_out, int i_poly_width);
void fill_h1(int i_data_in_width, int i_poly_width, int *i_data, int *i_crc_serial, int *i_crc, int *M_out, int **h1_matrix);
// ================


int main() {

  // DECLARATION

  int poly_width;
  int data_in_size;


  poly_width   = 5;  // to set with argv
  data_in_size = 4;
  
  int i_data[data_in_size];
  int i_crc[poly_width];
  int i_crc_serial[poly_width];
  int M_out[poly_width];  
  int j;
  int i;


  // == INITIALIZATION ==
  j = 0;
  i = 0;

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

  
  // INIT

  i_data[0] = 1;

  //crc_serial(i_data, i_crc_serial, i_crc, poly_width);

  //crc_parallel(data_in_size, poly_width, i_data, i_crc_serial, i_crc, M_out, poly_width);
  
  fill_h1(data_in_size, poly_width, i_data, i_crc_serial, i_crc, M_out, h1_matrix);


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


int crc_serial(int *i_data, int *crc_serial, int *crc, int poly_width) {

  int i = 0;

  // CRC SERIAL - HArd Coded
  crc_serial[0] = crc[4] ^ *i_data;
  crc_serial[1] = crc[0];
  crc_serial[2] = crc[1] ^ crc[4] ^ *i_data;
  crc_serial[3] = crc[2];
  crc_serial[4] = crc[3];

  // Update
  for(i = 0 ; i < poly_width ; i++) {
    crc[i] = crc_serial[i];
  }

  printf("crc_serial : ");
  for(i = poly_width - 1 ; i >= 0 ; i--) {    
    printf("%d", crc_serial[i]);
  }
  printf("\n");
   
  return 0;
}


int crc_parallel(int N, int M, int *i_data, int *i_crc_serial, int *i_crc, int *M_out, int i_poly_width) {

  int i = 0;
  int *data = 0;
  data = i_data;
  for(i = 0; i < N ; i ++) {
    *data = i_data[i];
    crc_serial(data, i_crc_serial, i_crc, i_poly_width);    
  }

  printf("M_out : ");
  for(i = 0; i < M ; i ++) {
    M_out[i] = i_crc_serial[i];
    printf("%d", M_out[M - 1 - i]);
  }
  printf("\n");
  
  return 0;
}


void fill_h1(int i_data_in_width, int i_poly_width, int *i_data, int *i_crc_serial, int *i_crc, int *M_out, int **h1_matrix) {
  
  int j = 0;
  int i = 0;
  int k = 0;
  for(j = 0 ; j < i_data_in_width ; j++) {
    crc_parallel(i_data_in_width, i_poly_width, i_data, i_crc_serial, i_crc, M_out, i_poly_width);

    for(i = 0 ; i < i_poly_width ; i++) {
      h1_matrix[j][i] = M_out[i];
    }

    // RAZ inputs
    for(k = 0 ; k < i_poly_width ; k++) {
      i_data[k] = 0;
      i_crc[k] = 0;
      i_crc_serial[k] = 0;
      M_out[k] = 0;
    }

    // SHIFT i_data
    i_data[j+1] = 1;
  }

  // PRINT H1
  for(j = 0 ; j < i_poly_width ; j++) {
    printf("     Mout[%d] ", i_poly_width - 1 - j);
  }
  printf("\n");
  
  for(j = 0; j < i_data_in_width ; j++) {
    printf("Nin[%d]", j );
    for(i = 0 ; i < i_poly_width ; i++) {
      printf("     %d", h1_matrix[i_data_in_width - 1 - j][i_poly_width - 1 - i]);
    }
    printf("\n");
  }

 
}

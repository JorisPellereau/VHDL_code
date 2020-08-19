/* 
 *  File   : crc_functions.h
 *  Author : J.P
 *  Date   : 19/08/2020
 *
 *  Description : Contains prototypes for CRC functions
 *
 *
 *
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// == PROTOTYPES ==
void crc_serial(int poly_width, int i_data, int *crc, int *crc_serial, int verbose, int crc_number);
void crc_parallel(int data_in_width, int poly_width, int *i_data, int *i_crc, int *i_crc_serial, int crc_par_verbose, int crc_serial_verbose, int crc_number);
void fill_h1(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h1_matrix, int h1_verbose, int crc_par_verbose, int crc_ser_verbose, int crc_number);
void fill_h2(int data_in_width, int poly_width, int *i_crc, int *i_crc_serial, int **h2_matrix, int h2_verbose, int crc_par_verbose, int crc_ser_verbose, int crc_number);
void print_impl_crc_par(int data_in_width, int poly_width, int **h1_matrix, int **h2_matrix);
// ================

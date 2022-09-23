FUNCTION z_00_add.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_NUM1) TYPE  I OPTIONAL
*"     REFERENCE(I_NUM2) TYPE  I DEFAULT 5
*"  EXPORTING
*"     REFERENCE(E_RESULT) TYPE  I
*"  EXCEPTIONS
*"      NUMBER_TOO_HIGH
*"----------------------------------------------------------------------
  IF i_num1 + i_num2 > 750000.
    RAISE number_too_high.
  ENDIF.

  e_result = i_num1 + i_num2.




ENDFUNCTION.

FUNCTION z_00_get_flights_for_airline.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_AIRLINE) TYPE  S_CARR_ID
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  D400_T_FLIGHTS
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
  SELECT FROM sflight
  FIELDS carrid, connid, fldate, planetype, seatsmax, seatsocc
  WHERE carrid = @iv_airline
  INTO TABLE @et_flights.
  IF sy-subrc <> 0.
    RAISE no_data.
  ENDIF.




ENDFUNCTION.

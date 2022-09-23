FUNCTION z_00_get_next_flight.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARR_ID
*"     REFERENCE(IV_CONNID) TYPE  S_CONN_ID
*"  EXPORTING
*"     REFERENCE(ES_FLIGHT) TYPE  D400_S_FLIGHT
*"  EXCEPTIONS
*"      NO_DATA
*"----------------------------------------------------------------------
  SELECT SINGLE FROM sflight AS main
  FIELDS carrid, connid, fldate, planetype, seatsmax, seatsocc
  WHERE carrid = @iv_carrid AND connid = @iv_connid
   AND  fldate = ( SELECT FROM sflight FIELDS MIN(  fldate )
                 WHERE carrid = main~carrid
                  AND connid = main~connid
                  AND fldate > @sy-datum )
  INTO @es_flight.

  IF sy-subrc <> 0.
    RAISE no_data.
  ENDIF.




ENDFUNCTION.

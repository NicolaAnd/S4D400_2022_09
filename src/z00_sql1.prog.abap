*&---------------------------------------------------------------------*
*& Report z00_sql1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_sql1.

PARAMETERS: p_carr TYPE sflight-carrid,
            p_conn TYPE sflight-connid,
            p_date TYPE sflight-fldate.

DATA: g_flight  TYPE d400_s_flight,
      g_flights TYPE d400_t_flights.


SELECT SINGLE FROM sflight FIELDS carrid, connid, fldate, planetype, seatsmax, seatsocc
  WHERE fldate = @p_date AND carrid = @p_carr AND connid = @p_conn
      INTO @g_flight.


SELECT FROM sflight FIELDS carrid, connid, fldate, planetype, seatsmax, seatsocc
  WHERE carrid = @p_carr AND connid = @p_conn
      INTO TABLE @g_flights.

*BREAK-POINT.


DO 50 TIMES.
  WRITE sy-index.
  WAIT UP TO 1 SECONDS.
ENDDO.

*&---------------------------------------------------------------------*
*& Report z00_events_countdown
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_events_countdown.

SELECT SINGLE FROM z00_events FIELDS event_date
    WHERE kind = `KR`
        INTO @DATA(g_date).

WHILE sy-datlo < g_date.
  DATA(g_diff) = g_date - sy-datlo.
  WRITE: g_diff.
  g_date -= 1.
ENDWHILE.
WRITE: `Juhu`.

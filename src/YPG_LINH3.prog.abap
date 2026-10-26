*&---------------------------------------------------------------------*
*& Report YPG_LINH3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YPG_LINH3.

INCLUDE YIN_LINH3_TOP.
INCLUDE YIN_LINH3_CLASS.
INCLUDE YIN_LINH3_CLC.
INCLUDE YIN_LINH3_F01.
INCLUDE YIN_LINH3_PBO.
INCLUDE YIN_LINH3_PAI.
include Z_VN_CURRENCY.

INITIALIZATION.
  PERFORM INIT.

START-OF-SELECTION.



PERFORM GET_DATA.
PERFORM DISPLAY_DATA.

COMMIT WORK.
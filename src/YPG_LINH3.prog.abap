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

INITIALIZATION.
  PERFORM INIT.

START-OF-SELECTION.

DELETE FROM YTB_DONH
  WHERE DHID IN (
    '0000000038',
    '0000000039',
    '0000000040',
    '0000000041',
    '0000000043',
    '0000000044',
    '0000000045'
  ).

COMMIT WORK.

PERFORM GET_DATA.
PERFORM DISPLAY_DATA.

COMMIT WORK.

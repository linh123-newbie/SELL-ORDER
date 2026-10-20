CLASS LCL_HANDLE_EVENTS DEFINITION FINAL.

  PUBLIC SECTION.
    METHODS:
      HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
        IMPORTING ES_ROW_NO E_ROW_ID E_COLUMN_ID,

      HANDLE_DATA_CHANGED  FOR EVENT DATA_CHANGED
        OF CL_GUI_ALV_GRID
        IMPORTING ER_DATA_CHANGED
                  E_ONF4
                  E_ONF4_BEFORE
                  E_ONF4_AFTER,

      HANDLE_DATA_CHANGED_F
        FOR EVENT DATA_CHANGED_FINISHED OF CL_GUI_ALV_GRID
        IMPORTING E_MODIFIED ET_GOOD_CELLS,

      HANDLE_BUTTON_CLICK
        FOR EVENT BUTTON_CLICK OF CL_GUI_ALV_GRID
        IMPORTING ES_COL_ID ES_ROW_NO,

      HANDLE_TOOLBAR
        FOR EVENT TOOLBAR       OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT E_INTERACTIVE,

      HANDLE_USER_COMMAND
        FOR EVENT USER_COMMAND  OF CL_GUI_ALV_GRID
        IMPORTING E_UCOMM ,

*      handle_after_refresh
*        FOR EVENT after_refresh OF cl_gui_alv_grid,

      ON_F4_SAP FOR EVENT ONF4 OF CL_GUI_ALV_GRID
        IMPORTING
          E_FIELDNAME
          ES_ROW_NO
          ER_EVENT_DATA
          ET_BAD_CELLS
          E_DISPLAY      .

ENDCLASS. "lcl_event_receiver DEFINITION

*----------------------------------------------------------------------*
* CLASS lcl_event_receiver IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS LCL_HANDLE_EVENTS IMPLEMENTATION.

  METHOD HANDLE_HOTSPOT_CLICK.
    PERFORM HANDLE_HOTSPOT_CLICK USING E_ROW_ID E_COLUMN_ID ES_ROW_NO.
  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED.
    PERFORM EVENT_DATA_CHANGED  USING ER_DATA_CHANGED
                                      E_ONF4
                                      E_ONF4_BEFORE
                                      E_ONF4_AFTER.
  ENDMETHOD.                    "data_changed

  METHOD HANDLE_DATA_CHANGED_F.
    PERFORM HANDLE_DATA_CHANGED_FINISHED USING E_MODIFIED ET_GOOD_CELLS.
  ENDMETHOD.

  METHOD HANDLE_BUTTON_CLICK.
    PERFORM HANDLE_BUTTON_CLICK USING ES_COL_ID ES_ROW_NO.
  ENDMETHOD.

  METHOD ON_F4_SAP.
*    IF e_fieldname = 'LGORT'.
*        " Lấy dòng hiện tại
*        READ TABLE GT_ALV INDEX es_row_no-row_id INTO DATA(ls_row_lgort).
*        IF sy-subrc = 0.
*            TYPES: BEGIN OF ty_lgort2,
*                     lgort TYPE lgort_d,
*                     lgobe TYPE lgobe,
*                   END OF ty_lgort2.
*            DATA: lt_lgort2 TYPE STANDARD TABLE OF ty_lgort2,
*                  lv_lgort TYPE lgort_d.
*            DATA: lt_return_lgort TYPE STANDARD TABLE OF DDSHRETVAL.
*            DATA: LS_LGOBE  TYPE LGOBE .
*
*            " Lấy kho theo werks dòng hiện tại
*            SELECT lgort, lgobe FROM t001l
*              INTO TABLE @lt_lgort2
*              WHERE werks = @S_WERKS-LOW .  "@S_BUKRS-LOW.
*
*            " Hiển thị search help popup
*            CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*              EXPORTING
*                retfield        = 'LGORT'
*                dynpprog        = sy-repid
*                dynpnr          = sy-dynnr
*                dynprofield     = 'GT_ALV-LGORT'
*                value_org       = 'S'
*              TABLES
*                value_tab       = lt_lgort2
*                return_tab      = lt_return_lgort
*              EXCEPTIONS
*                parameter_error = 1
*                no_values_found = 2
*                others          = 3.
*
*            " Nếu user chọn giá trị thì gán lại vào internal table
*            IF sy-subrc = 0 AND lt_return_lgort IS NOT INITIAL.
*                " Gán lại giá trị được chọn
*                READ TABLE lt_return_lgort INTO DATA(ls_return_lgort) INDEX 1.
*                IF sy-subrc = 0.
*                    LS_LGOBE = ''.
*                    LV_LGORT = ls_return_lgort-fieldval.
*                    READ TABLE lt_lgort2 INTO DATA(LW_LGORT) WITH KEY LGORT = LV_LGORT .
*                    IF SY-SUBRC = 0 .
*                        LS_LGOBE = LW_LGORT-LGOBE.
*                    ENDIF.
*                    ls_row_lgort-lgort = ls_return_lgort-fieldval.
*                    ls_row_lgort-lgobe = LS_LGOBE.
*                    MODIFY GT_ALV INDEX es_row_no-row_id FROM ls_row_lgort.
*                    CALL METHOD GREF_ALV->refresh_table_display.
*                ENDIF.
*            ENDIF.
*            er_event_data->m_event_handled = abap_true. " báo là đã xử lý F4
*        ENDIF.
*    ENDIF.
  ENDMETHOD.

  METHOD HANDLE_TOOLBAR.
    DATA:
      LS_TOOLBAR TYPE STB_BUTTON.
    "
    LS_TOOLBAR-FUNCTION  = '&ADD'.
    LS_TOOLBAR-ICON      = ICON_ADD_ROW.
    LS_TOOLBAR-BUTN_TYPE = 0.
    LS_TOOLBAR-QUICKINFO = 'Thêm đơn hàng'.
    LS_TOOLBAR-TEXT      = 'Thêm'.
    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = '&EDIT'.
    LS_TOOLBAR-ICON      = ICON_EDIT_FILE.
    LS_TOOLBAR-BUTN_TYPE = 0.
    LS_TOOLBAR-QUICKINFO = 'Cập nhập đơn hàng'.
    LS_TOOLBAR-TEXT      = 'Cập nhập'.
    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = '&REMOVE'.
    LS_TOOLBAR-ICON = ICON_REMOVE_ROW.
    LS_TOOLBAR-BUTN_TYPE = 0.
    LS_TOOLBAR-QUICKINFO = 'Xoá đơn hàng'.
    LS_TOOLBAR-TEXT      = 'Xoá'.
    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.
    CLEAR LS_TOOLBAR.



*    AUTHORITY-CHECK OBJECT 'Z_ZBBKTHH'
*                    ID 'ACTVT' FIELD '*'.
*    IF sy-subrc IS INITIAL.
*      ls_toolbar-function  = '&PMH'.
*      ls_toolbar-text      = 'KHVT/PMH'.
*      ls_toolbar-butn_type = 0.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
*      CLEAR ls_toolbar.
*    ENDIF.

  ENDMETHOD. "handle_toolbar

  METHOD HANDLE_USER_COMMAND.
    DATA: LW_COUNT TYPE I,
          LV_COUNT TYPE I,
          LW_LINES TYPE I.

    CASE E_UCOMM.
      WHEN '&ADD'.
        PERFORM ADD_ORDER_DT .
      WHEN '&EDIT'.
*        PERFORM DESELECT_ALL_DT .
        PERFORM EDIT_ORDER_DT .
      WHEN '&REMOVE'.
          PERFORM REMOVE_ALL_DT.

*      WHEN '&PRT'.
*        REFRESH: gt_sf.
*        LOOP AT gt_data INTO DATA(ls_data) WHERE select = abap_true.
*          APPEND ls_data TO gt_sf.
*        ENDLOOP.
*        SORT gt_sf BY vbeln_im.
*        DATA(lt_sf) = gt_sf.
*        DELETE ADJACENT DUPLICATES FROM lt_sf COMPARING vbeln_im.
*        IF NOT rb_kthh IS INITIAL.
*          lv_count = 0.
*          LOOP AT lt_sf ASSIGNING FIELD-SYMBOL(<fs_gt_sf>).
*            LOOP AT lt_sf ASSIGNING FIELD-SYMBOL(<fs_inner>) WHERE vbeln_im = <fs_gt_sf>-vbeln_im.
*              lv_count = lv_count + 1.
*            ENDLOOP.
*
*            IF lv_count <> 1.
*              " Hiển thị thông báo lỗi
*              MESSAGE 'Vui lòng chọn cùng 1 Inbound Delivery' TYPE 'S' DISPLAY LIKE 'E'.
*              LEAVE TO SCREEN 100.
*            ENDIF.
*          ENDLOOP.
*          LOOP AT gt_sf TRANSPORTING NO FIELDS WHERE sl_maukt IS NOT INITIAL.
*            ADD 1 TO lw_count.
*          ENDLOOP.
*
*          IF sy-subrc EQ 0.
*            DESCRIBE TABLE gt_sf LINES lw_lines.
*            iv_formname = 'ZQM_EX_BBKTHH_3'.
*            gp_smartform = 'YQM_SF_BBKTHH_3'.   "Added 2024.08.27-24.09.09 Số lượng mẫu kiểm tra” tại màn hình trung gian khác rỗng(<>0) by acg.huuphuoc
*            gs_soluong_mau_kiemtra_isnull = 'ISNOTNULL' .   "Added 2024.08.27 Số lượng mẫu kiểm tra”
*          ELSE.
*            CLEAR lw_count.
*            iv_formname = 'ZQM_EX_BBKTHH_1'.
*            gp_smartform = 'YQM_SF_BBKTHH_1'.   "ADDED 2024.08.27-24.09.09. “Số lượng mẫu kiểm tra” tại màn hình trung gian bang rỗng(=0) by acg.huuphuoc
*            gs_soluong_mau_kiemtra_isnull = 'ISNULL' .   "Added 2024.08.27 Số lượng mẫu kiểm tra”
*          ENDIF.
*        ENDIF.
*        DELETE ADJACENT DUPLICATES FROM gt_sf COMPARING vbeln_im .
*        IF gt_sf IS NOT INITIAL.
**          IF LW_COUNT EQ LW_LINES.
*          PERFORM pmh_mota.
*          PERFORM export_excel.
**          ELSE.
**            MESSAGE 'Vui lòng điền số lượng mẫu kiểm tra' TYPE 'S'.
**          ENDIF.
*        ELSE.
*          MESSAGE 'Chọn dòng in!' TYPE 'S'.
*        ENDIF.
*      WHEN '&PMH'.
*        AUTHORITY-CHECK OBJECT 'Z_ZBBKTHH'
*        ID 'ACTVT' FIELD '*'.
*        IF sy-subrc IS NOT INITIAL.
*          MESSAGE 'User no Authorization!' TYPE 'S' DISPLAY LIKE 'E'.
*        ELSE.
*          gv_flag = 1.
*          PERFORM pmh_mota.
*        ENDIF.
    ENDCASE.
*
*    PERFORM refresh_alv USING gref_alv gs_layout.

  ENDMETHOD.

ENDCLASS. "lcl_event_receiver IMPLEMENTATION


*---------------------------------------------------------------------*
*       CLASS lcl_handle_events2 DEFINITION
*---------------------------------------------------------------------*
* §5.1 define a local class for handling events of cl_salv_table
*---------------------------------------------------------------------*
CLASS LCL_HANDLE_EVENTS2 DEFINITION.
  PUBLIC SECTION.
    METHODS:
      ON_USER_COMMAND2 FOR EVENT ADDED_FUNCTION OF CL_SALV_EVENTS
        IMPORTING E_SALV_FUNCTION.
ENDCLASS.                    "lcl_handle_events DEFINITION
*---------------------------------------------------------------------*
*       CLASS lcl_handle_events2 IMPLEMENTATION
*---------------------------------------------------------------------*
* §5.2 implement the events for handling the events of cl_salv_table
*---------------------------------------------------------------------*
CLASS LCL_HANDLE_EVENTS2 IMPLEMENTATION.
  METHOD ON_USER_COMMAND2.

*   execute function
    CASE E_SALV_FUNCTION.
      WHEN 'CANC'.
*       leave popup
*       - (currently) not supported via code &AC1
        GR_GRID_3000->CLOSE_SCREEN( ).
        FREE GR_GRID_3000.
      WHEN OTHERS.
*       currently no further commands supported
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

FORM SETUP_MENU1 .

  DATA LT_FUNCTIONS TYPE UI_FUNCTIONS.

  IF GR_CONTAINER IS INITIAL.
    CREATE OBJECT GR_CONTAINER
      EXPORTING
        CONTAINER_NAME = 'CONTAINER'.
    CREATE OBJECT GR_GRID
    "m?i ALV dùng d?i tu?ng ALV khac - GR_GRID
      EXPORTING
        I_PARENT = GR_CONTAINER.
     APPEND:
      CL_GUI_ALV_GRID=>MC_FC_LOC_CUT TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_COPY TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE_NEW_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_UNDO TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW TO LT_FUNCTIONS.

      PERFORM CAL_THANHTIEN.

    CALL METHOD GR_GRID->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_LAYOUT       = GS_LAYOUT
        IT_TOOLBAR_EXCLUDING = LT_FUNCTIONS
      CHANGING
        IT_OUTTAB       = GT_ALV
        IT_FIELDCATALOG = GT_FIELDCAT.

    PERFORM CAL_THANHTIEN.

  ELSE.
    CALL METHOD GR_GRID->REFRESH_TABLE_DISPLAY( ).
    PERFORM CAL_THANHTIEN.
  ENDIF.



ENDFORM.

FORM SETUP_MENU2 .
  DATA: LS_STABLE TYPE LVC_S_STBL.
  DATA: LT_FUNCTIONS TYPE UI_FUNCTIONS,
        LS_VARIANT   TYPE DISVARIANT.

  LS_STABLE-ROW = 'X'.
  LS_STABLE-COL = 'X'.

  IF GO_CONTAINER IS NOT BOUND.
    GO_CONTAINER = NEW CL_GUI_CUSTOM_CONTAINER(
    CONTAINER_NAME = GC_SCRFNAME_DT ).

    GREF_ALV_3000 = NEW CL_GUI_ALV_GRID(
    I_PARENT = GO_CONTAINER ).

    GREF_ALV_3000->REGISTER_EDIT_EVENT(
    I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED ).

    GREF_ALV_3000->REGISTER_EDIT_EVENT(
    I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER ).

    LS_VARIANT-REPORT = SY-REPID.

    CREATE OBJECT GR_EVENTS.
    SET HANDLER :
*      GR_EVENTS->HANDLE_DATA_CHANGED_F FOR GREF_ALV_3000,
*      GR_EVENTS->HANDLE_BUTTON_CLICK FOR GREF_ALV_3000,
*      GR_EVENTS->HANDLE_HOTSPOT_CLICK_F FOR GREF_ALV_3000,
      GR_EVENTS->HANDLE_DATA_CHANGED FOR GREF_ALV_3000,
      GR_EVENTS->HANDLE_TOOLBAR FOR GREF_ALV_3000,
      GR_EVENTS->HANDLE_USER_COMMAND FOR GREF_ALV_3000.
*      GR_EVENTS->ON_F4_SAP FOR GREF_ALV_3000,
    APPEND:
      CL_GUI_ALV_GRID=>MC_FC_LOC_CUT TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_COPY TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_PASTE_NEW_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_UNDO TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW TO LT_FUNCTIONS,
      CL_GUI_ALV_GRID=>MC_FC_LOC_COPY_ROW TO LT_FUNCTIONS.

    CALL METHOD GREF_ALV_3000->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_VARIANT                    = LS_VARIANT
        I_SAVE                        = 'A'
        IS_LAYOUT                     = GS_LAYOUT_3000
        IT_TOOLBAR_EXCLUDING          = LT_FUNCTIONS
      CHANGING
        IT_OUTTAB                     = GT_ALV_3000
        IT_FIELDCATALOG               = GT_FIELDCAT_3000
      EXCEPTIONS
        INVALID_PARAMETER_COMBINATION = 1
        PROGRAM_ERROR                 = 2
        TOO_MANY_LINES                = 3
        OTHERS                        = 4.

  ELSE.
    GREF_ALV_3000->SET_FRONTEND_LAYOUT( IS_LAYOUT = GS_LAYOUT_3000 ).
    GREF_ALV_3000->REFRESH_TABLE_DISPLAY(
      EXPORTING
        IS_STABLE = LS_STABLE     " With Stable Rows/Columns
*        I_SOFT_REFRESH = I_SOFT_REFRESH " Without Sort, Filter, etc.
      EXCEPTIONS
        FINISHED  = 1              " Display was Ended (by Export)
        OTHERS    = 2
    ).
    IF SY-SUBRC <> 0.
      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
        WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form SELECT_ALL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SELECT_ALL_DT .
  DATA: LT_FILTER TYPE LVC_T_FIDX,
        LS_FILTER TYPE LINE OF LVC_T_FIDX.
  "-----------------------------

  CALL METHOD GREF_ALV->GET_FILTERED_ENTRIES
    IMPORTING
      ET_FILTERED_ENTRIES = LT_FILTER.
  "
  IF LT_FILTER IS NOT INITIAL.
    LOOP AT GT_ALV ASSIGNING FIELD-SYMBOL(<LF_DATA>).
      READ TABLE LT_FILTER INTO LS_FILTER WITH KEY TABLE_LINE = SY-TABIX.
      IF SY-SUBRC EQ 0.
        <LF_DATA>-CHECK = ''.
      ELSE.
        <LF_DATA>-CHECK = 'X'.
      ENDIF.
    ENDLOOP.
  ELSE.
    LOOP AT GT_ALV ASSIGNING FIELD-SYMBOL(<LF_DATA2>).
      <LF_DATA2>-CHECK = 'X'.
    ENDLOOP.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DESELECT_ALL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DESELECT_ALL_DT .

  LOOP AT GT_ALV ASSIGNING FIELD-SYMBOL(<LFS_DATA>).
    <LFS_DATA>-CHECK = ABAP_FALSE.
  ENDLOOP.

ENDFORM.

FORM REFRESH_ALV_DT.
  DATA: LS_STABLE TYPE LVC_S_STBL.
  LS_STABLE = 'XX'.
  "-------------

  GREF_ALV_3000->SET_FRONTEND_LAYOUT( IS_LAYOUT = GS_LAYOUT_3000 ).
  GREF_ALV_3000->REFRESH_TABLE_DISPLAY(
    EXPORTING
      IS_STABLE = LS_STABLE     " With Stable Rows/Columns
*         I_SOFT_REFRESH = I_SOFT_REFRESH " Without Sort, Filter, etc.
    EXCEPTIONS
      FINISHED  = 1              " Display was Ended (by Export)
      OTHERS    = 2
  ).
  IF SY-SUBRC <> 0.
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
      WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

*  REFRESH GT_ALV.
*  PERFORM GET_DATA.
*  PERFORM REFRESH_GRID USING 'GET_DATA'.

ENDFORM.

FORM REFRESH_ALV_AFTER_SAVE.

  REFRESH GT_ALV.
  PERFORM GET_DATA.
  PERFORM REFRESH_GRID USING 'GET_DATA'.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  event_data_changed
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM EVENT_DATA_CHANGED USING ER_DATA_CHANGED
                              TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL
                                    E_ONF4
                                    E_ONF4_BEFORE
                                    E_ONF4_AFTER.           "#EC *
  DATA: LV_HHID      TYPE YTB_HANG-HHID,
        LV_DONGIA    TYPE YTB_DOND-DONGIA,
        LV_SOLUONG   TYPE YTB_DOND-SOLUONG,
        LV_THANHTIEN TYPE YST_LINH4_MATERIAL-THANHTIEN,
        LS_HANG      TYPE YTB_HANG.

  LOOP AT ER_DATA_CHANGED->MT_MOD_CELLS INTO DATA(LS_CELL).
    if LS_CELL-FIELDNAME = 'HHID'.

    CLEAR: LV_HHID, LS_HANG.
    LV_HHID = LS_CELL-VALUE.


    IF LV_HHID IS NOT INITIAL.
      SELECT SINGLE * FROM YTB_HANG WHERE HHID = @LV_HHID INTO @LS_HANG.

      IF SY-SUBRC <> 0.
        ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY(
          I_MSGID     = '0K'
          I_MSGNO     = '001'
          I_MSGTY     = 'E'
          I_MSGV1     = 'ID hàng hóa không ton tai'
          I_FIELDNAME = 'HHID'
          I_ROW_ID    = LS_CELL-ROW_ID
        ).
      ENDIF.
    ENDIF.

    ER_DATA_CHANGED->MODIFY_CELL(
      I_ROW_ID = LS_CELL-ROW_ID
      I_FIELDNAME = 'MAHANG'
      I_VALUE = LS_HANG-MAHANG
    ).

    ER_DATA_CHANGED->MODIFY_CELL(
      I_ROW_ID = LS_CELL-ROW_ID
      I_FIELDNAME = 'TENHANG'
      I_VALUE = LS_HANG-TENHANG
    ).

    ER_DATA_CHANGED->MODIFY_CELL(
      I_ROW_ID = LS_CELL-ROW_ID
      I_FIELDNAME = 'DVT'
      I_VALUE = LS_HANG-DVT
    ).


    elseIF LS_CELL-FIELDNAME = 'SOLUONG' or LS_CELL-FIELDNAME = 'DONGIA'.
      CLEAR: LV_SOLUONG, LV_DONGIA, LV_THANHTIEN.

      ER_DATA_CHANGED->GET_CELL_VALUE(
        EXPORTING
          I_ROW_ID = LS_CELL-ROW_ID
          I_FIELDNAME = 'SOLUONG'
        IMPORTING
          E_VALUE = LV_SOLUONG
      ).

      ER_DATA_CHANGED->GET_CELL_VALUE(
        EXPORTING
          I_ROW_ID = LS_CELL-ROW_ID
          I_FIELDNAME = 'DONGIA'
        IMPORTING
          E_VALUE = LV_DONGIA
      ).

      LV_THANHTIEN = LV_SOLUONG * LV_DONGIA.

      ER_DATA_CHANGED->MODIFY_CELL(
        I_ROW_ID = LS_CELL-ROW_ID
        I_FIELDNAME = 'THANHTIEN'
        I_VALUE = LV_THANHTIEN
      ).
    ENDIF.
*
  ENDLOOP.

  "OTHER CASE IF HAVE...

ENDFORM.                    " d0100_event_data_changed


*&---------------------------------------------------------------------*
*& Form HANDLE_DATA_CHANGED_FINISHED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_MODIFIED
*&      --> ET_GOOD_CELLS
*&---------------------------------------------------------------------*
FORM HANDLE_DATA_CHANGED_FINISHED  USING E_MODIFIED TYPE CHAR01   "
                                        ET_GOOD_CELLS TYPE LVC_T_MODI.

*  DATA: LS_MESS TYPE TEXT255.
*  DATA: LT_DATASET TYPE TABLE OF GTY_DATASET,
*        LW_DATASET TYPE          GTY_DATASET.
*
*  DATA: LS_TENLOAI  TYPE YDE_MOTA_LOAI,
*        LS_MALOAI   TYPE CHAR20 .
*
*  DATA: LD_SOCONT TYPE YDE_MATQTY . "WITH 3 DECIMAL
*  DATA: LD_DATE   TYPE DATS.
*  "
*  CHECK E_MODIFIED = 'X'.
*  TRY.
*      DATA(LS_GOOD_CELLS) = ET_GOOD_CELLS[ 1 ].
*      "
*      IF LS_GOOD_CELLS-FIELDNAME = 'KHOTONG' .
*            SELECT *
*            INTO CORRESPONDING FIELDS OF TABLE LT_DATASET
*            FROM YTB_DATASET
*            WHERE STABLE = 'SLOCAPAC'
*            AND SFIELD = 'KHOTONG' .
*            "
*            READ TABLE GT_ALV ASSIGNING FIELD-SYMBOL(<FS_DCCN>) INDEX LS_GOOD_CELLS-ROW_ID.
*            IF SY-SUBRC = 0 .
*                READ TABLE LT_DATASET INTO LW_DATASET WITH KEY SFIELD = 'KHOTONG' DATANO = <FS_DCCN>-KHOTONG .
*                IF SY-SUBRC = 0 .
*                    <FS_DCCN>-DATANAME = LW_DATASET-DATANAME .
*                ELSE.
*                    <FS_DCCN>-DATANAME = ''.
*                ENDIF.
*            ENDIF.
*            PERFORM REFRESH_ALV.
*            MESSAGE 'OF1.Data changed for khu vực tổng' TYPE 'S'.
*
*      ELSEIF LS_GOOD_CELLS-FIELDNAME = 'MALOAI' .
*            LS_MALOAI = LS_GOOD_CELLS-VALUE .
*            SELECT SINGLE TENLOAI
*            FROM YTB_LOAIHANG
*            WHERE LOAI = 'LOAIHANG'
*            AND MALOAI = @LS_MALOAI
*            INTO @LS_TENLOAI .
*            IF SY-SUBRC <> 0.
*                READ TABLE GT_ALV ASSIGNING FIELD-SYMBOL(<FS_LH1>) INDEX LS_GOOD_CELLS-ROW_ID.
*                IF SY-SUBRC = 0 .
*                    <FS_LH1>-TENLOAI = ''.
*                ENDIF.
*                "
*                MESSAGE 'Mã Loại hàng không tồn tại' TYPE 'S' DISPLAY LIKE 'E'.
*                EXIT.
*            ELSE.
*                READ TABLE GT_ALV ASSIGNING FIELD-SYMBOL(<FS_LH2>) INDEX LS_GOOD_CELLS-ROW_ID.
*                IF SY-SUBRC = 0 .
*                    <FS_LH2>-TENLOAI = LS_TENLOAI.
*                ENDIF.
*                PERFORM REFRESH_ALV.
*                MESSAGE 'OF5.Data changed for Loại hàng' TYPE 'S'.
*            ENDIF.
*
*      ELSEIF LS_GOOD_CELLS-FIELDNAME = 'M3QTY' OR LS_GOOD_CELLS-FIELDNAME = 'M3CONT'.
*            READ TABLE GT_ALV ASSIGNING FIELD-SYMBOL(<FS_DAT>) INDEX LS_GOOD_CELLS-ROW_ID.
*            IF SY-SUBRC = 0 .
*                IF <FS_DAT>-M3CONT <> 0 .
*                    <FS_DAT>-SOCONT = <FS_DAT>-M3QTY / <FS_DAT>-M3CONT .
*                ENDIF.
*            ENDIF.
*            PERFORM REFRESH_ALV.
*            MESSAGE 'OF2.Data changed for Số Cont' TYPE 'S'.
*
*      ELSEIF LS_GOOD_CELLS-FIELDNAME = 'M3QTY' OR LS_GOOD_CELLS-FIELDNAME = 'M3PACK'.
*            READ TABLE GT_ALV ASSIGNING FIELD-SYMBOL(<FS_DAT2>) INDEX LS_GOOD_CELLS-ROW_ID.
*            IF SY-SUBRC = 0 .
*                IF <FS_DAT2>-M3PACK <> 0 .
*                    <FS_DAT2>-SOPACK = <FS_DAT2>-M3QTY / <FS_DAT2>-M3PACK .
*                ENDIF.
*            ENDIF.
*            PERFORM REFRESH_ALV.
*            MESSAGE 'OF3.Data changed for Số Pack' TYPE 'S'.
*      ENDIF .
*    CATCH CX_SY_ITAB_LINE_NOT_FOUND.
*  ENDTRY.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form HANDLE_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ES_ROW_NO
*&      --> E_ROW_ID
*&      --> E_COLUMN_ID
*&---------------------------------------------------------------------*
FORM HANDLE_HOTSPOT_CLICK  USING    E_ROW_ID     TYPE  LVC_S_ROW
                                    E_COLUMN_ID  TYPE  LVC_S_COL
                                    ES_ROW_NO    TYPE  LVC_S_ROID.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form HANDLE_BUTTON_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ES_COL_ID
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM HANDLE_BUTTON_CLICK  USING    ES_COL_ID TYPE	LVC_S_COL
                                   ES_ROW_NO TYPE	LVC_S_ROID.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form refresh_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH_ALV .

  DATA: LS_STABLE TYPE LVC_S_STBL.
  LS_STABLE = 'XX'.

  GR_GRID->SET_FRONTEND_LAYOUT( IS_LAYOUT = GS_LAYOUT ).
  GR_GRID->REFRESH_TABLE_DISPLAY(

    EXPORTING
      IS_STABLE = LS_STABLE
    EXCEPTIONS
      FINISHED = 1
      OTHERS = 2
   ).

  IF SY-SUBRC <> 0.
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form SETUP_MENU2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form ADD_ORDER_DT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM ADD_ORDER_DT .
  PERFORM CREATE_GRIDROW.
  PERFORM REFRESH_ALV_DT.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form EDIT_ORDER_DT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM EDIT_ORDER_DT .
  PERFORM CHANGE_GRIDROW.
  PERFORM REFRESH_ALV_DT.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REMOVE_ALL_DT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REMOVE_ALL_DT .
  PERFORM REMOVE_GRIDROW.
  PERFORM REFRESH_ALV_DT.
ENDFORM.
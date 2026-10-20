# SELL-ORDER

Mã nguồn ABAP báo cáo đơn hàng bán bằng ALV.

- Chương trình chính: `src/YPG_LINH3.prog.abap`.
- Toàn bộ 7 include `YIN_LINH3_*`, gồm TOP, CLASS, CLC, CLS, F01, PBO và PAI. Include CLS được lưu kèm dù chương trình chính hiện không gọi.
- Xuất từ phiên bản active trên SAP, không bao gồm thay đổi chưa lưu trong editor.

## Thành phần SAP cần có

- Bảng `YTB_HANG`, `YTB_DONH`, `YTB_DOND` và bảng chuẩn `KNA1`, `T001`.
- Cấu trúc `YST_LINH3_MATERIAL`, `YST_LINH4_MATERIAL`, `YST_LINH4_MATERIAL_IO`, `ZCORE_ST_PARAMETER`; kiểu `ZTTIEN`.
- Smart Form `YSF_LINH3_DONHANG` để in đơn hàng.
- Screen `2000`, `3000`; custom control `CONTAINER`, `CONTAINER3`.
- GUI status `TOOLBAR2000`, `TOOLBAR3000`; title `TITLE2000`, `TITLE3000`.

Định nghĩa DDIC, screen layout/flow logic, GUI status, title và text elements chưa được xuất. Repository là bản lưu mã nguồn, chưa phải gói abapGit hoàn chỉnh.

## Cập nhật ngày 20/10/2026

Đồng bộ mã nguồn active từ SAP: bổ sung in một đơn hàng được chọn bằng Smart Form, cập nhật DHID khi sửa đơn hàng và loại bỏ lệnh xóa đơn hàng cố định tại START-OF-SELECTION. Bản xuất giữ nguyên mã nguồn SAP; việc xuất không thực thi chương trình.

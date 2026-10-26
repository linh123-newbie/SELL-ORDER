# SELL-ORDER

Mã nguồn ABAP báo cáo đơn hàng bán bằng ALV.

- Chương trình chính: `src/YPG_LINH3.prog.abap`.
- Include `src/Z_VN_CURRENCY.prog.abap` chuyển số tiền VND thành chữ tiếng Việt.
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

## Cập nhật ngày 26/10/2026

Đồng bộ lại chương trình chính và toàn bộ include từ SAP. `YIN_LINH3_F01` cập nhật phần in nhiều đơn hàng trong một phiên Smart Form, số thứ tự trang và chuyển tiền thành chữ bằng `VND_TO_TEXT`. `YPG_LINH3` bổ sung `INCLUDE Z_VN_CURRENCY`; mã nguồn include này được lưu kèm trong `src`. Bản xuất giữ nguyên mã nguồn SAP và chưa được kiểm thử chạy/in đơn hàng.

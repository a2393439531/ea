package com.app.exam.util;

import org.apache.poi.hssf.usermodel.HSSFCell;

public class ExcelUtil {

	public static String getCellStringValue(HSSFCell cell) {
		String cellValue = "";
		if (cell == null) {
			return "";
		}
		switch (cell.getCellType()) {
		case HSSFCell.CELL_TYPE_STRING:
			cellValue = cell.getRichStringCellValue().getString();
			if (cellValue.trim().equals("") || cellValue.trim().length() <= 0)
				cellValue = "";
			break;
		case HSSFCell.CELL_TYPE_NUMERIC:
			cellValue = String.valueOf((int) cell.getNumericCellValue());
			break;
		case HSSFCell.CELL_TYPE_FORMULA:
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cellValue = String.valueOf(cell.getNumericCellValue());
			break;
		case HSSFCell.CELL_TYPE_BLANK:
			cellValue = "";
			break;
		case HSSFCell.CELL_TYPE_BOOLEAN:
			break;
		case HSSFCell.CELL_TYPE_ERROR:
			break;
		default:
			break;
		}
		return cellValue;
	}
}

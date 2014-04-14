package com.poi;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class PoiDemoTest {
	/**
	 * 生成一个常规的excel
	 * 
	 * @throws IOException
	 * 
	 * */
	public void generateExcel() throws IOException {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("Test");

		HSSFRow row = sheet.createRow(0);

		HSSFCell cell = row.createCell(0);

		cell.setCellValue("Test");

		FileOutputStream fileOut = new FileOutputStream("workbook.xls");

		workbook.write(fileOut);
	}

	public static void main(String[] args) throws IOException {
		PoiDemoTest pdt = new PoiDemoTest();
		pdt.generateExcel();
	}
}

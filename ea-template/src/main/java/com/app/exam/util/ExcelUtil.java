package com.app.exam.util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;

import com.app.exam.model.Examrecord;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Result;

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
	
	public static void exportToExcel(Paper paper, OutputStream os){
		Set<Examrecord> examrecords = paper.getResultdetail();
		HSSFWorkbook workbook = new HSSFWorkbook();
		Map<String, Set<Result>> map = new HashMap<String, Set<Result>>();
		for (Examrecord examrecord : examrecords) {
			String username = examrecord.getUserid();
			Set<Result> results = map.get(username);
			if(results == null){
				results = new HashSet<Result>();
			}
			results.addAll(examrecord.getResult());
			map.put(username, results);
		}
		Set<String> usernames = map.keySet();
		
		for (String username : usernames) {
			Map<Knowledge,Set<Result>> dataMap = new HashMap<Knowledge,Set<Result>>();
			HSSFSheet sheet = workbook.createSheet(username);
			Set<Result> results = map.get(username);
			Set<Result> resultdata = null;
			for (Result result : results) {
				Item item = result.getItem();
				Set<Knowledge> knowledges = item.getKnowledge();
				for (Knowledge knowledge : knowledges) {
					resultdata = (Set<Result>) dataMap.get(knowledge);
					if(resultdata == null){
						resultdata = new HashSet<Result>();
					}
					resultdata.add(result);
					dataMap.put(knowledge, resultdata);
				}
			}
			//dataMap已经有数据
			if(dataMap.size() > 0){
	            HSSFRow firstrow = sheet.createRow(1);
	            HSSFCell cell = null;
	            String[] names = {"Category", "Question", "Date" ,"Score", "", "Category", "Total Score"};
	            
	            HSSFCellStyle style = getUserStyle(workbook, HSSFColor.LIGHT_GREEN.index);
	            
	            //设置头
	            for (int i = 0; i < names.length; i++) {
	                cell = firstrow.createCell(i+1);
	                cell.setCellValue(new HSSFRichTextString(names[i]));
	                cell.setCellStyle(style);
	            }
	            //设置内容
	            Set<Knowledge> knowledges = dataMap.keySet();
	            int r = 2;
	            for (Knowledge knowledge : knowledges) {
	            	//total score
	            	int score = 0;
	            	int j = 2;
	            	//合并单元格
	        		Region region = new Region(r, (short) 1, r+dataMap.get(knowledge).size()-1, (short) 1); 
	        		
	        		sheet.addMergedRegion(region);
	        		
	        		Set<Result> resdata = dataMap.get(knowledge);
	        		
	        		int i = 0;
	        		HSSFRow row = null;
	        		for (Result result : resdata) {
	        			row = sheet.createRow(r + i);
	        			//knowledge
	        			HSSFCell knowledgecell = row.createCell((short) 1);
	        			knowledgecell.setCellValue(knowledge.getName());
	        			//question
	        			HSSFCell questioncell = row.createCell((short) 2);
	        			questioncell.setCellValue(result.getItem().getContent());
	        			//date
	        			HSSFCell datecell = row.createCell((short) 3);
	        			datecell.setCellValue(result.getExamrecord().getRecorddate());
	        			//score
	        			HSSFCell scorecell = row.createCell((short) 4);
	        			scorecell.setCellValue(result.getMark());
	        			score += result.getMark();
	        			i++;
					}
	        		HSSFCell categorycell = row.createCell((short)6);
	        		HSSFCell totalscorecell = row.createCell((short)7);
	        		categorycell.setCellValue(knowledge.getName());
	        		totalscorecell.setCellValue(score);
	        		
	        		r +=  dataMap.get(knowledge).size();
	            }
	            
			}
		}
		try {
			workbook.write(os);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	public static HSSFCellStyle getUserStyle(HSSFWorkbook workBook,short index){
		HSSFCellStyle cellStyle1 = workBook.createCellStyle();
		HSSFFont fontTitle = workBook.createFont();
	    fontTitle.setFontHeightInPoints((short)10);
	    fontTitle.setFontName("Arial");
	    fontTitle.setBoldweight((short)700);
		cellStyle1.setFillForegroundColor(index);
		cellStyle1.setFont(fontTitle);
		cellStyle1.setWrapText(true);
		cellStyle1.setBorderBottom((short)1);
		cellStyle1.setBorderLeft((short)1);
		cellStyle1.setBorderRight((short)1);
		cellStyle1.setBorderTop((short)1);
		cellStyle1.setFillPattern((short)1);
		cellStyle1.setLeftBorderColor((short)8);
		cellStyle1.setRightBorderColor((short)8);
		cellStyle1.setTopBorderColor((short)8);
		cellStyle1.setBottomBorderColor((short)8);
		return cellStyle1;
	}
}

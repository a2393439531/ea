package com.app.exam.util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
	            String[] names = {"Category", "Question", "Score"};
	            HSSFCellStyle style = workbook.createCellStyle();
	            style.setFillBackgroundColor((short) 64);
	            
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
	            	//合并单元格
	        		Region region = new Region(r, (short) 1, r+dataMap.get(knowledge).size()-1, (short) 1); 
	        		
	        		sheet.addMergedRegion(region);
	        		
	        		Set<Result> resdata = dataMap.get(knowledge);
	        		
	        		int i = 0;
	        		for (Result result : resdata) {
	        			HSSFRow row = sheet.createRow(r + i);
	        			//knowledge
	        			HSSFCell knowledgecell = row.createCell((short) 1);
	        			knowledgecell.setCellValue(knowledge.getName());
	        			//question
	        			HSSFCell questioncell = row.createCell((short) 2);
	        			questioncell.setCellValue(result.getItem().getContent());
	        			//score
	        			HSSFCell scorecell = row.createCell((short) 3);
	        			scorecell.setCellValue(result.getMark());
	        			i++;
					}

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
	
}

package com.app.exam.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;

import com.app.common.activiti.api.SpringContext;
import com.app.common.spring.ssh.dao.BaseDao;
import com.app.exam.model.Choiceitem;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;

public class ItemUtil {
	public static void add_psychological_item(String knowledgeid){
		BaseDao baseDao = (BaseDao)SpringContext.getBean("eaDaoTarget");
		Knowledge kn = (Knowledge)baseDao.loadById("Knowledge", Long.valueOf(knowledgeid));
		Set<Knowledge> knset = new HashSet<Knowledge>();
		knset.add(kn);
		if(kn.getItems().size() == 0 && kn.getName().equals("职业性格测试")){
			String itemcontent = "";
			String choiceitemvalue1 = "";
			String choiceitemvalue2 = "";
			String choiceitemvalue3 = "";
			String choiceitemvalue4 = "";
			for (int i = 0; i < 30; i++) {
			
				switch (i) {
				case 0:
					itemcontent = "关于人生观，我的内心其实是";
					choiceitemvalue1 = "希望能有各种各样的人生体验，所以想法极其多样化。";
					choiceitemvalue2 = "在合理的基础上，谨慎确定目标，一旦确定会坚定不移地去做。";
					choiceitemvalue3 = "更加在乎取得一切有可能的成就。";
					choiceitemvalue4 = "毫不喜欢风险，喜欢享受稳定或现状。";
					break;
				case 1:
					itemcontent = "如果爬山旅游，大多数状况下，在下山回来的路线我最可能：";
					choiceitemvalue1 = "好玩有趣，所以宁愿新路线回巢。";
					choiceitemvalue2 = "安全稳妥，所以宁愿原路线返回。";
					choiceitemvalue3 = "挑战困难，所以宁愿新路线回巢。";
					choiceitemvalue4 = "方便省心，所以宁愿原路线返回。";
					break;
				case 2:
					itemcontent = "说话时，我更看重：";
					choiceitemvalue1 = "感觉效果。有时可能会略显得夸张。";
					choiceitemvalue2 = "描述精确。有时可能略过冗长。";
					choiceitemvalue3 = "达成结果。有时可能过于直接让别人不高兴。";
					choiceitemvalue4 = "人际感受。有时可能会不愿讲真话。";
					break;
				case 3:
					itemcontent = "在大多数时候，我的内心更想要：";
					choiceitemvalue1 = "刺激。经常冒出新点子，想做就做，喜欢与众不同。";
					choiceitemvalue2 = "安全。头脑冷静，不易冲动。";
					choiceitemvalue3 = "挑战。生命中竞赛随处可见，有强烈的“赢”的欲望。";
					choiceitemvalue4 = "稳定。满足自己所拥有的，很少羡慕别人。";
					break;
				case 4:
					itemcontent = "我认为自己在情感上的基本特点是：";
					choiceitemvalue1 = "情绪多变，经常波动。";
					choiceitemvalue2 = "外表自我抑制强，但内心感情起伏大，一旦挫伤难以平复。";
					choiceitemvalue3 = "感情不拖泥带水，只是一旦不稳定，容易发怒。";
					choiceitemvalue4 = "天性情绪四平八稳。";
					break;
				case 5:
					itemcontent = "我认为自己除了工作外，在控制欲上面，我：";
					choiceitemvalue1 = "没有控制欲，只有感染带动他人的欲望，但自控能力不算强。";
					choiceitemvalue2 = "用规则来保持我对自己的控制和对他人的要求。";
					choiceitemvalue3 = "内心是有控制欲和希望别人服从我的。";
					choiceitemvalue4 = "没兴趣影响别人，也不愿别人来控制我。";
					break;
				case 6:
					itemcontent = "当与情人交往时，我最希望对方：";
					choiceitemvalue1 = "经常赞美我，让我享受开心、被关怀且又有一定自由。";
					choiceitemvalue2 = "可随时默契到我内心所想，对我的需求极其敏丄感。";
					choiceitemvalue3 = "得到对方的认可，我是正确的并且我对其是有价值的。";
					choiceitemvalue4 = "尊重并且相处静谧的。";
					break;
				case 7:
					itemcontent = "在人际交往时，我：";
					choiceitemvalue1 = "本质上还是认为与人交往比长时间独处是有乐趣的。";
					choiceitemvalue2 = "非常审慎缓慢地进入，常会被人认为容易有距离感。";
					choiceitemvalue3 = "希望在人际关系中占据主导地位。";
					choiceitemvalue4 = "顺其自然，不温不火，相对被动。";
					break;
				case 8:
					itemcontent = "我做事情，经常：";
					choiceitemvalue1 = "缺少长性，不喜欢长期做相同无变化的事情。";
					choiceitemvalue2 = "缺少果断，期待最好的结果但总能先看到事情的不利面。";
					choiceitemvalue3 = "缺少耐性，有时行事过于草率。";
					choiceitemvalue4 = "缺少紧迫，行动迟缓，难下决心。";
					break;
				case 9:
					itemcontent = "通常我完成任务的方式是：";
					choiceitemvalue1 = "通常我完成任务的方式是：";
					choiceitemvalue2 = "自己有严格规定的程序，精确地做，不要麻烦别人。";
					choiceitemvalue3 = "先做，快速做。";
					choiceitemvalue4 = "使用传统的方法按部就班，需要时从他人处得到帮忙。";
					break;
				case 10:
					itemcontent = "如果有人深深惹恼我时，我：";
					choiceitemvalue1 = "内心感到受伤，认为没有原谅的可能，可最终很多时候还是会原谅对方。";
					choiceitemvalue2 = "深深感到愤怒，如此之深怎可忘记？我会牢记，同时未来完全避开那个家伙。";
					choiceitemvalue3 = "会火冒三丈，并且内心期望有机会狠狠地回应。";
					choiceitemvalue4 = "避免摊牌，因为还不到那个地步或者自己再去找新朋友。";
					break;
				case 11:
					itemcontent = "在人际关系中，我最在意的是：";
					choiceitemvalue1 = "在人际关系中，我最在意的是：";
					choiceitemvalue2 = "得到他人的理解和欣赏。";
					choiceitemvalue3 = "得到他人的感激和尊敬。";
					choiceitemvalue4 = "得到他人的尊重和接纳。";
					break;
				case 12:
					itemcontent = "在工作上，我表现出来更多的是：";
					choiceitemvalue1 = "充满热忱，有很多想法且很有灵性。";
					choiceitemvalue2 = "心思细腻，完美精确，而且为人可靠。";
					choiceitemvalue3 = "坚强而直截了当，而且有推动力。";
					choiceitemvalue4 = "有耐心，适应性强而且善于协调。";
					break;
				case 13:
					itemcontent = "我过往的老师最有可能对我的评价是：";
					choiceitemvalue1 = "情绪起伏大，善于表达和抒发情感。";
					choiceitemvalue2 = "严格保护自己的私密，有时会显得孤独或是不合群。";
					choiceitemvalue3 = "动作敏捷又独立，并且喜欢自己做事情。";
					choiceitemvalue4 = "看起来安稳轻松，反应度偏低，比较温和。";
					break;
				case 14:
					itemcontent = "朋友对我的评价最有可能的是：";
					choiceitemvalue1 = "喜欢对朋友述说，也有感染别人的力量。";
					choiceitemvalue2 = "能够提出很多周全的问题，而且需要许多精细的解说。";
					choiceitemvalue3 = "愿意直言想法，有时会直率而犀利地谈论不喜欢的人、事、物。";
					choiceitemvalue4 = "通常与他人一起是倾听者。";
					break;
				case 15:
					itemcontent = "在帮助他人的问题上，我内心的想法是：";
					choiceitemvalue1 = "别人来找我，不太会拒绝，会尽力帮他。";
					choiceitemvalue2 = "值得帮助的人应该帮助。";
					choiceitemvalue3 = "值得帮助的人应该帮助。";
					choiceitemvalue4 = "虽无英雄打虎胆，常有自告奋勇心。";
					break;
				case 16:
					itemcontent = "面对他人对自己的赞美，我内心：";
					choiceitemvalue1 = "没有也无所谓，特别欣喜那也不至于。";
					choiceitemvalue2 = "我不需无关痛痒的赞美，宁可对方欣赏我的能力。";
					choiceitemvalue3 = "思考对方的真实性或立即回避众人的关注。";
					choiceitemvalue4 = "赞美多多益善，总是令人愉悦的。";
					break;
				case 17:
					itemcontent = "面对生活，我更像：";
					choiceitemvalue1 = "随和派－外面的世界我无关，我觉得自己这样还不错。";
					choiceitemvalue2 = "行动派－我不进步，别人就会进步，所以我必须不停地前进。";
					choiceitemvalue3 = "分析派－在问题未发生之前，就该想好所有的可能。";
					choiceitemvalue4 = "无忧派－每天的生活开心快乐最重要。";
					break;
				case 18:
					itemcontent = "对于规则，我内心的态度是：";
					choiceitemvalue1 = "不愿违反规则，但可能因为松散而无法达到规则的要求。";
					choiceitemvalue2 = "打破规则，希望由自己来制定规则而不是遵守规则。";
					choiceitemvalue3 = "严格遵守规则，并且竭尽全力做到规则内的最好。";
					choiceitemvalue4 = "不喜被规则束缚，不按规则出牌会觉得新鲜有趣。";
					break;
				case 19:
					itemcontent = "我认为自己在行为上的基本特点是：";
					choiceitemvalue1 = "慢条斯理，办事按部就班，能与周围的人协调一致。";
					choiceitemvalue2 = "目标明确，集中精力为实现目标而努力，善于抓住核心要点。";
					choiceitemvalue3 = "慎重小心，为做好预防及善后，会不惜一切而尽心操劳。";
					choiceitemvalue4 = "丰富跃动，不喜欢制度和约束，倾向于快速反应。";
					break;
				case 20:
					itemcontent = "当我做错事时，我倾向于：";
					choiceitemvalue1 = "害怕但表面不露声色。";
					choiceitemvalue2 = "不承认而且辩驳，但内心其实已经明白。";
					choiceitemvalue3 = "愧疚和痛苦，容易停留在自我压抑中。";
					choiceitemvalue4 = "难为情，希望逃避别人的批评。";
					break;
				case 21:
					itemcontent = "当结束一段刻骨铭心的感情时，我会：";
					choiceitemvalue1 = "很难受，可日子总要过，时间会冲淡一切的。";
					choiceitemvalue2 = "虽然觉得受伤，但一旦下定决心，就会努力把过去的影子摔掉。";
					choiceitemvalue3 = "深陷在悲伤的情绪中，在相当长的时期里难以自拔，也不愿再接受新的人。";
					choiceitemvalue4 = "痛不欲生，需要找朋友倾诉或者找到渠道发泄，寻求化解之道。";
					break;
				case 22:
					itemcontent = "面对他人的倾诉，我回顾自己大多时候本能上倾向于：";
					choiceitemvalue1 = "能够认同并理解对方当时的感受。";
					choiceitemvalue2 = "快速做出一些定论或判断。";
					choiceitemvalue3 = "给予一些分析或推理，帮助对方理顺思路。";
					choiceitemvalue4 = "可能会随着他的情绪起伏而起伏，也会发表一些评论或意见。";
					break;
				case 23:
					itemcontent = "我在以下哪个群体中交流较感满足？";
					choiceitemvalue1 = "舒服轻松的氛围中，心平气和地最终达成一致结论。";
					choiceitemvalue2 = "彼此展开充分激烈的辩论并有收获。";
					choiceitemvalue3 = "有意义地详细讨论事情的好坏和影响。";
					choiceitemvalue4 = "很开心并且随意无拘束地闲谈。";
					break;
				case 24:
					itemcontent = "在内心的真实想法里，我觉得工作：";
					choiceitemvalue1 = "不必有太大压力，可以让我做我熟悉的工作就很不错。";
					choiceitemvalue2 = "应该以最快的速度完成，且争取去完成更多的任务。";
					choiceitemvalue3 = "要么不做，要做就做到最好。";
					choiceitemvalue4 = "如果能将好玩融合其中那就太棒了，不过如果不喜欢的工作实在没劲。";
					break;
				case 25:
					itemcontent = "如果我是领导，我内心更希望在部属心目中，我是：";
					choiceitemvalue1 = "可以亲近的和善于为他们着想的。";
					choiceitemvalue2 = "有很强的能力和富有领导力的。";
					choiceitemvalue3 = "公平公正且足以信赖的。";
					choiceitemvalue4 = "被他们喜欢并且觉得富有感召力的。";
					break;
				case 26:
					itemcontent = "我对认同的需求是：";
					choiceitemvalue1 = "无论别人是否认同，生活都是要继续的。";
					choiceitemvalue2 = "精英群体的认同最重要。";
					choiceitemvalue3 = "只要我在乎的那些人认同我就足够了。";
					choiceitemvalue4 = "所见之人无论贵贱都对我认同那有多好。";
					break;
				case 27:
					itemcontent = "当我还是个孩子的时候，我：";
					choiceitemvalue1 = "不太会积极尝试新事物，通常比较喜欢旧有的和熟悉的。";
					choiceitemvalue2 = "是孩子王，大家经常听我的决定。";
					choiceitemvalue3 = "害羞见生人，有意识地回避。";
					choiceitemvalue4 = "调皮可爱，乐观而又热心。";
					break;
				case 28:
					itemcontent = "如果我是父母，我也许是：";
					choiceitemvalue1 = "容易说服或者宽容的。";
					choiceitemvalue2 = "比较严厉、性急及说一不二的。";
					choiceitemvalue3 = "坚持自己的想法和比较挑剔的。";
					choiceitemvalue4 = "积极参与到子女中一起玩，被小朋友们们热烈欢迎的。";
					break;
				case 29:
					itemcontent = "以下有四组格言，哪组里整体上最符合我的感觉?";
					choiceitemvalue1 = "最深刻的真理是最简单和最平凡的。要在人世间取得成功必须大智若愚。好脾气是一个人在社交中所能穿着的最佳服饰。知足是人生在世最大的幸福。";
					choiceitemvalue2 = "走自己的路，让人家去说吧。虽然世界充满了苦难，但是苦难总是能战胜的。有所成就是人生唯一的真正的乐趣。对我而言解决一个问题和享受一个假期一样好。";
					choiceitemvalue3 = "一个不注意小事情的人，永远不会成功大事业。理性是灵魂中最高贵的因素。切忌浮夸铺张。与其说得过分，不如说得不全。谨慎比大胆要有力量得多。";
					choiceitemvalue4 = "幸福在于对生命的喜悦和激情。任何时候都要最真实地对待你自己，这比什么都重要。使生活变成幻想，再把幻想化为现实。幸福不在于拥有金钱，而在于获得成就时的喜悦以及产生创造力的激情。";
					break;
				}
				
				Item item1 = new Item();
				item1.setKnowledge(knset);
				item1.setType(1);
				item1.setContent(itemcontent);
				
				Choiceitem ci1 = new Choiceitem();
				ci1.setRefid(1);
				ci1.setValue(choiceitemvalue1);
				ci1.setItem(item1);
				
				Choiceitem ci2 = new Choiceitem();
				ci2.setRefid(2);
				ci2.setValue(choiceitemvalue2);
				ci2.setItem(item1);
				
				Choiceitem ci3 = new Choiceitem();
				ci3.setRefid(3);
				ci3.setValue(choiceitemvalue3);
				ci3.setItem(item1);
				
				Choiceitem ci4 = new Choiceitem();
				ci4.setRefid(4);
				ci4.setValue(choiceitemvalue4);
				ci4.setItem(item1);
				
				
				baseDao.create(item1);
				
				baseDao.create(ci1);
				baseDao.create(ci2);
				baseDao.create(ci3);
				baseDao.create(ci4);
				
			}
			
		}else{
			return;
		}
	}
	
	public static Map<Item,List<Choiceitem>> getDataByXLS(File file){
		BaseDao baseDao = (BaseDao)SpringContext.getBean("eaDaoTarget");
		Map<Item,List<Choiceitem>> data = new HashMap<Item, List<Choiceitem>>();
		HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        try {
			workbook = new HSSFWorkbook(new POIFSFileSystem(new FileInputStream(file)));
			sheet = workbook.getSheetAt(0);// getSheet("Sheet1");
			int rowNum = sheet.getPhysicalNumberOfRows();
			if(rowNum > 0){
				Knowledge rootkn = (Knowledge)baseDao.loadByFieldValue(Knowledge.class, "name", "upload");
				for(int r = 1; r < rowNum; r++){
					row = sheet.getRow(r);
					if(row==null){
						rowNum=rowNum+1;
					}else{
						Item item = new Item();
						List<Choiceitem> choiceitems = null;
						Set<Knowledge> knowledges = new HashSet<Knowledge>();
						//开始读取该行的数据
						int cellNum = row.getLastCellNum();//拿到该行cell数量
						String cellValue = "";
						choiceitems = new ArrayList<Choiceitem>();
						// 这里cellNum要加上1
                        for (short c = 0; c < cellNum + 1; c++){
                        	cell = row.getCell(c);
                        	if (cell != null){
                                cellValue = ExcelUtil.getCellStringValue(cell).trim();
                            }else{
                                continue;
                            }
                        	if ("".equals(cellValue)){
                                continue;
                            }
                        	switch (c) {
							case 0:
								//item Knowledge
								Knowledge kn = (Knowledge)baseDao.loadByFieldValue(Knowledge.class, "name", leftTrim(rightTrim(cellValue)));
								if(kn == null){
									kn = new Knowledge();
									kn.setName(cellValue);
									if(rootkn == null){
										rootkn = new Knowledge();
										rootkn.setName("upload");
										baseDao.create(rootkn);
									}
									kn.setParentModel(rootkn);
									baseDao.create(kn);
								}
								knowledges.add(kn);
								item.setKnowledge(knowledges);
								break;
							case 1:
								//item type
								item.setType(Integer.valueOf(cellValue));
								break;
							case 2:
								//item content
								item.setContent(cellValue);
								break;
							// case 3:
							// //item mark
							// item.setMark(cellValue);
							// break;
							case 3:
								//item refkey
								//if(cellValue.split(",").length > 1){
								//没考虑填空题和问答题的答案情况，先用英文逗号分隔多选题答案
								if(item.getType() == 1 || item.getType() == 2){
									for (String val : cellValue.split(",")) {
										//if(val.matches("[1-" + (cellNum-5) + "]")){
										if (Integer.valueOf(val) >= 1
												&& Integer.valueOf(val) <= (cellNum - c)) {
											if (!"".equals(item.getRefkey())
													&& item.getRefkey() != null) {
												item.setRefkey(item.getRefkey()
														+ "," + val);
											} else {
												item.setRefkey(val);
											}
										}
									}
								}else{
									item.setRefkey(cellValue);
								}
								//}
								break;
							default:
								//choiceitem
								Choiceitem choiceitem = new Choiceitem();
								choiceitem.setValue(cellValue);
								choiceitem.setRefid(c-3);
								
								choiceitems.add(choiceitem);
								break;
							}
                        }
                        data.put(item, choiceitems);
					}
				}
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return data;
	}
	public static Map<String,List<String>> checkDataByXLS(File file){
		Map<String,List<String>> data = new HashMap<String,List<String>>();
		HSSFWorkbook workbook = null;
        HSSFSheet sheet = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        List<String> exception = null;
        try {
			workbook = new HSSFWorkbook(new POIFSFileSystem(new FileInputStream(file)));
			sheet = workbook.getSheetAt(0);// getSheet("Sheet1");
			int rowNum = sheet.getPhysicalNumberOfRows();
			row = sheet.getRow(0);//从第一行判断文件内容
			cell = row.getCell(0);
			String value = ExcelUtil.getCellStringValue(cell);
			if(!value.trim().equalsIgnoreCase("Category")){
				exception = new ArrayList<String>();
	        	exception.add("Please select correct File format!");
	        	data.put("exception", exception);
	        	return data;
			}
			if(rowNum > 0){
				for(int r = 1; r < rowNum; r++){
					exception = new ArrayList<String>();
					row = sheet.getRow(r);
					if(row==null){
						exception.add("The row was null!");
						data.put("Line " + row, exception);
					}else{
						//开始读取该行的数据
						int cellNum = row.getLastCellNum();//拿到该行cell数量，有可能拿到值为空的单元格，所以不一定准确。
						for(int i = cellNum; i >= 0; i--){
							HSSFCell preview = row.getCell(i);
							if(preview == null || "".equals(ExcelUtil.getCellStringValue(preview))){
								cellNum--;
							}else{
								break;
							}
						}
						String cellValue = "";
						// 这里cellNum要加上1
						boolean find = false;
						String columnname = "";
                        for (short c = 0; c < cellNum + 1; c++){
                        	switch(c){
                        		case 0:
                        			columnname = "<strong>Category</strong>";
                        			break;
                        		case 1:
                        			columnname = "<strong>Type</strong>";
                        			break;
                        		case 2:
                        			columnname = "<strong>Content</strong>";
                        			break;
                        		case 3:
                        			columnname = "<strong>Answer</strong>";
                        			break;
                        		default:
                        			columnname = "<strong>Option " + (c-3)+"</strong>";
                        			break;
                        	}
							cell = row.getCell(c);
							
							if (cell == null) {
								if (c == cellNum) {
								} else {
									exception.add("Column " + columnname
											+ " is empty!");
									continue;
								}
							} 
							cellValue = ExcelUtil.getCellStringValue(cell);
							if("".equals(cellValue)){
									exception.add("Column " + columnname
											+ " is empty!");
									continue;
							}
							switch (c) {
							case 3:
								// item refkey
								for (String val : cellValue.split(",")) {
									//if (val.matches("[1-" + (cellNum - 4) + "]")) {
									if (Integer.valueOf(val) >= 1 && Integer.valueOf(val) <= (cellNum - c)) {
									
									} else {
										exception
												.add("The Column <strong>Answer</strong> is not macth the option!");
									}
								}
								break;
							default:
								break;
							}
                        }
					}
					if(exception.size() > 0){
						data.put("Line " + (r+1), exception);
					}
				}
			}else{
				exception = new ArrayList<String>();
				exception.add("The excel was empty!");
				data.put("error", exception);
			}
        } catch (FileNotFoundException e) {
        	exception = new ArrayList<String>();
        	exception.add(e.getMessage());
        	data.put("exception", exception);
		} catch (IOException e) {
			exception = new ArrayList<String>();
        	exception.add(e.getMessage());
        	data.put("exception", exception);
		}catch(Exception e){
			exception = new ArrayList<String>();
        	exception.add(e.toString());
        	data.put("exception", exception);
		}
		return data;
	}
	public static String rightTrim(String s) {
	        if (s == null || s.trim().length() == 0)
	            return null;
	        if (s.trim().length() == s.length())
	            return s;
	        if (!s.startsWith(" ")) {
	            return s.trim();
	        } else {
	            return s.substring(0, s.indexOf(s.trim().substring(0, 1)) + s.trim().length());
	        }
	    }

	    public static String leftTrim(String s) {
	        if (s == null || s.trim().length() == 0)
	            return null;
	        if (s.trim().length() == s.length())
	            return s;
	        if (!s.startsWith(" ")) {
	            return s;
	        } else {
	            return s.substring(s.indexOf(s.trim().substring(0, 1)));
	        }
	    }

		public static void exportTemplate(File templatefile,
				ServletOutputStream os) {
			HSSFWorkbook workbook = null;
			try {
				workbook = new HSSFWorkbook(new POIFSFileSystem(new FileInputStream(templatefile)));
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				workbook.write(os);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
}

package com.app.exam.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.app.common.base.action.BaseEaAction;
import com.app.common.uploadfile.model.Uploadfile;
import com.app.exam.model.Choiceitem;
import com.app.exam.model.Item;
import com.app.exam.model.Knowledge;
import com.app.exam.model.Paper;
import com.app.exam.model.Result;
import com.app.exam.util.ExcelUtil;
import com.app.exam.util.ItemUtil;

@Scope("prototype")
@Component("itemAction")
public class ItemAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(KnowledgeAction.class);
	public Item item = new Item();
	public List<String> choiceitemvalue = new ArrayList<String>();
	public List<String> knowledgevalue = new ArrayList<String>();
	public List<String> itemtype = new ArrayList<String>();
	public List<String> choiceitemid = new ArrayList<String>();

	public String get_list_sql() {
		return "from Item";
	}

	public String list() throws Exception {
		String sql = getSearchSql(get_list_sql());
		String formstyle = getpara("formstyle");
		String divstyle = getpara("divstyle");
		Set<Item> list = new HashSet<Item>();
		Set<Item> data = new HashSet<Item>();
		getPageData(sql);
		if(knowledgevalue.size() != 0){
			for (String knowledge : knowledgevalue) {
				Knowledge kl = (Knowledge)baseDao.loadById("Knowledge", Long.valueOf(knowledge));
				list.addAll(kl.getAllItem(kl));
			}
		}else{
			list.addAll((Collection<? extends Item>) rhs.get("dataList"));
		}

		if(itemtype.size() != 0 &&list.size() != 0){
			for (String type : itemtype) {
				for (Item item : list) {
					if(item.getType() == Integer.valueOf(type)){
						data.add(item);
					}
				}
			}
		}else{
			data.addAll(list);
		}
		rhs.put("knowledgevalue", knowledgevalue);
		rhs.put("itemtype", itemtype);
		rhs.put("dataList", data);
		rhs.put("formstyle", "".equals(formstyle)? "none":formstyle);
		rhs.put("divstyle", "".equals(divstyle)? "0 10px 0 0":divstyle);
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		return "success";
	}
	
	public String listbycondition() throws Exception{
		Set<Item> dataList = new HashSet<Item>();
		
		String knowledgesid = getpara("knowledgesid");
		String type = getpara("type");
		String paperid = getpara("templateid");
		Paper paper = (Paper)baseDao.loadById("Paper", Long.valueOf(paperid));
		
		String[] knowledgeid = knowledgesid.split(",");
		
		for(int i = 0; i < knowledgeid.length; i++ ){
			
			Knowledge knowledge = (Knowledge) baseDao.loadById("Knowledge", Long.valueOf(knowledgeid[i]));
			
			Collection<Item> itemlist = knowledge.getItems();
			
			for (Item item : itemlist) {
				//有分值的题目不能被复用，因为是通过excel上传的 -->取消
				if(type.equals(String.valueOf(item.getType()))){
					dataList.add(item);
				}
			}
		}
		
		if(dataList.size() == 0){
			rhs.put("info", "The Category has no question!");
		}
		rhs.put("itemlist", dataList);
		rhs.put("paper",paper);
		return "success";
		
	}

	public String save() throws Exception {
		List<Choiceitem> choiceitem = new ArrayList<Choiceitem>();
		Set<Knowledge> knowledge = new HashSet<Knowledge>();

		List<Knowledge> knowledgerootlist = common_get_tree_root("Knowledge");
		String method = getpara("method");
		if ("show".equals(method)) {
			rhs.put("knowledgeRootList", knowledgerootlist);
			rhs.put("page", "addpage");
			return "success";
		} else {
			if("".equals(item.getId()) || item.getId() == null){
				baseDao.create(item);
			}else{
				String content = item.getContent();
				String refkey = item.getRefkey();
				//String score = item.getMark();
				int type = item.getType();
				item = (Item)baseDao.loadById("Item", item.getId());
				item.setContent(content);
				item.setRefkey(refkey);
				//item.setMark(score);
				item.setType(type);
			}
			if (knowledgevalue.size() > 0) {
				for (String klv : knowledgevalue) {
					Knowledge kn = getKnowledgeById(knowledgerootlist, klv);
					knowledge.add(kn);
				}
				item.setKnowledge(knowledge);// 添加知识领域
			}else{
				item.setKnowledge(null);
			}
			if (choiceitemvalue.size() >= 2) {
				int i = 1;
				for (int j = 0; j < choiceitemvalue.size(); j++) {
					Choiceitem ci = null;
					if(choiceitemid.size() > 0){
						for (int k = j; k < choiceitemid.size();) {
							String id = choiceitemid.get(k);
							if(!"".equals(id) && id != null){
								ci = (Choiceitem) baseDao.loadById("Choiceitem", Long.parseLong(id));
							}else{
								if(!"".equals(choiceitemvalue.get(j))){
									ci = new Choiceitem();
									ci.setRefid(k+1);
									baseDao.create(ci);
								}else{
									break;
								}
							}
							ci.setItem(item);
							ci.setValue(choiceitemvalue.get(j));
							baseDao.update(ci);
							choiceitem.add(ci);
							break;
						}
					}else{
						if(!"".equals(choiceitemvalue.get(j))){
							ci = new Choiceitem();
							ci.setItem(item);
							ci.setRefid(i);
							ci.setValue(choiceitemvalue.get(j));
							baseDao.create(ci);
							choiceitem.add(ci);
						}
						i++;
					}
				}
				item.setChoiceitem(choiceitem);// 添加选项
			}
			item.setCreateuser(getCurrentAccount());// 添加创建人
			rhs.put("page", "editpage");
		}
		baseDao.update(item);
		knowledgevalue.clear();
		return list();
	}

	public String load() throws Exception {
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		if (!getpara("id").equals("")) {
			Item item = (Item) baseDao.loadById("Item",
					Long.parseLong(getpara("id")));
			rhs.put("item", item);
			if("show".equals(getpara("method"))){
				rhs.put("readonly", true);
			}else if("edit".equals(getpara("method"))){
				rhs.put("readonly", false);
			}
		} 
		rhs.put("method", getpara("method"));
		return "success";
	}

	public String add_psychological_item() throws Exception{
		ItemUtil.add_psychological_item("9");
		rhs.put("page", "editpage");
		return list();
	}
	
	public String delete() throws Exception{
		String id = getpara("id");
		boolean find = false;
		Item item = (Item) baseDao.loadById("Item", Long.parseLong(id));
		//判断Item是不是已经有result了，如果有了，则不让删除
		String sql = "from Result";
		getPageData(sql);
		List<Result> list = (List<Result>) rhs.get("dataList");
		for (Result result : list) {
			Item tmpitem = result.getItem();
			if(tmpitem.getId() == Long.valueOf(id)){
				find = true;
				break;
			}
		}
		//判断Item是不是已经被选为必做题了，如果有了，则不能删除
		Set<Paper> tmppaper = item.getPapers();
		if(tmppaper.size() > 0){
			find = true;
		}
		//end
		if (!find) {
			Set<Paper> papers = item.getPapers();
			for (Paper paper : papers) {
				switch (item.getType()) {
				case 1:
					paper.setSinglechoice(paper.getSinglechoice() - 1);
					break;
				case 2:
					paper.setMultichoice(paper.getMultichoice() - 1);
					break;
				case 3:
					paper.setBlank(paper.getBlank() - 1);
					break;
				case 4:
					paper.setEssay(paper.getEssay() - 1);
					break;
				}
				baseDao.update(paper);
			}
			baseDao.delete(item);
		} else {
			rhs.put("info", "Can not delete this question!");
		}
		rhs.put("flag", find);
		return list();
	}
	
	public String import_itembyxls(){
		String method = getpara("method");
		
		rhs.put("method", method);
		return "success";
	}
	//上传文件并且导入题目
	public String import_itembyxls_save() throws IOException{
		String method = getpara("method");
		String foreignId = "";
		String folder = "item";
		String filepath =ServletActionContext.getRequest().getRealPath("");
		InputStream is = new FileInputStream(file);
		String fileName = this.getFileFileName();
		filepath += "/file/" + folder + "/";
		File fileDir = new File(filepath);
		if (!fileDir.exists())
			FileUtils.forceMkdir(new File(filepath));
		String fileType = fileName.substring(fileName.lastIndexOf(".") + 1);
		String newFileName = new Date().getTime() + Math.random() + "." + fileType;
		File deskFile = new File(filepath, newFileName);
		OutputStream os = new FileOutputStream(deskFile);
		byte[] bytefer = new byte[1024];
		int length = 0;
		while ((length = is.read(bytefer)) != -1) {
			os.write(bytefer, 0, length);
		}
		os.close();
		is.close();
		
		Uploadfile uploadFile = new Uploadfile(fileType, fileName, fileName, foreignId, "/file/" + folder + "/"  + newFileName);
		baseDao.create(uploadFile);
		//上传成功，然后开始生成题目
		//先进行检测
		Map<String,List<String>> exceptions = ItemUtil.checkDataByXLS(deskFile);
		Set<String> exception = exceptions.keySet();
		if(exception.size() > 0){
			rhs.put("exception", exceptions);
		}else{
			Map<Item,List<Choiceitem>> data = ItemUtil.getDataByXLS(deskFile);
			Set<Item> items = data.keySet();
			for (Item item : items) {
				List<Choiceitem> choiceitems = data.get(item);
				item.setChoiceitem(choiceitems);
				baseDao.create(item);
				for (Choiceitem choiceitem : choiceitems) {
					choiceitem.setItem(item);
					baseDao.create(choiceitem);
				}
			}
			if("paper".equals(method)){
				//然后自动生成一个模板，把这些题目变成必做题。然后拿到该模板的ID，新建一个该模板创建的试卷
				Paper paper = new Paper();
				int p = 0,j = 0,k = 0,l = 0;
				int totalmark = 0;
				paper.setItems(items);
				paper.setRmdsinglechoice(0);
				paper.setRmdmultichoice(0);
				paper.setRmdblank(0);
				paper.setRmdessay(0);
				
				for (Item item : items) {
					totalmark += Integer.valueOf(item.getMark());
					switch(item.getType()){
					case 1:
						p++;
						break;
					case 2:
						j++;
						break;
					case 3:
						k++;
						break;
					case 4:
						l++;
						break;
					}
				}
				paper.setSinglechoice(p);
				paper.setMultichoice(j);
				paper.setBlank(k);
				paper.setEssay(l);
				paper.setName(fileName.substring(0, fileName.lastIndexOf("."))  + "_"+new Date().toLocaleString());
				paper.setTotalmark(totalmark);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				paper.setCreatedate(sdf.format(new Date()));
				paper.setCreateuser(getCurrentAccount());
				baseDao.create(paper);
				//跳转到paper页面
			}
		}
		rhs.put("method", method);
		return "success";
	}
	
	public String getItemTemplate() {
		HttpServletResponse response = ServletActionContext.getResponse();
		String filepath = ServletActionContext.getRequest().getRealPath("");
		filepath += "/file/";
		String fileName = "question-sample-import-by-excel.xls";
		File templatefile = new File(filepath, fileName);
		response.setContentType("application/vnd.ms-excel");
		try {
			response.setHeader("Content-disposition", "attachment; filename="
					+ java.net.URLEncoder.encode("UploadTemplate", "UTF-8")
					+ ".xls");
			ServletOutputStream os = response.getOutputStream();
			ItemUtil.exportTemplate(templatefile, os);
			os.close();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<String> getChoiceitemvalue() {
		return choiceitemvalue;
	}

	public void setChoiceitemvalue(List<String> choiceitemvalue) {
		this.choiceitemvalue = choiceitemvalue;
	}

	public List<String> getKnowledgevalue() {
		return knowledgevalue;
	}

	public void setKnowledgevalue(List<String> knowledgevalue) {
		this.knowledgevalue = knowledgevalue;
	}

	public List<String> getChoiceitemid() {
		return choiceitemid;
	}

	public void setChoiceitemid(List<String> choiceitemid) {
		this.choiceitemid = choiceitemid;
	}
	
	protected Knowledge getKnowledgeById(
			Collection<Knowledge> knowledgerootlist, String id)
			throws Exception {
		Knowledge kn = null;
		for (Knowledge knowledge : knowledgerootlist) {
			if (knowledge.getChildKnowledges().size() > 0) {
				Set<Knowledge> knowledges = knowledge.getChildKnowledges();
				kn = getKnowledgeById(knowledges, id);
				if(kn == null){
					continue;
				}
				return kn;
				
			} else {
				if (String.valueOf(knowledge.getId()).equals(id)) {
					return knowledge;
				}
			}
		}
		return kn;
	}

}

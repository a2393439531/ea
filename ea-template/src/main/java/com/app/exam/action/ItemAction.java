package com.app.exam.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.app.exam.model.Template;
import com.app.exam.util.ItemUtil;

@Scope("prototype")
@Component("itemAction")
public class ItemAction extends BaseEaAction {
	private final Logger log = LoggerFactory.getLogger(KnowledgeAction.class);
	public Item item = new Item();
	public List<String> choiceitemvalue = new ArrayList<String>();
	public List<String> knowledgevalue = new ArrayList<String>();
	public List<String> choiceitemid = new ArrayList<String>();

	public String get_list_sql() {
		return "from Item";
	}

	public String list() throws Exception {
		String sql = getSearchSql(get_list_sql());
		Set<Item> list = new HashSet<Item>();
		getPageData(sql);
		if(knowledgevalue.size() != 0){
			for (String knowledge : knowledgevalue) {
				Knowledge kl = (Knowledge)baseDao.loadById("Knowledge", Long.valueOf(knowledge));
				list.addAll(kl.getItems());
			}
		}else{
			list.addAll((Collection<? extends Item>) rhs.get("dataList"));
		}
		rhs.put("dataList", list);
		rhs.put("knowledgeRootList", common_get_tree_root("Knowledge"));
		return "success";
	}
	
	public String listbycondition() throws Exception{
		Set<Item> dataList = new HashSet<Item>();
		
		String knowledgesid = getpara("knowledgesid");
		String type = getpara("type");
		String templateid = getpara("templateid");
		Template template = (Template)baseDao.loadById("Template", Long.valueOf(templateid));
		
		String[] knowledgeid = knowledgesid.split(",");
		
		for(int i = 0; i < knowledgeid.length; i++ ){
			
			Knowledge knowledge = (Knowledge) baseDao.loadById("Knowledge", Long.valueOf(knowledgeid[i]));
			
			Collection<Item> itemlist = knowledge.getItems();
			
			for (Item item : itemlist) {
				//有分值的题目不能被复用，因为是通过excel上传的
				if(type.equals(String.valueOf(item.getType())) && (item.getMark() == null||"0".equals(item.getMark()))){
					dataList.add(item);
				}
			}
		}
		
		if(dataList.size() == 0){
			rhs.put("info", "所选知识领域没有该题型");
		}
		rhs.put("itemlist", dataList);
		rhs.put("template",template);
		return "success";
		
	}

	public String save() throws Exception {
		Set<Choiceitem> choiceitem = new HashSet<Choiceitem>();
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
			}
			if (knowledgevalue.size() > 0) {
				for (String klv : knowledgevalue) {
					Knowledge kn = getKnowledgeById(knowledgerootlist, klv);
					knowledge.add(kn);
				}
				item.setKnowledge(knowledge);// 添加知识领域
			}
			if (choiceitemvalue.size() >= 4) {
				int i = 1;
				for (int j = 0; j < choiceitemvalue.size(); j++) {
					Choiceitem ci = null;
					if(choiceitemid.size() >= 4){
						for (int k = j; k < choiceitemid.size(); k++) {
							ci = (Choiceitem) baseDao.loadById("Choiceitem", Long.parseLong(choiceitemid.get(k)));
							ci.setItem(item);
							ci.setValue(choiceitemvalue.get(j));
							baseDao.update(ci);
							choiceitem.add(ci);
							break;
						}
					}else{
						ci = new Choiceitem();
						ci.setItem(item);
						ci.setRefid(i++);
						ci.setValue(choiceitemvalue.get(j));
						baseDao.create(ci);
						choiceitem.add(ci);
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
		return "success";
	}

	public String add_psychological_item() throws Exception{
		ItemUtil.add_psychological_item("9");
		rhs.put("page", "editpage");
		return list();
	}
	
	public String delete() throws Exception{
		String id = getpara("id");
		Item item = (Item) baseDao.loadById("Item", Long.parseLong(id));
		baseDao.delete(item);
		Set<Template> templates = item.getTemplates();
		for (Template template : templates) {
			switch(item.getType()){
			case 1:
				template.setSinglechoice(template.getSinglechoice() - 1);
				break;
			case 2:
				template.setMultichoice(template.getMultichoice() - 1);
				break;
			case 3:
				template.setBlank(template.getBlank() - 1);
				break;
			case 4:
				template.setEssay(template.getEssay() - 1);
				break;
			}
			baseDao.update(template);
		}
		return list();
	}
	
	public String import_itembyxls(){
		
		return "success";
	}
	//上传文件并且导入题目
	public String import_itembyxls_save() throws IOException{
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
		Map<Item,Set<Choiceitem>> data = ItemUtil.getDataByXLS(deskFile);
		Set<Item> items = data.keySet();
		for (Item item : items) {
			Set<Choiceitem> choiceitems = data.get(item);
			item.setChoiceitem(choiceitems);
			baseDao.create(item);
			for (Choiceitem choiceitem : choiceitems) {
				choiceitem.setItem(item);
				baseDao.create(choiceitem);
			}
		}
		//然后自动生成一个模板，把这些题目变成必做题。然后拿到该模板的ID，新建一个该模板创建的试卷
		Template template = new Template();
		int p = 0,j = 0,k = 0,l = 0;
		int totalmark = 0;
		template.setItems(items);
		template.setRmdsinglechoice(0);
		template.setRmdmultichoice(0);
		template.setRmdblank(0);
		template.setRmdessay(0);
		
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
		template.setSinglechoice(p);
		template.setMultichoice(j);
		template.setBlank(k);
		template.setEssay(l);
		template.setTitle(fileName.substring(0, fileName.lastIndexOf(".")) + "_"+new Date().toLocaleString());
		baseDao.create(template);
		Paper paper = new Paper();
		paper.setName(fileName.substring(0, fileName.lastIndexOf("."))  + "_"+new Date().toLocaleString());
		paper.setTemplate(template);
		paper.setTotalmark(totalmark);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		paper.setCreatedate(sdf.format(new Date()));
		baseDao.create(paper);
//跳转到paper页面
		return "success";
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

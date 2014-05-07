package com.app.exam.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.app.common.spring.ssh.model.BaseModel;

@Entity
@Table(name = "test_template")
public class Template extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private String title;
	private int singlechoice;
	private int rmdsinglechoice;
	private int multichoice;
	private int rmdmultichoice;
	private int blank;
	private int rmdblank;
	private int essay;
	private int rmdessay;
	
	private Set<Knowledge> knowledge = new HashSet<Knowledge>();//知识领域
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Knowledge.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_template_knowledge", joinColumns = { @JoinColumn(name = "template_id") }, inverseJoinColumns = { @JoinColumn(name = "knowledge_id") })
	public Set<Knowledge> getKnowledge() {
		return knowledge;
	}

	public void setKnowledge(Set<Knowledge> knowledge) {
		this.knowledge = knowledge;
	}

	private Set<Item> items = new HashSet<Item>();//必做题
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Item.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_item_template", joinColumns = { @JoinColumn(name = "template_id") }, inverseJoinColumns = { @JoinColumn(name = "item_id") })
	public Set getItems() {
		return items;
	}

	public void setItems(Set<Item> items) {
		this.items = items;
	}

	private Set<Paper> papers = new HashSet();
	
	@OneToMany(mappedBy = "template", cascade = CascadeType.ALL)
	public Set<Paper> getPapers() {
		return papers;
	}

	public void setPapers(Set<Paper> papers) {
		this.papers = papers;
	}

	// 随机生成指定数量和指定类型的题目
	public Set<Item> getRmdItem(String type, int count) {
		Set<Item> datalist = new HashSet<Item>();
		Set<Item> data = new HashSet<Item>();
		int reqcount = 0;
		Set<Item> reqitems = getReqItem(type);
		for (Knowledge kn : knowledge) {
			Collection<Item> items = kn.getItems();
			for (Item item : items) {
				boolean find = false;
				if (type.equals(String.valueOf(item.getType()))) {
					for (Item reqitem : reqitems) {
						if(reqitem.getId() == item.getId()){
							find = true;
							break;
						}
					}
					if(!find){
						datalist.add(item);
					}
				}
			}
		}
		// 上面的步骤已经拿到该模板的指定类型的所有题目，接下来需要在该类型的所有题目中，随机抽取指定数量的题目
		if(count == datalist.size()){
			data.addAll(datalist);
			return data;
		}
			List<Integer> randomNum = generateRmdNum(0, datalist.size() - 1,
					count);
			for (Integer integer : randomNum) {
				int i = 0;
				for (Item item : datalist) {
					if(i == integer){
						data.add(item);
						break;
					}
					i++;
				}
			
			}
		return data;
	}
	
	//获得指定题型的必选题
	public Set<Item> getReqItem(String type){
		Set<Item> datalist = new HashSet<Item>();
		for (Item item : items) {
			if(type.equals(String.valueOf(item.getType()))){
				datalist.add(item);
			}
		}
		return datalist;
	}
	
	public List<Integer> generateRmdNum(int start, int end, int count) {
		Random r = new Random();
		List<Integer> num = new ArrayList<Integer>();
		int k = 0;
		for (int i = 0; i < count; i++) {
			int p = r.nextInt(end) + start;
			for (int j = 0; j < num.size(); j++) {
				if (num.get(j) == p) {
					k++;
					break;
				}
			}
			if (k >= 1) {
				i--;
				k = 0;
				continue;
			}
			num.add(p);
		}
		return num;
	}
	
	public List<Item> getAllItem(Template template){
		Set<Item> singleitems = new HashSet<Item>();
		Collection<Item> rmdsingleitems = getRmdItem("1", getRmdsinglechoice());
		Collection<Item> reqsingleitems = getReqItem("1");
		singleitems.addAll(reqsingleitems);
		singleitems.addAll(rmdsingleitems);
		
		Set<Item> multiitems = new HashSet<Item>();
		Collection<Item> rmdmultiitems = getRmdItem("2", getRmdmultichoice());
		Collection<Item> reqmultiitems = getReqItem("2");
		multiitems.addAll(reqmultiitems);
		multiitems.addAll(rmdmultiitems);
		
		Set<Item> blankitems = new HashSet<Item>();
		Collection<Item> rmdblankitems = getRmdItem("3", getRmdblank());
		Collection<Item> reqblankitems = getReqItem("3");
		blankitems.addAll(reqblankitems);
		blankitems.addAll(rmdblankitems);
		
		Set<Item> essayitems = new HashSet<Item>();
		Collection<Item> rmdessayitems = getRmdItem("4", getRmdessay());
		Collection<Item> reqessayitems = getReqItem("4");
		essayitems.addAll(reqessayitems);
		essayitems.addAll(rmdessayitems);
		
		List<Item> alldata = new ArrayList<Item>();
		alldata.addAll(singleitems);
		alldata.addAll(multiitems);
		alldata.addAll(blankitems);
		alldata.addAll(essayitems);
		return alldata;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getSinglechoice() {
		return singlechoice;
	}

	public void setSinglechoice(int singlechoice) {
		this.singlechoice = singlechoice;
	}

	public int getRmdsinglechoice() {
		return rmdsinglechoice;
	}

	public void setRmdsinglechoice(int rmdsinglechoice) {
		this.rmdsinglechoice = rmdsinglechoice;
	}

	public int getMultichoice() {
		return multichoice;
	}

	public void setMultichoice(int multichoice) {
		this.multichoice = multichoice;
	}

	public int getRmdmultichoice() {
		return rmdmultichoice;
	}

	public void setRmdmultichoice(int rmdmultichoice) {
		this.rmdmultichoice = rmdmultichoice;
	}

	public int getBlank() {
		return blank;
	}

	public void setBlank(int blank) {
		this.blank = blank;
	}

	public int getRmdblank() {
		return rmdblank;
	}

	public void setRmdblank(int rmdblank) {
		this.rmdblank = rmdblank;
	}

	public int getEssay() {
		return essay;
	}

	public void setEssay(int essay) {
		this.essay = essay;
	}

	public int getRmdessay() {
		return rmdessay;
	}

	public void setRmdessay(int rmdessay) {
		this.rmdessay = rmdessay;
	}
	
	
}

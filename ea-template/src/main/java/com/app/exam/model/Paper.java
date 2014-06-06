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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.app.common.activiti.model.ProcessModel;
import com.app.ea.model.User;

@Entity
@Table(name = "test_paper")
public class Paper extends ProcessModel  {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	private Set<Knowledge> knowledge = new HashSet<Knowledge>();

	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Knowledge.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_paper_knowledge", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "knowledge_id") })
	public Set getKnowledge() {
		return knowledge;
	}

	public void setKnowledge(Set<Knowledge> knowledge) {
		this.knowledge = knowledge;
	}

	//
	// private Template template; //引用的模板
	//
	// @ManyToOne(cascade = { CascadeType.ALL })
	// @JoinColumn(name = "template_id", nullable = true)
	// public Template getTemplate() {
	// return template;
	// }
	//
	// public void setTemplate(Template template) {
	// this.template = template;
	// }

	private Papergroup papergroup; //所属的试卷组
	
	//@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Knowledge.class, fetch = FetchType.LAZY)
	//@JoinTable(name = "test_paper_papergroup", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "papergroup_id") })
	
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "papergroup_id", nullable = true)
	public Papergroup getPapergroup() {
		return papergroup;
	}

	public void setPapergroup(Papergroup papergroup) {
		this.papergroup = papergroup;
	}
	
	
	
	//public Set<Result> resultdetail = new HashSet<Result>();
	
	//(cascade = CascadeType.REFRESH, targetEntity = Result.class, fetch = FetchType.LAZY)
	//@JoinTable(name = "test_paper_result", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "result_id") })
	//@OneToMany(mappedBy = "paper", cascade = CascadeType.ALL)
	//	public Set<Result> getResultdetail() {
	//		return resultdetail;
	//	}
	//
	//	public void setResultdetail(Set<Result> resultdetail) {
	//		this.resultdetail = resultdetail;
	//	}

	public Long getSortNob() {
		return sortNob;
	}

	public void setSortNob(Long sortNob) {
		this.sortNob = sortNob;
	}

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		if(o instanceof Paper){
			if(this.sortNob > (((Paper) o).getSortNob())){
				return 1;
			}
			if(this.sortNob < (((Paper) o).getSortNob())){
				return -1;
			}
			if(this.sortNob == (((Paper) o).getSortNob())){
				return 0;
			}
		}
		return super.compareTo(o);
	}

	public Set<Examrecord> resultdetail = new HashSet<Examrecord>();
	
	@OneToMany(mappedBy = "paper", cascade = CascadeType.ALL)
	public Set<Examrecord> getResultdetail() {
		return resultdetail;
	}

	public void setResultdetail(Set<Examrecord> resultdetail) {
		this.resultdetail = resultdetail;
	}
	
	public Set<Examrecord> getResultdetailByAccountAndRecordId(String account,String id) {
		Set<Examrecord> results = new HashSet<Examrecord>();
		for (Examrecord result : resultdetail) {
			if(account.equals(result.getUserid())){
				if(id.equals(String.valueOf(result.getId()))){
					results.add(result);
				}
			}
		}
		return results;
	}
	
	public Set<User> assignedUser = new HashSet<User>();
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = User.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_paper_user", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "user_id") })
	public Set<User> getAssignedUser() {
		return assignedUser;
	}

	public void setAssignedUser(Set<User> assignedUser) {
		this.assignedUser = assignedUser;
	}


	private Set<Item> items = new HashSet<Item>();//必做题
	
	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Item.class, fetch = FetchType.LAZY)
	@JoinTable(name = "test_item_paper", joinColumns = { @JoinColumn(name = "paper_id") }, inverseJoinColumns = { @JoinColumn(name = "item_id") })
	public Set getItems() {
		return items;
	}

	public void setItems(Set<Item> items) {
		this.items = items;
	}
	

	// 随机生成指定数量和指定类型的题目，目前能够随机到有分值的题目
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
		if(count >= datalist.size()){
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
	
	public List<Item> getAllItem(Paper paper){
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
	
	private String name;
	private int totalmark;
	//以下各题型的分数，如果在该题目有分值的情况下，则不参与计算，以该题目分值为准
	private int singlechoicemark;
	private int multichoicemark;
	private int blankmark;
	private int essaymark;
	//end
	private int passmark;
	private int time;
	
	private String createuser;
	private String createdate;
	
	//整合paper和template
	private int singlechoice;
	private int rmdsinglechoice;
	private int multichoice;
	private int rmdmultichoice;
	private int blank;
	private int rmdblank;
	private int essay;
	private int rmdessay;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getTotalmark() {
		return totalmark;
	}

	public void setTotalmark(int totalmark) {
		this.totalmark = totalmark;
	}

	public int getSinglechoicemark() {
		return singlechoicemark;
	}

	public void setSinglechoicemark(int singlechoicemark) {
		this.singlechoicemark = singlechoicemark;
	}

	public int getMultichoicemark() {
		return multichoicemark;
	}

	public void setMultichoicemark(int multichoicemark) {
		this.multichoicemark = multichoicemark;
	}

	public int getBlankmark() {
		return blankmark;
	}

	public void setBlankmark(int blankmark) {
		this.blankmark = blankmark;
	}

	public int getEssaymark() {
		return essaymark;
	}

	public void setEssaymark(int essaymark) {
		this.essaymark = essaymark;
	}

	public int getPassmark() {
		return passmark;
	}

	public void setPassmark(int passmark) {
		this.passmark = passmark;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public String getCreateuser() {
		return createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	public String getCreatedate() {
		return createdate;
	}

	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	// for process
	public String getProcessInstanceId() {
		return processInstanceId;
	}

	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
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

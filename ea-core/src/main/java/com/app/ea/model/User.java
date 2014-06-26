package com.app.ea.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
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

import com.app.common.spring.ssh.model.BaseModel;
import com.app.ea.hsql.Hsql;

@Entity
@Table(name = "manager_ea_user")
public class User extends BaseModel {
	private Long id;

	@Id
	@GeneratedValue
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String account;
	private String name;
	private String englishname;
	private String age;
	private String sex;
	private String email;
	private String email2;
	private String passwd;
	private String ericssonid;
	private String description;
	private String companyname;
	private String groupname;
	private String teamname;
	private String techname;
	private String allrole;
	private String allrolegroup;
	private String phoneNumber;
	private String rollDate;
	private String leftDate;
	private String address;
	private String birthDate;
	private String graduateDate;
	private String qq;
	private String assessLev;
	private String identityCard;
	private String home;
	private String certification;
	private String experience;
	private String score;
	private String mark;
	private String imgfilename;
	private String status;

	private String sognumber;
	private String ksonumber;
	public String conbegindate;
	public String contenddate;


	public String positiondescription;
	public String kpidescription;
	
	public String goldnumber="0"; //added by xiaoqinghong
	public String flowernumber="0"; //added by xiaoqinghong
	
	public Set<User> childUsers = new HashSet<User>();
	public User parentModel;	//added by tom 账户关联，比如出差，或者2个账户拥有共同的权限

	/**
	 * inverseJoinColumns: inverse反转的意思，在JPA中可以理解为被维护端
	 * inverseJoinColumns中的＠JoinColumn: 被维护端外键的定义 fum_id:指 中间表那个外键字段与学生表关联
	 * joinColumns: 关系维护端的定义
	 * */

	private Set roles = new HashSet();

	
	
	
	
	
	
	public String getFlowernumber() {
		return flowernumber;
	}

	public void setFlowernumber(String flowernumber) {
		this.flowernumber = flowernumber;
	}

	@OneToMany(mappedBy = "parentModel", cascade = CascadeType.ALL)
	public Set<User> getChildUsers() {
		return childUsers;
	}

	public void setChildUsers(Set<User> childUsers) {
		this.childUsers = childUsers;
	}
	@ManyToOne(cascade = { CascadeType.ALL })
	@JoinColumn(name = "parent_id", nullable = true)
	public User getParentModel() {
		return parentModel;
	}

	public void setParentModel(User parentModel) {
		this.parentModel = parentModel;
	}

	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Role.class, fetch = FetchType.LAZY)
	@JoinTable(name = "manager_ea_role_user", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = { @JoinColumn(name = "role_id") })
	public Set getRoles() {
		return roles;
	}

	public void setRoles(Set roles) {
		this.roles = roles;
	}

	private Set<Resource> resource = new HashSet<Resource>();

	@ManyToMany(cascade = CascadeType.ALL, targetEntity = Resource.class, fetch = FetchType.LAZY)
	@JoinTable(name = "manager_ea_resource_user", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = { @JoinColumn(name = "resource_id") })
	public Set<Resource> getResources() {
		return resource;
	}

	public void setResources(Set<Resource> resources) {
		this.resource = resources;
	}

	//add by hb for 在线测试功能,拿到配分配的试卷
	//	private Set<Paper> assignedpaper;
	//	
	//	@ManyToMany(cascade = CascadeType.REFRESH, targetEntity = Paper.class, fetch = FetchType.LAZY)
	//	@JoinTable(name = "test_paper_user", joinColumns = { @JoinColumn(name = "user_id") }, inverseJoinColumns = { @JoinColumn(name = "paper_id") })
	//	public Set<Paper> getAssignedpaper() {
	//		return assignedpaper;
	//	}
	//
	//	public void setAssignedpaper(Set<Paper> assignedpaper) {
	//		this.assignedpaper = assignedpaper;
	//	}
	//end
	
	
	
	
	
	public String getAccount() {
		return account;
	}

	public String getGoldnumber() {
		return goldnumber;
	}

	public void setGoldnumber(String goldnumber) {
		this.goldnumber = goldnumber;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	@Column(length = 2000)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRollDate() {
		return rollDate;
	}

	public void setRollDate(String rollDate) {
		this.rollDate = rollDate;
	}

	public String getLeftDate() {
		return leftDate;
	}

	public void setLeftDate(String leftDate) {
		this.leftDate = leftDate;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getGraduateDate() {
		return graduateDate;
	}

	public void setGraduateDate(String graduateDate) {
		this.graduateDate = graduateDate;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getAssessLev() {
		if (assessLev == null)
			return "";
		return assessLev;
	}

	public void setAssessLev(String assessLev) {
		this.assessLev = assessLev;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public String getHome() {
		return home;
	}

	public void setHome(String home) {
		this.home = home;
	}

	public String getCertification() {
		return certification;
	}

	public void setCertification(String certification) {
		this.certification = certification;
	}
	@Column(length = 4000)
	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public String getImgfilename() {
		return imgfilename;
	}

	public void setImgfilename(String imgfilename) {
		this.imgfilename = imgfilename;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getEricssonid() {
		return ericssonid;
	}

	public void setEricssonid(String ericssonid) {
		this.ericssonid = ericssonid;
	}
	@Column(length = 4000)
	public String getPositiondescription() {
		return positiondescription;
	}

	public void setPositiondescription(String positiondescription) {
		this.positiondescription = positiondescription;
	}
	@Column(length = 4000)
	public String getKpidescription() {
		return kpidescription;
	}

	public void setKpidescription(String kpidescription) {
		this.kpidescription = kpidescription;
	}

	public String getEnglishname() {
		return englishname;
	}

	public void setEnglishname(String englishname) {
		this.englishname = englishname;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public String getTeamname() {
		if (teamname == null)
			return "";
		return teamname;

	}

	public void setTeamname(String teamname) {
		this.teamname = teamname;
	}

	public String getTechname() {
		return techname;
	}

	public void setTechname(String techname) {
		this.techname = techname;
	}
	@Column(length = 600)
	public String getAllrole() {
		return allrole;
	}

	public void setAllrole(String allrole) {
		this.allrole = allrole;
	}
	@Column(length = 600)
	public String getAllrolegroup() {
		return allrolegroup;
	}

	public void setAllrolegroup(String allrolegroup) {
		this.allrolegroup = allrolegroup;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getConbegindate() {
		return conbegindate;
	}

	public void setConbegindate(String conbegindate) {
		this.conbegindate = conbegindate;
	}

	public String getContenddate() {
		return contenddate;
	}

	public void setContenddate(String contenddate) {
		this.contenddate = contenddate;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSognumber() {
		return sognumber;
	}

	public void setSognumber(String sognumber) {
		this.sognumber = sognumber;
	}

	public String getKsonumber() {
		return ksonumber;
	}

	public void setKsonumber(String ksonumber) {
		this.ksonumber = ksonumber;
	}

	public Set underUsers() {
		HashSet userset = new HashSet();
		duigui_user_role(this.getRoles(), userset);
		return userset;
	}

	public void duigui_user_role(Set roleset, HashSet userset) {
		for (Iterator iterator = roleset.iterator(); iterator.hasNext();) {
			Role role = (Role) iterator.next();
			if (role.getChildRoles().size() > 0) {
				for (Iterator iterator2 = role.getChildRoles().iterator(); iterator2
						.hasNext();) {
					Role childrole = (Role) iterator2.next();
					
					userset.addAll(childrole.getUsers());
					duigui_user_role(role.getChildRoles(), userset);
				}
			}
			
		}

	}

	public String candidateGroups() {
		String candiationGroups = "all,";
		for (Iterator iterator = this.getRoles().iterator(); iterator.hasNext();) {
			Role role = (Role) iterator.next();
			candiationGroups = candiationGroups + role.getAlias() + ",";
			for (Iterator iterator2 = role.getRolegroups().iterator(); iterator2
					.hasNext();) {
				Rolegroup rolegroup = (Rolegroup) iterator2.next();
				candiationGroups = candiationGroups + rolegroup.getAlias()
						+ ",";
			}
			for (Iterator iterator2 = role.getOrganizes().iterator(); iterator2
					.hasNext();) {
				Organize organize = (Organize) iterator2.next();
				candiationGroups = candiationGroups + organize.getAlias() + ",";
			}
		}
		return candiationGroups;
	}

}
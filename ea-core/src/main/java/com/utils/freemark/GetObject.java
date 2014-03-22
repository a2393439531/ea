package com.utils.freemark;

import java.io.Serializable;

public class GetObject implements Serializable {
	/*
	 * ���е��ֶ����������ﶨ��, xml�����ļ���д�� 1;2;3;4;5;
	 * date;title;url;address;ext; �����λ��varreg[i]: 1;no;3;no,5 �õ�varreg[];
	 * �����ֵ��ʱ�����������Զ�Ҫ��ֵ�� ������������λ�� String strReg = "<tr\\sbgcolor=.*?>.*?<a\\s+href=\"(.*?)\".*?>"
	 * +//1.url "(<FONT.*?>)?(.*?)(</FONT>)?</a>" + //3.title ".*?<FONT.*?>(.*?)</A>" +
	 * //5.�ص� ".*?<font.*?>(.*?)</font>.*?</tr>"; //6date //
	 * date;title;url;address;ext; String[]
	 * varreg=StringUtils.split("6;3;1;5;no;no;no;no;",';');//���
	 * 
	 * 
	 * 
	 */
	public String a0;

	public String a1;

	public String a2;

	public String a3;

	public String a4;

	public String a5;

	public String a6;

	public String a7;

	public long a8long;

	public String getA1() {
		return a1;
	}

	public void setA1(String a1) {
		this.a1 = a1;
	}

	public String getA2() {
		return a2;
	}

	public void setA2(String a2) {
		this.a2 = a2;
	}

	public String getA3() {
		return a3;
	}

	public void setA3(String a3) {
		this.a3 = a3;
	}

	public String getA4() {
		return a4;
	}

	public void setA4(String a4) {
		this.a4 = a4;
	}

	public String getA0() {
		return a0;
	}

	public void setA0(String a0) {
		this.a0 = a0;
	}

	public String getA5() {
		return a5;
	}

	public void setA5(String a5) {
		this.a5 = a5;
	}

	public String getA6() {
		return a6;
	}

	public void setA6(String a6) {
		this.a6 = a6;
	}

	public String getA7() {
		return a7;
	}

	public void setA7(String a7) {
		this.a7 = a7;
	}

	public long getA8long() {
		return a8long;
	}

	public void setA8long(long a8long) {
		this.a8long = a8long;
	}

}

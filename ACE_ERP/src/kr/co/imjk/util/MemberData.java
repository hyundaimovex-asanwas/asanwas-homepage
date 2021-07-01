/*
 * Created on 2005. 2. 17.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.util;

import java.sql.*;

/**
 * @author soolbe
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MemberData{

	private String name;
	private String id;
	private String password;	
	private String jumin1;
	private String jumin2;
	private int sc_code; 
	private String sc_nm;	
	//private int edu_code;
	private String teach;
	private String grade;
	private String class_chk;
	private String class0;
	private String class1;
	private String hp1;
	private String hp2;
	private String hp3;
	private String email;
	private String birth;	
	private String birth_type;
	private String zipcode;	
	private String addr;
	private String school;
	private String class_nm;
	private String teach_roll;
	private String t_etc; //선생님 분류 기타 일때 입력 받는 내용

/**
 * 
 * @uml.property name="name"
 */
// setters
public void setName(String name) {
    this.name = name;
}

    /**
     * 
     * @uml.property name="id"
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * 
     * @uml.property name="password"
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * 
     * @uml.property name="jumin1"
     */
    public void setJumin1(String jumin1) {
        this.jumin1 = jumin1;
    }

    /**
     * 
     * @uml.property name="jumin2"
     */
    public void setJumin2(String jumin2) {
        this.jumin2 = jumin2;
    }

    /**
     * 
     * @uml.property name="sc_code"
     */
    public void setSc_code(int sc_code) {
        this.sc_code = sc_code;
    }

    /**
     * 
     * @uml.property name="sc_nm"
     */
    public void setSc_nm(String sc_nm) {
        this.sc_nm = sc_nm;
    }

    /**
     * 
     * @uml.property name="teach"
     */
    public void setTeach(String teach) {
        this.teach = teach;
    }

    /**
     * 
     * @uml.property name="grade"
     */
    public void setGrade(String grade) {
        this.grade = grade;
    }

    /**
     * 
     * @uml.property name="class_chk"
     */
    public void setClass_chk(String class_chk) {
        this.class_chk = class_chk;
    }

    /**
     * 
     * @uml.property name="class0"
     */
    public void setClass0(String class0) {
        this.class0 = class0;
    }

    /**
     * 
     * @uml.property name="class1"
     */
    public void setClass1(String class1) {
        this.class1 = class1;
    }

    /**
     * 
     * @uml.property name="hp1"
     */
    public void setHp1(String hp1) {
        this.hp1 = hp1;
    }

    /**
     * 
     * @uml.property name="hp2"
     */
    public void setHp2(String hp2) {
        this.hp2 = hp2;
    }

    /**
     * 
     * @uml.property name="hp3"
     */
    public void setHp3(String hp3) {
        this.hp3 = hp3;
    }

    /**
     * 
     * @uml.property name="email"
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * 
     * @uml.property name="birth"
     */
    public void setBirth(String birth) {
        this.birth = birth;
    }

    /**
     * 
     * @uml.property name="birth_type"
     */
    public void setBirth_type(String birth_type) {
        this.birth_type = birth_type;
    }

    /**
     * 
     * @uml.property name="zipcode"
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    /**
     * 
     * @uml.property name="addr"
     */
    public void setAddr(String addr) {
        this.addr = addr;
    }

    /**
     * 
     * @uml.property name="school"
     */
    public void setSchool(String school) {
        this.school = school;
    }

    /**
     * 
     * @uml.property name="class_nm"
     */
    public void setClass_nm(String class_nm) {
        this.class_nm = class_nm;
    }

    /**
     * 
     * @uml.property name="teach_roll"
     */
    public void setTeach_roll(String teach_roll) {
        this.teach_roll = teach_roll;
    }

    /**
     * 
     * @uml.property name="t_etc"
     */
    public void setT_etc(String t_etc) {
        this.t_etc = t_etc;
    }

/**
 * 
 * @uml.property name="name"
 */
// getters
public String getName() {
    return name;
}

    /**
     * 
     * @uml.property name="id"
     */
    public String getId() {
        return id;
    }

    /**
     * 
     * @uml.property name="password"
     */
    public String getPassword() {
        return password;
    }

    /**
     * 
     * @uml.property name="jumin1"
     */
    public String getJumin1() {
        return jumin1;
    }

    /**
     * 
     * @uml.property name="jumin2"
     */
    public String getJumin2() {
        return jumin2;
    }

    /**
     * 
     * @uml.property name="sc_code"
     */
    public int getSc_code() {
        return sc_code;
    }

    /**
     * 
     * @uml.property name="sc_nm"
     */
    public String getSc_nm() {
        return sc_nm;
    }

    /**
     * 
     * @uml.property name="teach"
     */
    public String getTeach() {
        return teach;
    }

    /**
     * 
     * @uml.property name="grade"
     */
    public String getGrade() {
        return grade;
    }

    /**
     * 
     * @uml.property name="class_chk"
     */
    public String getClass_chk() {
        return class_chk;
    }

    /**
     * 
     * @uml.property name="class0"
     */
    public String getClass0() {
        return class0;
    }

    /**
     * 
     * @uml.property name="class1"
     */
    public String getClass1() {
        return class1;
    }

    /**
     * 
     * @uml.property name="hp1"
     */
    public String getHp1() {
        return hp1;
    }

    /**
     * 
     * @uml.property name="hp2"
     */
    public String getHp2() {
        return hp2;
    }

    /**
     * 
     * @uml.property name="hp3"
     */
    public String getHp3() {
        return hp3;
    }

    /**
     * 
     * @uml.property name="email"
     */
    public String getEmail() {
        return email;
    }

    /**
     * 
     * @uml.property name="birth"
     */
    public String getBirth() {
        return birth;
    }

    /**
     * 
     * @uml.property name="birth_type"
     */
    public String getBirth_type() {
        return birth_type;
    }

    /**
     * 
     * @uml.property name="zipcode"
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * 
     * @uml.property name="addr"
     */
    public String getAddr() {
        return addr;
    }

    /**
     * 
     * @uml.property name="school"
     */
    public String getSchool() {
        return school;
    }

    /**
     * 
     * @uml.property name="class_nm"
     */
    public String getClass_nm() {
        return class_nm;
    }

    /**
     * 
     * @uml.property name="teach_roll"
     */
    public String getTeach_roll() {
        return teach_roll;
    }

    /**
     * 
     * @uml.property name="t_etc"
     */
    public String getT_etc() {
        return t_etc;
    }

	
}

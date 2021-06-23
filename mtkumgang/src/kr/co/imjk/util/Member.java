package kr.co.imjk.util;

public class Member {	
	
	private String id;
	private String password;
	private String name;
	private String edu_code;
	private String sc_code;
	private String sc_nm;
	private String user_grade;
	private String user_class;
	private String user_jumin;
	private String user_hp;
	private String user_email;

	public Member() {}

	public Member(String id, String name) {
		setContents(id, name);
	}
	public void setContents(String id, String name) {
		this.id=      id;
		this.name=    name;
	}

/**
 * 
 * @uml.property name="id"
 */
// setters
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
     * @uml.property name="name"
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 
     * @uml.property name="edu_code"
     */
    public void setEdu_code(String edu_code) {
        this.edu_code = edu_code;
    }

    /**
     * 
     * @uml.property name="sc_code"
     */
    public void setSc_code(String sc_code) {
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
     * @uml.property name="user_grade"
     */
    public void setUser_grade(String user_grade) {
        this.user_grade = user_grade;
    }

    /**
     * 
     * @uml.property name="user_class"
     */
    public void setUser_class(String user_class) {
        this.user_class = user_class;
    }

    /**
     * 
     * @uml.property name="user_jumin"
     */
    public void setUser_jumin(String user_jumin) {
        this.user_jumin = user_jumin;
    }

    /**
     * 
     * @uml.property name="user_hp"
     */
    public void setUser_hp(String user_hp) {
        this.user_hp = user_hp;
    }

    /**
     * 
     * @uml.property name="user_email"
     */
    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }

/**
 * 
 * @uml.property name="id"
 */
// getters
public String getId() {
    return this.id;
}

    /**
     * 
     * @uml.property name="password"
     */
    public String getPassword() {
        return this.password;
    }

    /**
     * 
     * @uml.property name="name"
     */
    public String getName() {
        return this.name;
    }

    /**
     * 
     * @uml.property name="edu_code"
     */
    public String getEdu_code() {
        return this.edu_code;
    }

    /**
     * 
     * @uml.property name="sc_code"
     */
    public String getSc_code() {
        return this.sc_code;
    }

    /**
     * 
     * @uml.property name="sc_nm"
     */
    public String getSc_nm() {
        return this.sc_nm;
    }

    /**
     * 
     * @uml.property name="user_grade"
     */
    public String getUser_grade() {
        return this.user_grade;
    }

    /**
     * 
     * @uml.property name="user_class"
     */
    public String getUser_class() {
        return this.user_class;
    }

    /**
     * 
     * @uml.property name="user_jumin"
     */
    public String getUser_jumin() {
        return this.user_jumin;
    }

    /**
     * 
     * @uml.property name="user_hp"
     */
    public String getUser_hp() {
        return this.user_hp;
    }

    /**
     * 
     * @uml.property name="user_email"
     */
    public String getUser_email() {
        return this.user_email;
    }

	

}

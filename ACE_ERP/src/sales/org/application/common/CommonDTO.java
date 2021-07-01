/*******************************************************************************
 * 1.클래스   명 : CommonDTO.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2004-03-30
 ******************************************************************************/

package sales.org.application.common;


import sales.org.util.ClassUtil;

public class CommonDTO{
	public void nvl(){
		nvl("");
	}

	public void nvl(String str){
		ClassUtil.dtonvl(this,str);
	}
	//어드민여부
	private boolean isAdmin;
	private boolean isTrendinfo;
	private boolean isTemplate;
	private boolean isNewsletter; 
	private boolean isPrivate;
	
	public boolean getIsAdmin(){return isAdmin;}
	public void setIsAdmin(boolean in){this.isAdmin = in;}

	public boolean getIsNewsletter(){return this.isNewsletter;}
	public void setIsNewsletter(boolean in){this.isNewsletter = in;}

	public boolean getIsPrivate(){return isPrivate;}
	public void setIsPrivate(boolean in){this.isPrivate = in;}

	public boolean getIsTemplate(){return isTemplate;}
	public void setIsTemplate(boolean in){this.isTemplate = in;}

	public boolean getIsTrendinfo(){return isTrendinfo;}
	public void setIsTrendinfo(boolean in) {this.isTrendinfo = in;}
}
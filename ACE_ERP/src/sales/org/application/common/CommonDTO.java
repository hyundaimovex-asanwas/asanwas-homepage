/*******************************************************************************
 * 1.Ŭ����   �� : CommonDTO.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
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
	//���ο���
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
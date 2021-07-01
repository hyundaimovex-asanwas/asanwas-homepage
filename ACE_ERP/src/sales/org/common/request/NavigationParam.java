/**
 * ���ϸ� : NavigationParam.java
 * ��  �� : �Ķ���͸� ���� �������� ���� �Ѱ��ش�.  
 * �ۼ��� : �� �� ��
 * �ۼ��� : 2006. 2. 3.
 * VER   : v1.0
 */

package sales.org.common.request;


import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import sales.org.util.StringUtil;


public class NavigationParam {
	/* ���� ���ڿ��� ���۵Ǵ� �Ķ���� �̸� ���� */
	private String searchPrefix = "search";
	
	/* ���� �Ķ���� �̸� ���� */
	private String[] searchNames = {"nowPage", "pageScale"};

	/* �Ķ���� �̸� ���� */
	private ArrayList parameterNames = new ArrayList();

	/* �Ķ���� �� ���� */
	private ArrayList parameterValues = new ArrayList();
	
	/**
	 * �Ķ���͸� �޾Ƽ� ���� ��Ű�� ������ 
	 * @param req	HttpServletRequest ��ü
	 */
	public NavigationParam(HttpServletRequest req) {
		Enumeration e = req.getParameterNames();

		while(e.hasMoreElements()) {
			String key = (String)e.nextElement();
			if(validName(key)) {
				insertParameterValues(key, req.getParameterValues(key));
			}
		}
	}
	
	/**
	 * �Ķ���͸� �޾Ƽ� �����Ű�� ������
	 * @param req	SmartRequest ��ü
	 * @see			sales.org.common.request.SmartRequest
	 */
	public NavigationParam(SmartRequest req) {
		String[] strName = req.getParameterNameArray();
		
		if(strName != null) {
			for(int i = 0; i < strName.length; i++) {
				if(validName(strName[i])) {
					insertParameterValues(strName[i], req.getParameterArray(strName[i]));
				}
			}
		}
	}

	/**
	 * ����� �Ķ���͸� Query String ���ڿ��� ��ȯ
	 * 
	 * @return
	 */
	public String getQueryString() throws Exception {
		StringBuffer buf = new StringBuffer();
		
		for(int i = 0; i < parameterNames.size(); i++) {
			String strKey = (String)parameterNames.get(i);
			String[] strValues = (String[])parameterValues.get(i);
			
			for(int j = 0; j < strValues.length; j++) {
				if(strValues[j] != null) {
					if(buf.length() != 0) {
						buf.append("&");
					}
					buf.append(strKey);
					buf.append("=");
					buf.append(URLEncoder.encode(strValues[j]));
				}
			}
		}
		
		return buf.toString();
	}
	
	/**
	 * ����� �Ķ���͸� Hidden �� �ʵ� ���ڿ��� ��ȯ
	 * 
	 * @return
	 */
	public String getFormField() {
		StringBuffer buf = new StringBuffer();
		
		for(int i = 0; i < parameterNames.size(); i++) {
			String strKey = (String)parameterNames.get(i);
			String[] strValues = (String[])parameterValues.get(i);
			
			for(int j = 0; j < strValues.length; j++) {
				if(strValues[j] != null) {
					buf.append(" <input type=\"hidden\" name=\"" + strKey + "\" value=\""
						+ StringUtil.textToHtml(strValues[j]) + "\"> \n");
				}
			}
		}

		return buf.toString();
	}

	private boolean validName(String strName) {
		if(strName != null) {
		
			if(strName.indexOf(searchPrefix) == 0) {
				return true;
			}
	
			for(int i = 0; i < searchNames.length; i++) {
				if(searchNames[i].equals(strName)) {
					return true;
				}
			}

		}

		return false;
	}
	
	private void insertParameterValues(String strName, String[] strValues) {
		parameterNames.add(strName);
		parameterValues.add(strValues);
	}
}

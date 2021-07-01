/**
 * 파일명 : NavigationParam.java
 * 기  능 : 파라메터를 다음 페이지에 쉽게 넘겨준다.  
 * 작성자 : 이 동 연
 * 작성일 : 2006. 2. 3.
 * VER   : v1.0
 */

package sales.org.common.request;


import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import sales.org.util.StringUtil;


public class NavigationParam {
	/* 다음 문자열로 시작되는 파라메터 이름 저장 */
	private String searchPrefix = "search";
	
	/* 다음 파라메터 이름 저장 */
	private String[] searchNames = {"nowPage", "pageScale"};

	/* 파라메터 이름 저장 */
	private ArrayList parameterNames = new ArrayList();

	/* 파라메터 값 저장 */
	private ArrayList parameterValues = new ArrayList();
	
	/**
	 * 파라메터를 받아서 저장 시키는 생성자 
	 * @param req	HttpServletRequest 객체
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
	 * 파라메터를 받아서 저장시키는 생성자
	 * @param req	SmartRequest 객체
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
	 * 저장된 파라메터를 Query String 문자열로 반환
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
	 * 저장된 파라메터를 Hidden 폼 필드 문자열로 반환
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

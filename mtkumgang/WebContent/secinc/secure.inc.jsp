<%@ page import="com.hdasan.util.SecUtil"%>
<%-- secure.inc.jsp
	kr.co.imjk.util.SecUtil.strReplace() 사용 	2009-10-12 심동현
	 * @param   dest    바꾸는 대상이 되는 스트링
	 * @param   src     찾기를 원하는 스트링
     * @param   rep     바뀔 문자열
     * @retrun  특정문자열이 원하는 문자열로 바뀌어진 스트링을 리턴한다.
   	 public static   String strReplace(String dest,String src,String rep)
--%>


<%!	//XSS 필터 함수 
	//str - 필터링할 출력값 
	//avatag - 허용할 태그 리스트 (예) $avatag = "p,br" )

	String clearXSS(String str, String avatag){
		str = SecUtil.strReplace(str,"<","&lt;");
		str = SecUtil.strReplace(str,">","&gt;");
		str = SecUtil.strReplace(str,"\"","&quot;");
		str = SecUtil.strReplace(str,"'","&#39;");
		str = SecUtil.strReplace(str," ","&nbsp;");
		str = SecUtil.strReplace(str,"\n","<br>");

		str = SecUtil.strReplace(str," 0"," ");
		//허용할 태그를 지정할 경우 
		if (!avatag.equals("")) { 
			avatag= SecUtil.strReplace(avatag," ","");
			String [] st = avatag.split(",");

			//허용할 태그를 존재 여부를 검사하여 원상태로 변환 
			for( int x = 0; x < st.length; x++ ) { 
				str = SecUtil.strReplace(str,"&lt;"+str+" ", "<"+str+" " ); 
				str = SecUtil.strReplace(str,"&lt;"+str+">", "<"+str+">" ); 
				str = SecUtil.strReplace(str,"&lt;/"+str   , "</"+str    ); 
			} 
		}
		return (str);
	}
%>

<%! // 확장자 검사
// filename: 파일명
// avaext: 허용할 확장자 예) $avaext = "jpg,gif,pdf" 
//리턴값: true-"ok", false-"error" 
	String checkext(String fileName, String avaExt) {
		String chkExt = "false";
		
		if (fileName.indexOf("\0") > -1) { 
			chkExt = "false"; 
		}
		
		//업로드 금지 확장자 체크 
		String file_ext = fileName.substring(fileName.lastIndexOf('.') + 1); if(( file_ext.equalsIgnoreCase("jsp") || file_ext.equalsIgnoreCase("htm") || file_ext.equalsIgnoreCase("html")) ) {
			//out.println("업로드 금지 확장자"); 
			chkExt = "false"; 
		}
		
		//허용 확장자가 설정된 경우 
		if (!avaExt.equals("")) { 
			//공백 제거 
			avaExt = SecUtil.strReplace(avaExt," ","");
			String compStr[] = avaExt.split(","); 
			
			for (int i = 0;i < compStr.length; i++) { 
				if (file_ext.equalsIgnoreCase(compStr[i])) { 
					chkExt = "true";
				}
			}
		} else { 
			chkExt = "true"; 
		}
		
		return chkExt;
	}
%>


<%! //다운로드 경로 체크 함수 
	//dn_dir - 다운로드 디렉토리 경로(path) 
	//fname - 다운로드 파일명 
	//리턴 - true:다운로드 파일 경로, false: "error" 

	//치환하는 걸로 바꾸보자 by sdh
	String checkpath(String dn_path, String fname) { 
		//입력되는 디렉토리명에서 특수문자 유무 검사 
		if((dn_path.indexOf("..\\") != -1) || (dn_path.indexOf("../") != -1)) { 
			return "error"; 
		}

		if((fname.indexOf("..\\") != -1) || (fname.indexOf("../") != -1)) { 
			return "error"; 
		}
		
		//사용자 입력값으로 다운로드 파일 경로 생성 
		if (dn_path.equals("")) { 
		} else {
			dn_path = dn_path + "/"; 
		}
		
		String origfile = dn_path + fname;
		//fname에서 파일명만 분리 - 파일명에 공격 위험성 문자 필터링 
		
		//fname.replaceAll("\\","/"); //일부 버전에서 오류 발생 
		fname = SecUtil.strReplace(fname,"\\", "/"); 
		//fname.replaceAll("\\","/")가 사용할 수 없는 경우 아래 
		String filename4 = fname.substring(fname.lastIndexOf('\\') + 1);
		
		//분리한 파일명과 절대 경로를 재구성 
		String FilePath = dn_path + filename4; 
		//사용자 입력값과 재구성한 입력값을 비교하여 공격 위험성이 존재하는지 확인 
		if (origfile.equals(FilePath)) { 
			return (FilePath); 
		} else { 
			return "error"; 
		}
	}


%> 


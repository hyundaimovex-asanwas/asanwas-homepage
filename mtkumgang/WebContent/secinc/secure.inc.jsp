<%@ page import="com.hdasan.util.SecUtil"%>
<%-- secure.inc.jsp
	kr.co.imjk.util.SecUtil.strReplace() ��� 	2009-10-12 �ɵ���
	 * @param   dest    �ٲٴ� ����� �Ǵ� ��Ʈ��
	 * @param   src     ã�⸦ ���ϴ� ��Ʈ��
     * @param   rep     �ٲ� ���ڿ�
     * @retrun  Ư�����ڿ��� ���ϴ� ���ڿ��� �ٲ���� ��Ʈ���� �����Ѵ�.
   	 public static   String strReplace(String dest,String src,String rep)
--%>


<%!	//XSS ���� �Լ� 
	//str - ���͸��� ��°� 
	//avatag - ����� �±� ����Ʈ (��) $avatag = "p,br" )

	String clearXSS(String str, String avatag){
		str = SecUtil.strReplace(str,"<","&lt;");
		str = SecUtil.strReplace(str,">","&gt;");
		str = SecUtil.strReplace(str,"\"","&quot;");
		str = SecUtil.strReplace(str,"'","&#39;");
		str = SecUtil.strReplace(str," ","&nbsp;");
		str = SecUtil.strReplace(str,"\n","<br>");

		str = SecUtil.strReplace(str," 0"," ");
		//����� �±׸� ������ ��� 
		if (!avatag.equals("")) { 
			avatag= SecUtil.strReplace(avatag," ","");
			String [] st = avatag.split(",");

			//����� �±׸� ���� ���θ� �˻��Ͽ� �����·� ��ȯ 
			for( int x = 0; x < st.length; x++ ) { 
				str = SecUtil.strReplace(str,"&lt;"+str+" ", "<"+str+" " ); 
				str = SecUtil.strReplace(str,"&lt;"+str+">", "<"+str+">" ); 
				str = SecUtil.strReplace(str,"&lt;/"+str   , "</"+str    ); 
			} 
		}
		return (str);
	}
%>

<%! // Ȯ���� �˻�
// filename: ���ϸ�
// avaext: ����� Ȯ���� ��) $avaext = "jpg,gif,pdf" 
//���ϰ�: true-"ok", false-"error" 
	String checkext(String fileName, String avaExt) {
		String chkExt = "false";
		
		if (fileName.indexOf("\0") > -1) { 
			chkExt = "false"; 
		}
		
		//���ε� ���� Ȯ���� üũ 
		String file_ext = fileName.substring(fileName.lastIndexOf('.') + 1); if(( file_ext.equalsIgnoreCase("jsp") || file_ext.equalsIgnoreCase("htm") || file_ext.equalsIgnoreCase("html")) ) {
			//out.println("���ε� ���� Ȯ����"); 
			chkExt = "false"; 
		}
		
		//��� Ȯ���ڰ� ������ ��� 
		if (!avaExt.equals("")) { 
			//���� ���� 
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


<%! //�ٿ�ε� ��� üũ �Լ� 
	//dn_dir - �ٿ�ε� ���丮 ���(path) 
	//fname - �ٿ�ε� ���ϸ� 
	//���� - true:�ٿ�ε� ���� ���, false: "error" 

	//ġȯ�ϴ� �ɷ� �ٲٺ��� by sdh
	String checkpath(String dn_path, String fname) { 
		//�ԷµǴ� ���丮���� Ư������ ���� �˻� 
		if((dn_path.indexOf("..\\") != -1) || (dn_path.indexOf("../") != -1)) { 
			return "error"; 
		}

		if((fname.indexOf("..\\") != -1) || (fname.indexOf("../") != -1)) { 
			return "error"; 
		}
		
		//����� �Է°����� �ٿ�ε� ���� ��� ���� 
		if (dn_path.equals("")) { 
		} else {
			dn_path = dn_path + "/"; 
		}
		
		String origfile = dn_path + fname;
		//fname���� ���ϸ� �и� - ���ϸ� ���� ���輺 ���� ���͸� 
		
		//fname.replaceAll("\\","/"); //�Ϻ� �������� ���� �߻� 
		fname = SecUtil.strReplace(fname,"\\", "/"); 
		//fname.replaceAll("\\","/")�� ����� �� ���� ��� �Ʒ� 
		String filename4 = fname.substring(fname.lastIndexOf('\\') + 1);
		
		//�и��� ���ϸ�� ���� ��θ� �籸�� 
		String FilePath = dn_path + filename4; 
		//����� �Է°��� �籸���� �Է°��� ���Ͽ� ���� ���輺�� �����ϴ��� Ȯ�� 
		if (origfile.equals(FilePath)) { 
			return (FilePath); 
		} else { 
			return "error"; 
		}
	}


%> 


<%--
  - �ٿ�ε� ��� üũ �Լ� �߰�- 20091019 �ɵ���
--%>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="java.util.*,java.io.*,java.sql.*,java.text.*"%>

<%
	String dn_path="";
    String path = "/was/EAR/tourWebEAR.ear/tourWeb.war/center/download/";
    String filename = request.getParameter("file");
	String filename2 = new String(filename.getBytes("euc-kr"),"8859_1");
	dn_path = checkpath(path, filename); 


if (!dn_path.equals("error")) { 
	//out.println("oh~! it's not error");
	response.setHeader("Content-Disposition", "attachment;filename=" + filename2 + ";");
	//���� ���� ���μ���
	File file = new File(path+filename); // �������Դϴ�.
	byte b[] = new byte[512];

	BufferedInputStream fin = null;
	BufferedOutputStream outs = null;
	try{
		if (file.isFile())
		{
		    fin = new BufferedInputStream(new FileInputStream(file));
		    outs = new BufferedOutputStream(response.getOutputStream());
		    int read = 0;
		    while ((read = fin.read(b, 0, 512)) != -1){
			 outs.write(b,0,read);
		    }
		    outs.close();
		    fin.close();
		}
    }catch(Exception e){
		try{
		    if(outs != null) outs.close();
		    if(fin != null) fin.close();
		}catch(Exception _ignored){
		}

		e.printStackTrace(System.out);
	}


}else{
	out.println("�ش� ������ ã�� �� �����ϴ�.");
}

%>
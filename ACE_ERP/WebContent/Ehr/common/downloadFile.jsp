<%@ page contentType="application/text/html; charset=euc-kr"
         import="java.io.File,common.util.FileUtil" %><%

    response.reset();

    String fileName = request.getParameter("FILE_NAME");
    String fileUrl  = request.getParameter("FILE_URL");

    String strClient = request.getHeader("User-Agent");
    String ls_UserId = (String)request.getSession().getAttribute("SESSION_ENONO");

    try {
    	if ((ls_UserId == null) || (ls_UserId == "")) {
    		throw new Exception("�������� �����ϴ�.  �������� �α��� �� ���ٶ��ϴ�.");
    	}
        if(fileName.equals("passwd.txt")) {

        	throw new Exception("������ �������� �ʰų� ������ �����ϴ�");
        }

        if(strClient.indexOf("MSIE 5.5")>-1) {
            response.setHeader("Content-Type", "application/x-msdownload");
            response.setHeader("Content-Disposition", "filename="+fileName+";");
        }else {
            response.setHeader("Content-Type", "application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename="+fileName+";");
        }



        File readFile = new File(fileUrl);

        //������ �������� �ʰų� ���� �� ������ ����
        if (!readFile.exists() || !readFile.canRead()) throw new Exception("������ �������� �ʰų� ������ �����ϴ�");


        //��ȯ�� ��Ʈ��
        javax.servlet.ServletOutputStream
                    servletoutputstream
                                = response.getOutputStream();

        //��Ʈ���� ���
        FileUtil.writeOutputStream(servletoutputstream, readFile);

        //������ ����
        servletoutputstream.flush();
        servletoutputstream.close();

    }catch(Exception e){
        //response.setContentType("text/html");
        out.println("Error : "+e.getMessage());
    }
%>
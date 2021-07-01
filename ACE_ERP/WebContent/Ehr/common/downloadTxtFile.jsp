<%@ page contentType="application/text/html; charset=euc-kr"
         import="com.shift.gef.support.vo.DynamicValueObject,Ehr.common.util.FileUtil" %><%

    response.reset();

    DynamicValueObject voList = (DynamicValueObject)request.getAttribute("VO_LIST");
    String nonSelectedKeys = request.getParameter("KEYS");
    String fileName = request.getParameter("FILE_NAME");

    String strClient = request.getHeader("User-Agent");
    try {
        if(strClient.indexOf("MSIE 5.5")>-1) {
            response.setHeader("Content-Type", "application/x-msdownload");
            response.setHeader("Content-Disposition", "filename=\"" +new String(fileName.getBytes("euc-kr"), "ISO8859_1") + "\";");
        }else {
            response.setHeader("Content-Type", "application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment;filename=\"" +new String(fileName.getBytes("euc-kr"), "ISO8859_1") + "\";");

        }

        if(voList != null && voList.size() > 0) {
            //��ȯ�� ��Ʈ��
            javax.servlet.ServletOutputStream
                        servletoutputstream
                                    = response.getOutputStream();

            //��Ʈ���� ���
            FileUtil.writeOutputStream(servletoutputstream, "NUM", "NPN_NO", voList, nonSelectedKeys);

            //������ ����
            servletoutputstream.close();
        }
    }catch(Exception e){
        //response.setContentType("text/html");
        out.println("Error : "+e.getMessage());
    }
%>
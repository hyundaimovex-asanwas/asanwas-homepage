<!--
***********************************************************************
* @source      : pird010_ED_PR01.jsp
* @description : �λ���ǥ-�⺻���� ��ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/10      �̽¿�        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
%>

<%@page import ="java.io.*"%>
<%@page import ="common.util.ImgUtil" %>
<%@page import ="elsoft.extquery.extquery"%>
<%@page import ="com.shift.gef.configuration.Configuration"%>
<%@page import ="com.shift.gef.core.exception.CException"%>

<%
    Configuration conf = Configuration.getInstance();

    String eno_no   = request.getParameter("ENO_NO");
    String FILEURL  = "";
    FILEURL = conf.get("framework.file.upload.pds");

    //String eno_path = "C:/project/hlc/config/file/upload/" + eno_no + ".bmp";
    String eno_path = FILEURL+"/"+ eno_no + ".jpg";
    File   eno_file = new java.io.File(eno_path);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("ENO_IMG");

    hnwExtQuery.SendField(response);

    hnwExtQuery.AddData(eno_no);
    hnwExtQuery.AddData(eno_file);

    hnwExtQuery.SendData(response);
    hnwExtQuery.EndData(response);


%>


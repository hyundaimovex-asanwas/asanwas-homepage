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

    String u_file   = request.getParameter("U_FILE");
    File   r_file = new java.io.File(u_file);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("FILE_PATH");
    hnwExtQuery.AddField("FILE_IMG");

    hnwExtQuery.SendField(response);

    hnwExtQuery.AddData(u_file);
    hnwExtQuery.AddData(r_file);
    hnwExtQuery.SendData(response);

    hnwExtQuery.EndData(response);


%>


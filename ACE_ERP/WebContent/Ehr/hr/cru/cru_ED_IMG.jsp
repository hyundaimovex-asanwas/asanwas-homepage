<!--
***********************************************************************
* @source      : pird010_ED_PR01.jsp
* @description : 인사기록표-기본정보 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/10      이승욱        최초작성.
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

    String u_file   = request.getParameter("U_FILE").replaceAll("-","");
    String FILEURL  = "";
    FILEURL = conf.get("framework.file.upload.pds");

    String eno_path = FILEURL+"/temp/"+ u_file + ".gif";
    File   r_file = new java.io.File(eno_path);

    extquery hnwExtQuery = new extquery();

 System.out.println("eno_path: " + eno_path+"\n");


    hnwExtQuery.AddField("FILE_PATH");
    hnwExtQuery.AddField("FILE_IMG");

    hnwExtQuery.SendField(response);

    hnwExtQuery.AddData(eno_path);
    hnwExtQuery.AddData(r_file);
    hnwExtQuery.SendData(response);

    hnwExtQuery.EndData(response);


%>


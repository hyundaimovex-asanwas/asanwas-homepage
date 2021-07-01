<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import="sales.common.*"%>

<%
    // ContextPath
    String dirPath = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
<jsp:include page="/Sales/common/include/head.jsp"/>

        <script language="javascript">
            function proc_call(dsType){
                ln_TRSetting(tr1, 
                    "<%=dirPath%>/services/servlet/sales.sample.Procedure",
                    "JSP(O:DEFAULT=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType="+dsType);
                tr_post(tr1);
            }
        </script>

        <%=HDConstant.COMMENT_START%>
        <object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
            <param name="SyncLoad"  value="False">
        </object>
        <object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
            <param name="ServerIP"   value="">
            <param name="Action"     value="">
            <param name="KeyName"    value="">
            <param name="KeyValue"   value="">
            <param name="Parameters" value="">
        </object>
        <%=HDConstant.COMMENT_END%>

        <script language="javascript" for="tr1" event="onsuccess()">
            alert("call success");
        </script>
        <script language="javascript" for="tr1" event="onfail()">
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
        </script>
  </head>
  
  <body>
    <input type=button value=proc_call1 onClick="proc_call('1')"><br>
    <input type=button value=proc_call2 onClick="proc_call('2')"><br>
    <input type=button value=proc_call3 onClick="proc_call('3')"><br>
  </body>
</html>

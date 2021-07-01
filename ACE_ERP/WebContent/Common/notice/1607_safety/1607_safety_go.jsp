<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.HDConstant" %>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<html>
<head>
<script language="javascript" src="<%=dirPath%>/Common/js/portal.js"></script>


<script language="javascript" for="tr_safety" event="onsuccess()">
	//alert(parent.document.all.top_notice);
	parent.document.all.top_notice.style.display= "none";
</script>



<% //공지용 2016안전보건교육  %>
<object id=ds_safety classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False"/>
</object>
<object  id="tr_safety" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyName"    value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

<script>
<!--
	//alert(1);
    var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
    	+ "empno=";	
	ln_TRSetting(tr_safety,
    	"<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>ChkSafety", 
    	"JSP(I:DS_SAFETY=ds_safety)",
   		param);
    tr_post(tr_safety);		
//-->
</script>
</head>
</html>

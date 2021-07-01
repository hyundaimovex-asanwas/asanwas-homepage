<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<script type="text/javascript">
	
 	function fnOnLoad(){
 		alert("페이지 온로드 시작 ");
 		fnInit();
 	}
	
	function fnInit(){
		alert("초기화를 시작합니다.");
		var strParam = new Array();	//팝업시 받아오는 파라미터들
 		strParam = window.dialogArguments;

	 var cost_cd =  strParam[0]; 
     
     alert("::::"+cost_cd);
     // NOW_COST1 NOW_COST2
	    	 var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
					+ ",v_project_cd=" + cost_cd+",v_kind="+"cost2";
	  		
				alert("초기화를 시작합니다.22");
		 		//데이터셋 헤더 초기화 = 빈 조회
		         ln_TRSetting(tr1, 
		         	"<%=dirPath%><%=HDConstant.PATH_DSH%>Dsh011",
		             "JSP(O:DS_DEFAULT=ds_default)",
		             param);
		     	alert("초기화를 시작합니다.33");
		         tr_post(tr1);
		         document.getElementById("title_name").innerHTML="매입 DETAIL";
	}
	
	gcgd_disp.ColumnProp('PAY_AMT','SumText');
	
</script>
<title>Dash Board Detail</title>

<!-- classid 쓰면됨. -->

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<!-- <script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script> -->

</HEAD>
 <jsp:include page="/Common/sys/body_s11.jsp"/>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:380px;border:0 solid #708090">
	<tr>
		<td >
			<h4>매출 Detail</h4>
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<OBJECT classid=<%=HDConstant.CT_GRID_CLSID%> id=gcgd_disp style="width:580;height:400px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="ds_default">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"     value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=GUBUN,		Name=구분,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center </C> <!-- sort = true정열 -->
					<C>ID=DS_VENDOR,		Name=거래처,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left </C>
					<C>ID=CONTENTS,		Name=Content,		width=140,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left</C>
					<C>ID=PAY_DATE,		Name=일자,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left </C>
					<C>ID=PAY_AMT,		Name=금액,		width=120,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left  SumText=sValue</C>
					
				">
	    </OBJECT>
		</td>
	</tr>

</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
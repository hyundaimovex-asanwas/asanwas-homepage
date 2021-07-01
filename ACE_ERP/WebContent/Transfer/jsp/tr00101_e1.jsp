<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반입주문조회
+ 프로그램 ID	: TR00201.HTML
+ 기 능 정 의	: 반입주문조회
+ 변 경 이 력	: 정미선
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>



<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>

	/******************************************************************************
		Description :
	******************************************************************************/
	function Start(){
		gcDs2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>t00101_s3?v_str1=1043"; 
		gcDs2.Reset();
	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
		if (!confirm("선택하신 주문정보에 대한 환율변환을 하시겠습니까?")) return;

		gcDs1.clearall();
		gcDs1.SetDataHeader("ORDER_NO:STRING(10)");
		
		var cnt = opener.gcDs1.countrow;
		for (var i=1; i<=cnt; i++) {
			if (opener.gcDs1.namevalue(i,"RATE_FLAG")==1) {
				gcDs1.addrow();
				
				//alert("ORDER_NO:::"+opener.gcDs1.namevalue(i,"ORDER_NO"));
				gcDs1.namevalue(gcDs1.rowposition,"ORDER_NO") = opener.gcDs1.namevalue(i,"ORDER_NO");
			}
		}

		gcTr1.KeyValue = "trRateChange(I:DATA=gcDs1)";
		gcTr1.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trRateChange";
        
		
		//alert("CDNAM:::"+gcDs2.namevalue(gcDs2.rowposition,"CDNAM"));
		//alert(" gcem_amt.text:::"+ gcem_amt.text);
		gcTr1.Parameters = "v_str1=" + gcDs2.namevalue(gcDs2.rowposition,"CDNAM") + ",v_str2=" + gcem_amt.text;

		prompt('',gcDs1.text);
		gcTr1.post();

	}

</SCRIPT> 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcDs2" event="onLoadCompleted(row,colid)">
	gclx_curcode.index = 1;
</script>

<script language="javascript" for="gclx_curcode" event="OnSelChange2()">
	gcDs3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>t00101_s4?v_str1=" + gclx_curcode.bindcolval;
	gcDs3.Reset();
</script>

<script language="javascript" for="gclx_date" event="OnSelChange2()">
	gcem_amt.text = gclx_date.bindcolval;
</script>

<script language=javascript for=gcTr1 event="onsuccess()">
	alert("정상적으로 환율변환 되었습니다.");
	window.close();
</script>

<script language=javascript for=gcTr1 event="onfail()">
	alert(gcTr1.errormsg);
</script>

</HEAD>

<BODY onLoad="Start();">
	<table width="315" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="310" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="<%=dirPath%>/Common/img/btn/com_b_banyoung.gif" style="cursor:hand" onclick="ln_Save()">
				<img src="<%=dirPath%>/Common/img/btn/com_b_close.gif"    style="cursor:hand" onclick="window.close()">
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2>
				<table border=0 cellpadding=0 cellspacing=0 style="border:1 solid #708090;border-bottom-width:0px;border-right-width:0px;width:100%">
					<tr>
						<td class="tab11" style="width:100px;height:30px;" bgcolor="#efefef">화폐구분</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_curcode  style='border:0;position:relative;left:8px;top:1px;width:90px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs2">  
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=SortColumn			value="CDCODE"> 
								<param name=ListExprFormat	value="CDNAM^0^65">
								<param name=BindColumn			value="CDCODE">
								<param name=InheritColor		value="true"> 
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td class="tab11" style="height:30px" bgcolor="#efefef">기준일자</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_date style='border:0;position:relative;left:8px;top:1px;width:90px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs3">  
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=ListExprFormat	value="CDNAM^0^65">
								<param name=BindColumn			value="CDCODE">
								<param name=InheritColor		value="true"> 
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td class="tab11" style="height:30px" bgcolor="#efefef">금액(원)</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:4px; width:80px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=PromptChar	  value="_">
								<param name=UpperFlag   value=1> 
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</BODY>
</HTML>

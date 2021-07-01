<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%	String dirPath = request.getContextPath(); %>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 인사관리 - 계약관리 - 연장계약자 일괄생성
+ 프로그램ID : em016_popup.jsp
+ 기능정의 : 조회된 계약자 중 연장계약자를 일괄생성한다.
+ 작 성 자 : 정영식 
+ 작성일자 : 2008.01.02
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em014_S1_Pop
----------------------------------------------------------------------------------*/
%>
<head>
<title>[연장계약 일괄생성]</title>
<jsp:include page="/Sales/common/include/head.jsp"/>

<script language="javascript">

var parentGubun="";
get_cookdata();
/*
var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+"01";
var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
*/
var opener = window.dialogArguments;

/*----------------------------------------------------------------------------
 Description : 페이지 로딩
----------------------------------------------------------------------------*/

function ln_Start(){
	ln_before();
}
/*----------------------------------------------------------------------------
 Description : 조회
----------------------------------------------------------------------------*/
function ln_Query(){
}


/*----------------------------------------------------------------------------
 Description : 조회시 필수항목체크 (휴가대상일자)
----------------------------------------------------------------------------*/
function ln_Query_Chk(){

}
/*----------------------------------------------------------------------------
 Description : 조회
----------------------------------------------------------------------------*/
function ln_before(){
	gcds_cm015.DataID="<%=dirPath%>/servlet/sales.em.Em_com_s1?v_str1=CM015";
	gcds_cm015.Reset();
	gcem_end_ym.text = opener.gcem_end_ym.text;

	 //상여금 지급년월 = 만기년월 + 1개월
	 gcem_bon_ym.text = opener.gcds_ymd.namevalue(opener.gcds_ymd.rowposition,"AMM"); 
	 //휴가보상년월 = 만기년월 + 1년1개월 (자동 생성은 이전년을 기준으로 하기 때문)
	 gcem_reward_ym.text = opener.gcds_ymd.namevalue(opener.gcds_ymd.rowposition,"AYM"); 
}

/*----------------------------------------------------------------------------
	Description : 사원찾기
----------------------------------------------------------------------------*/
function ln_Find(){//성명조회

}


/*----------------------------------------------------------------------------
 Description : 창닫기
----------------------------------------------------------------------------*/
function ln_Close() {
  var strRow="";
	
  window.close();

}
/*----------------------------------------------------------------------------
 Description : 일괄생성
----------------------------------------------------------------------------*/
function ln_Create() {
  var chk=0;
  gcds_data0.clearall();

	if (gcds_data0.countrow<1){
		var s_temp = "EMPNO:STRING(10),CONT_GB:STRING(3),REWARD_YM:STRING(6),I_EMPNO:STRING(10),U_EMPNO:STRING(10),"
		           + "BON_YM:STRING(6),SEQ:DECIMAL(2.0)";						 
		gcds_data0.SetDataHeader(s_temp);
	}

	for(i=1;i<=opener.gcds_data.countrow;i++){
		if(opener.gcds_data.namevalue(i,"CHK")=="T"){
			chk=1;
			gcds_data0.addrow();
			gcds_data0.namevalue(gcds_data0.rowposition,"EMPNO") = opener.gcds_data.namevalue(i,"EMPNO");
			gcds_data0.namevalue(gcds_data0.rowposition,"CONT_GB") = gclx_contgb_cd.bindcolval;
			gcds_data0.namevalue(gcds_data0.rowposition,"REWARD_YM") = gcem_reward_ym.text;
			gcds_data0.namevalue(gcds_data0.rowposition,"I_EMPNO") = gusrid;
			gcds_data0.namevalue(gcds_data0.rowposition,"U_EMPNO") = gusrid;
			gcds_data0.namevalue(gcds_data0.rowposition,"BON_YM") = gcem_bon_ym.text;
			gcds_data0.namevalue(gcds_data0.rowposition,"SEQ") = opener.gcds_data.namevalue(i,"SEQ");
		}
	}

	if(chk==0){
		alert("선택하신 근로자가 없습니다. 확인 하십시요.");
		return false;
	}

	if(gcem_reward_ym.text==""){
		alert("휴가 미실시 보상 지급년월을 입력하십시요.");
		return false;
	}

	if (gcds_data0.IsUpdated) {
		if (confirm("새로운 정보를 저장하시겠습니까?")){
			gctr_data.KeyValue = "Em016_t2(I:USER=gcds_data0)";
			gctr_data.action = "<%=dirPath%>/servlet/sales.em.Em016_t2?";
			gctr_data.Parameters = "v_str1="+gusrid;
			//prompt('',gcds_data0.text);
			gctr_data.post();
		}
	}
}

</script>
<!-----------------------------------------------------------------------------
  DataSet Components(DS) 선언 시작
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm015 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 민족 -->
<OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" value="+COM_SNAME">
</OBJECT>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
     D A T A S E T   C O M P O N E N T' S
  M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_cm015" event="onloadCompleted(row,colid)">
	gclx_contgb_cd.index = 1;
	gclx_contgb_cd.Enable = false;
</script>


<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>
  /*
	if(row<1&&colid=="CHK"){
		if(gcds_data.namevalue(1,colid)=="T"){
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="F";
			}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="T";
			}
		}
	}
	*/
</script>

<script language=JavaScript for=gcgd_disp event=OnDblClick(row,colid)>
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/
%>
	<script language="javascript" for="gctr_data" event="onsuccess()">
		 alert("저장에 성공하였습니다");
	</script>
	<script language="javascript" for="gctr_data" event="onfail()">
		 alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
      B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table cellpadding="0" cellspacing="0" border="0" width="390" height="120">
  <tr height="30">
	<tr height="30">
		<td>
			<td align="right">
			<img src="<%=dirPath%>/Sales/images/n_create.gif"  style="cursor:hand" onclick="ln_Create()">
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"   	style="cursor:hand" onclick="ln_Close()">
		</td>
	</tr>
	<tr height="35">
		<td colspan="2" >
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:390px;height:100px;font-size:12px;" bgcolor="#708090">
				<tr>
					<td align="center" bgcolor="#eeeeee" class="tab_z0000"  height="25" >계약만료년월</td>
					<td bgcolor="#FFFFFF" class="tab_z0000" >
						 <comment id="__NSID__">
              <OBJECT id=gcem_end_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
              <param name=PromptChar	  value="_">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#eeeeee" class="tab_z0000"  height="25" >계약구분</td>
					<td bgcolor="#FFFFFF" class="tab_z0000" >
						<comment id="__NSID__">
						<OBJECT id=gclx_contgb_cd   classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
						<param name=ComboDataID			value="gcds_cm015">
						<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
						<param name=SearchColumn		value=COM_SNAME>
						<param name=Sort						value=false>
						<param name=Index						value=0>
						<param name=ListExprFormat	value="COM_SNAME^0^80">
						<param name=BindColumn			value=COM_CODE>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#eeeeee" width="100px" height="30" >휴가미실시보상<BR>지급년월</td>
					<td  bgcolor="#FFFFFF" width="290px;">
						 <comment id="__NSID__">
							<OBJECT id=gcem_reward_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:-2px; width:50px; font-family:굴림; font-size:9pt;z-index:2; " >
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=ReadOnly      value="true">
  						<param name=ReadOnlyBackColor   value="#CCFFCC">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<!-- <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_reward_ym', 'Text');"> -->
					</td>
				</tr>
				<tr>
					<td align="center" bgcolor="#eeeeee" width="100px" height="25">상여지급년월</td>
					<td  bgcolor="#FFFFFF" width="290px;">
						 <comment id="__NSID__">
							<OBJECT id=gcem_bon_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:0px; width:50px; font-family:굴림; font-size:9pt;z-index:2; " >
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<!-- <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_reward_ym', 'Text');"> -->
					</td>
				</tr>
				<tr>
					<td bgcolor="#FFFFFF" colspan=2>
						<BR><B>&nbsp;&nbsp; * 선택한 근로자의 연장계약의 근속년차,계약시작일,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계약만료일은 자동으로 1년씩 더하여 생성됩니다.</B><BR>&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
<!-- </body>
</html> -->

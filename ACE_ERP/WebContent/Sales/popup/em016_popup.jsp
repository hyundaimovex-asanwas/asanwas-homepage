<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%	String dirPath = request.getContextPath(); %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���� - ������ - �������� �ϰ�����
+ ���α׷�ID : em016_popup.jsp
+ ������� : ��ȸ�� ����� �� �������ڸ� �ϰ������Ѵ�.
+ �� �� �� : ������ 
+ �ۼ����� : 2008.01.02
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em014_S1_Pop
----------------------------------------------------------------------------------*/
%>
<head>
<title>[������ �ϰ�����]</title>
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
 Description : ������ �ε�
----------------------------------------------------------------------------*/

function ln_Start(){
	ln_before();
}
/*----------------------------------------------------------------------------
 Description : ��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){
}


/*----------------------------------------------------------------------------
 Description : ��ȸ�� �ʼ��׸�üũ (�ް��������)
----------------------------------------------------------------------------*/
function ln_Query_Chk(){

}
/*----------------------------------------------------------------------------
 Description : ��ȸ
----------------------------------------------------------------------------*/
function ln_before(){
	gcds_cm015.DataID="<%=dirPath%>/servlet/sales.em.Em_com_s1?v_str1=CM015";
	gcds_cm015.Reset();
	gcem_end_ym.text = opener.gcem_end_ym.text;

	 //�󿩱� ���޳�� = ������ + 1����
	 gcem_bon_ym.text = opener.gcds_ymd.namevalue(opener.gcds_ymd.rowposition,"AMM"); 
	 //�ް������� = ������ + 1��1���� (�ڵ� ������ �������� �������� �ϱ� ����)
	 gcem_reward_ym.text = opener.gcds_ymd.namevalue(opener.gcds_ymd.rowposition,"AYM"); 
}

/*----------------------------------------------------------------------------
	Description : ���ã��
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

}


/*----------------------------------------------------------------------------
 Description : â�ݱ�
----------------------------------------------------------------------------*/
function ln_Close() {
  var strRow="";
	
  window.close();

}
/*----------------------------------------------------------------------------
 Description : �ϰ�����
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
		alert("�����Ͻ� �ٷ��ڰ� �����ϴ�. Ȯ�� �Ͻʽÿ�.");
		return false;
	}

	if(gcem_reward_ym.text==""){
		alert("�ް� �̽ǽ� ���� ���޳���� �Է��Ͻʽÿ�.");
		return false;
	}

	if (gcds_data0.IsUpdated) {
		if (confirm("���ο� ������ �����Ͻðڽ��ϱ�?")){
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
  DataSet Components(DS) ���� ����
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm015 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- ���� -->
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
			Transaction Component's Event Message Scripts ����
=============================================================================*/
%>
	<script language="javascript" for="gctr_data" event="onsuccess()">
		 alert("���忡 �����Ͽ����ϴ�");
	</script>
	<script language="javascript" for="gctr_data" event="onfail()">
		 alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
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
					<td align="center" bgcolor="#eeeeee" class="tab_z0000"  height="25" >��ุ����</td>
					<td bgcolor="#FFFFFF" class="tab_z0000" >
						 <comment id="__NSID__">
              <OBJECT id=gcem_end_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;" >
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
					<td align="center" bgcolor="#eeeeee" class="tab_z0000"  height="25" >��౸��</td>
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
					<td align="center" bgcolor="#eeeeee" width="100px" height="30" >�ް��̽ǽú���<BR>���޳��</td>
					<td  bgcolor="#FFFFFF" width="290px;">
						 <comment id="__NSID__">
							<OBJECT id=gcem_reward_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:-2px; width:50px; font-family:����; font-size:9pt;z-index:2; " >
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
					<td align="center" bgcolor="#eeeeee" width="100px" height="25">�����޳��</td>
					<td  bgcolor="#FFFFFF" width="290px;">
						 <comment id="__NSID__">
							<OBJECT id=gcem_bon_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:0px; width:50px; font-family:����; font-size:9pt;z-index:2; " >
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
						<BR><B>&nbsp;&nbsp; * ������ �ٷ����� �������� �ټӳ���,��������,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ุ������ �ڵ����� 1�⾿ ���Ͽ� �����˴ϴ�.</B><BR>&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
<!-- </body>
</html> -->

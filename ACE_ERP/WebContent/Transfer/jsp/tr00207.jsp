<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - ���Թ�������
+ ���α׷� ID	: TR00207.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: ���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �������� :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML ����-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();

	
	var	lb_boolean1 =  false ; 
	var lb_allocation = false ; 
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			Start();//����ȸ

			window.status="�Ϸ�";

		}
	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/
	function Start(){

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();
		
		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //���籸�� 
		gcDs_etc5.Reset();
		
		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
		gcDsgetdate.Reset() ;
		

		if(gcDsgetdate.CountRow > 0 ) {
		
			FROM_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 
			
			gcem_yymm_to.Text = gcDsgetdate.NameValue(1,"APP_DT1") ;  
			
		}
	}

	/******************************************************************************
		Description :  ��ȸ
	******************************************************************************/ 
	function ln_Query(){
	
		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPerson?NOH=Y";  //����������
		gcDs_etc2.Reset();

		var parm = "&gstr0=I"
						 + "&gstr1=" + CAR_SEQ_NO.Text
						 + "&gstr2=" + FROM_DATE.Text
						 + "&gstr3=" + FROM_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr5=" + ORDER_NO.Text
						 + "&gstr7=I";

		btn_check.checked = false;

		gcDs1.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsList?NOH=Y"+parm ; 
		gcDs1.Reset() ; 
		
	}

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "=���� or �Է�=" ;   
	}

	/******************************************************************************
		Description : �ϰ�����
	******************************************************************************/
	function ln_ChkB(){
		var pam1 = new Array("gcem_time_to","gcem_yymm_to","gcem_time_to1");
		var pam2 = new Array("START_TIME","RTRN_DATE","RTRN_TIME");

		if (gcDs1.countrow<1) return;

		if (btn_check.checked) {
			for (var i=0; i<pam1.length; i++) {
				for (var j=0; j<=gcDs1.countrow; j++){
					gcDs1.namevalue(j,pam2[i]) = eval(pam1[i]).text;
				}
			}
		}	else {
			for (var i=0; i<pam1.length; i++) {
				for (var j=0; j<=gcDs1.countrow; j++){
					gcDs1.namevalue(j,pam2[i]) = "";
				}
			}
		}
	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
		if (gcDs1.isUpdated){
			if (!ln_ChkData()) return;

			if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ� ?  ")) {

				gcDs2.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsList?NOH=N"; 
				gcDs2.Reset() ; 

				for (var i=1; i<=gcDs1.countrow; i++){
					if (gcDs1.namevalue(i,"CAR_NO")!="") gcDs1.namevalue(i,"CAR_TYPENM") = Grid1.VirtualString(i,"CARTYPENO");
				}
				
				for (var j=1; j<=gcDs1.countrow; j++) if (gcDs1.namevalue(j,"CAR_NO")!="") gcDs2.ImportData(gcDs1.ExportData(j,1,false));
				
				var sdate = gcDs1.namevalue(1,"EDT_DATE");
				var sparm = "v_str1=" + sdate.substring(2,8) +
										",v_str2=" + sdate +
										",v_str3=" + gusrid +
										",v_str4=" + LINE_PART.BindColVal;

				gcDs2.SortExpr = "+CAR_SEQ_NO+START_TIME-IN_OUT";
				gcDs2.Sort();

				gctr_data.KeyValue = "tr00107_t2(I:DATA=gcDs2)";
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00107_t2";
				gctr_data.Parameters = sparm;
				gctr_data.post();

				gcDs2.SortExpr = "+IN_OUT+CAR_SEQ_NO";
				gcDs2.Sort();

			}
		}
	}

	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_ChkData(){
		var row = gcDs1.countrow;

		var parm = "&gstr1="+CAR_SEQ_NO.Text ; 
				parm = parm + "&gstr2="+gcDs3.namevalue(1,"EDT_DATE");
				parm = parm + "&gstr4="+LINE_PART.BindColVal ; 
				parm = parm + "&gstr5="+ORDER_NO.Text ; 
				parm = parm + "&gstr7=I"; 

		gcDs3.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00107_s1?NOH=Y"+parm ; 
		gcDs3.Reset() ; 

		var prow = 0;
		for (var j=1; j<=row; j++) {
			if (gcDs1.sysStatus(j)=="3") {
				prow = j;
				break;
			}
		}

		for (var j=1; j<=row; j++) {
			if (gcDs1.sysStatus(j)=="3") {
				if (gcDs1.namevalue(j,"CAR_NO")=="") {
					alert("������ȣ�� �Է��� �ֽʽÿ�.");
					return false;
				}

				if (gcDs1.namevalue(j,"PERSON_NO")=="") {
					alert("�����ڸ��� �Է��� �ֽʽÿ�.");
					return false;
				}

				var stime = fRtrim(gcDs1.namevalue(j,"START_TIME"));
				if (stime=="" || stime.length<4) {
					alert("��߽ð��� ��Ȯ�� �Է��� �ֽʽÿ�.");
					return false;
				}

				var rdate = fRtrim(gcDs1.namevalue(j,"RTRN_DATE"));
				if (rdate=="" || rdate.length<8) {
					alert("�������ڸ� ��Ȯ�� �Է��� �ֽʽÿ�.");
					return false;
				}

				var rtime = fRtrim(gcDs1.namevalue(j,"RTRN_TIME"));
				if (rtime=="" || rtime.length<4) {
					alert("���ͽð��� ��Ȯ�� �Է��� �ֽʽÿ�.");
					return false;
				}

				var sdate = fRtrim(gcDs1.namevalue(j,"EDT_DATE"));
				var sdt = sdate + stime;
				var rdt = rdate + rtime;
				if (sdt>=rdt) {
					alert("�����Ͻô� ����Ͻ� ���� ���Ŀ��� �մϴ�.");
					return false;
				}

				if (gcDs1.namevalue(1,"LINE_PART")!=gcDs1.namevalue(j,"LINE_PART")) {
					alert("������ ������Ʈ�� ������ �ֽʽÿ�.");
					return false;
				}

				for (var k=1; k<=row; k++){
					if (gcDs1.namevalue(k,"CAR_NO")!="") {
						if (j!=k) {
							if (gcDs1.namevalue(k,"CAR_NO")==gcDs1.namevalue(j,"CAR_NO") && gcDs1.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //����Ͻ�
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //�����Ͻ�
								var v3 = gcDs1.namevalue(k,"EDT_DATE") + gcDs1.namevalue(k,"START_TIME"); //����Ͻ�
								var v4 = gcDs1.namevalue(k,"RTRN_DATE") + gcDs1.namevalue(k,"RTRN_TIME"); //�����Ͻ�
								
								if (v3<=v1) {
									if (v4>v1) {
										alert("���� ������ �����Ͻ� �� �����ϴ�.");
										return false;
									}
								}
							}

							if (gcDs1.namevalue(k,"PERSON_NO")==gcDs1.namevalue(j,"PERSON_NO")  && gcDs1.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //����Ͻ�
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //�����Ͻ�
								var v3 = gcDs1.namevalue(k,"EDT_DATE") + gcDs1.namevalue(k,"START_TIME"); //����Ͻ�
								var v4 = gcDs1.namevalue(k,"RTRN_DATE") + gcDs1.namevalue(k,"RTRN_TIME"); //�����Ͻ�
								
								if (v3<=v1) {
									if (v4>v1) {
										alert("�������� �����Ͻ� �� �����ϴ�.");
										return false;
									}
								}
							}
						}
					}
				}

				for (var k=1; k<=gcDs3.countrow; k++){
					if (gcDs3.namevalue(k,"CAR_NO")!="") {

						if (gcDs1.namevalue(j,"ACCESS_NO")!=gcDs3.namevalue(k,"ACCESS_NO")){
							if (gcDs3.namevalue(k,"CAR_NO")==gcDs1.namevalue(j,"CAR_NO") && gcDs3.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //����Ͻ�
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //�����Ͻ�
								var v3 = gcDs3.namevalue(k,"EDT_DATE") + gcDs3.namevalue(k,"START_TIME"); //����Ͻ�
								var v4 = gcDs3.namevalue(k,"RTRN_DATE") + gcDs3.namevalue(k,"RTRN_TIME"); //�����Ͻ�

								if (v3<=v1) {
									if (v4>v1) {
										alert(gcDs3.namevalue(k,"CAR_NO") + " ������ �����Ͻ� �� �����ϴ�.");
										return false;
									}
								}
							}

							if (gcDs3.namevalue(k,"PERSON_NO")==gcDs1.namevalue(j,"PERSON_NO") && gcDs3.namevalue(k,"IN_OUT")==gcDs1.namevalue(j,"IN_OUT")) {
								var v1 = gcDs1.namevalue(j,"EDT_DATE") + gcDs1.namevalue(j,"START_TIME"); //����Ͻ�
								var v2 = gcDs1.namevalue(j,"RTRN_DATE") + gcDs1.namevalue(j,"RTRN_TIME"); //�����Ͻ�
								var v3 = gcDs3.namevalue(k,"EDT_DATE") + gcDs3.namevalue(k,"START_TIME"); //����Ͻ�
								var v4 = gcDs3.namevalue(k,"RTRN_DATE") + gcDs3.namevalue(k,"RTRN_TIME"); //�����Ͻ�
								
								if (v3<=v1) {
									if (v4>v1) {
										alert("�������� �����Ͻ� �� �����ϴ�.");
										return false;
									}
								}
							}
						}
					}
				}
			}
		}

		return true;
	}

	/******************************************************************************
		Description : ��� & �������� ����
	******************************************************************************/
	function ln_Callendar(){
		__GetCallCalendar('FROM_DATE', 'Text');
		gcem_yymm_to.text = FROM_DATE.text;
	}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1	classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"			VALUE="false">
</OBJECT>

<OBJECT id=gcDs2	classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"			VALUE="true">
</OBJECT>

<OBJECT id=gcDs3	classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"			VALUE="true">
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="false">
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="true">
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="false">
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>
<%=HDConstant.COMMENT_END%> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>

<script language=JavaScript for=Grid1 event=OnPopup(row,colid,data)>
	var car_type = gcDs1.NameValue(gcDs1.RowPosition,"CARTYPENO") ; 
	var result = window.showModalDialog('TR00206_E1.html?gstr1='+car_type,window,"dialogWidth:650px; dialogHeight:555px");
	if( result != null ) {
		gcDs1.NameValue(gcDs1.RowPosition,"CAR_NO")  = result[0]; //������ȣ
		gcDs1.NameValue(gcDs1.RowPosition,"PERSON_NO")  = result[1]; 
		gcDs1.NameValue(gcDs1.RowPosition,"START_TIME")  = result[5]; 
		gcDs1.NameValue(gcDs1.RowPosition,"RTRN_DATE")  = result[3]; 
		gcDs1.NameValue(gcDs1.RowPosition,"RTRN_TIME")  = result[4]; 
		gcDs1.NameValue(gcDs1.RowPosition,"ACCESS_NO")  = result[6];
	}
</script>

<script language=JavaScript for=gctr_data event=OnSuccess()>
	gcDs1.Reset();
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=FROM_DATE event=onKeyUp(kcode,scode)>
	gcem_yymm_to.text = FROM_DATE.text;
</script>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="../../../Common/img/btn/com_b_save.gif"	style="cursor:hand" onClick="ln_Save()">
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12_left" bgcolor="#eeeeee" width=80 style="text-align:center">��������</td>
						<td class="tab12_left" >&nbsp;
						 <%=HDConstant.COMMENT_START%>
						 <OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:67px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:0px;top:1px;cursor:hand" onclick="ln_Callendar();">
						</td>
						<td class="tab12_left" bgcolor="#eeeeee"  width=80 style="text-align:center">�ֹ���ȣ</td>
						<td class="tab12_left"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag   value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab12_left" bgcolor="#eeeeee"  width=80 style="text-align:center">������ȣ</td>
						<td class="tab12_left"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=CAR_SEQ_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>     
						</td>
						<td class="tab12_left" bgcolor="#eeeeee"  width=80 style="text-align:center">Project</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;width:160px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td> 
					</tr> 
				</table> 
			</td>
		</tr>
		<tr><td height=5></td></tr>
		<tr style="display:none">
			<td height="1px" colspan=2>
			(��߽ð� :&nbsp;<%=HDConstant.COMMENT_START%>
			<OBJECT id=gcem_time_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:0px;top:4px" style="height:14;width:32;">
				<param name=Alignment		value="0">
				<param name=Border			value="0">
				<param name=Enable			value="1">
				<param name=Format			value="00:00">
				<param name=Text				value="0900">
				<param name=PromptChar	value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
				&nbsp;&nbsp;��������:&nbsp;
				<%=HDConstant.COMMENT_START%>
				<OBJECT id=gcem_yymm_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:62;height:17px;position:relative; left:0px;top:7px">
				<param name=Alignment		value="0">
				<param name=Border			value="0">
				<param name=Format			value="YYYY/MM/DD">
				<param name=PromptChar	value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
				&nbsp;&nbsp;���ͽð�:&nbsp;
				<%=HDConstant.COMMENT_START%>
				<OBJECT id=gcem_time_to1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="height:14;width:32;" style="position:relative; left:0px;top:4px">
				<param name=Alignment		value="0">
				<param name=Border			value="0">
				<param name=Enable			value="1">
				<param name=Format			value="00:00">
				<param name=Text				value="2400">
				<param name=PromptChar	value="_">
				</OBJECT>
				<%=HDConstant.COMMENT_END%> &nbsp;&nbsp;) 
				<input type="checkbox" id=btn_check style="position:relative;top:2px;left:5px;cursor:hand" onclick="ln_ChkB()">
				<span style="position:relative;top:1px;cursor:hand" onclick="if (btn_check.checked!=true) btn_check.checked=true; else btn_check.checked=false;ln_ChkB();">�ϰ�����</span>
			</td>
		</tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:870px;height:300px;font-size:9pt;background-color:#ffffff;border:0 solid #708090" >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:876px;height:438px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true">  
								<PARAM NAME="Format"			VALUE="  
									<C> Name='��'		ID=CHECK HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center EditStyle=CheckBox show=false</C> 
									<C> Name='No.'	ID=GRAYY HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center Value={ToString(RowCount-CurRow+1)}</C> 
									<G> Name='��������' HeadBgColor=#FAFCA7
										<C> Name='������ȣ'			ID=CAR_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center		EditStyle=PopupFix</C> 
										<C> Name='�����ڹ�ȣ'		ID=PERSON_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center,	show=false</C>
										<C> Name='�����ڸ�'			ID=PERSON_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center		EditStyle=Lookup Data='gcDs_etc2:PERSON_NO:PSN_KNAME', edit=none</C>
										<C> Name='��߽ð�'			ID=START_TIME HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=center		MASK='XX:XX', edit=none show=false</C>
										<C> Name='��������'			ID=RTRN_DATE	HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center		MASK='XXXX/XX/XX', edit=none</C>
										<C> Name='���Խð�'			ID=RTRN_TIME	HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=center		MASK='XX:XX', edit=none</C>
									</G>
									<G> Name='��������' HeadBgColor=#D5EDFB 
										<C> Name='������ȣ'				ID=CAR_SEQ_NO HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=left,		edit=none</C>  
										<C> Name='����/����'				ID=IN_OUT			HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=center		Editstyle='combo' Data='I:����,O:����', edit=none, show=false</C>
										<C> Name='����'						ID=TYPE				HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=center,	edit=none  </C>
										<C> Name='��������'				ID=CARTYPENO	HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=left			EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME', edit=none</C> 
										<C> Name='�ѿ���'					ID=GRAYY			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center,	edit=none, show=FALSE </C>  
										<C> Name='�ֹ���ȣ'				ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center,	edit=none</C>  
										<C> Name='PROJECT'				ID=LINE_PART	HeadAlign=Center HeadBgColor=#eeeeee Width=135 align=left			EditStyle=Lookup Data='gcds_etc1:MINORCD:MINORNM', edit=none</C>
										<C> Name='�԰���������'			ID=LD_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center		MASK ='XXXX-XX-XX', edit=none</C>
										<C> Name='��������'				ID=EDT_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center		MASK ='XXXX-XX-XX', edit=none</C> 
										<C> Name='��ǥǰ��'				ID=CTN_STDRD	HeadAlign=Center HeadBgColor=#eeeeee Width=137 align=LEFT,		edit=none</C> 
									</G>
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table> 
			</td>
		</tr> 
	</table>
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

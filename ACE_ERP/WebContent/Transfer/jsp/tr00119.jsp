<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ�
+ ���α׷� ID	: TR00119.HTML
+ �� �� �� ��	: ������û����
+ �� �� �� ��	: �̹���
+ �� �� �� ��	: tr00119_s1, tr00119_t1
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

	var gs_userid = gusrid;
	var gs_modr="R";
	var gs_moda="A";
	var gs_modb="B";
	var gs_modc="C";
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";
	
	gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			Start();//����ȸ

			window.status="�Ϸ�";

		}
</script>

<!-- /******************************************************************************
	Description : DataSet ����
******************************************************************************/ --> 
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc33 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad		value="true">
	 <param name=UseFilter	value="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcTr1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<SCRIPT language=JavaScript>

	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/ 
	function Start(){
				
		gcDs_etc1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; //Project
		gcDs_etc1.Reset();
		
		gcDs_etc2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0003"; //���籸��
		gcDs_etc2.Reset();
		
		gcDs_etc3.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s4"; //����
		gcDs_etc3.Reset();
		
		gcDs_etc33.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0001"; //��ǰ����
		gcDs_etc33.Reset();
		
		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //����
		gcDs_etc4.Reset(); 
		
		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
		gcDsgetdate.Reset() ;

		FROM_DATE.Text = gs_date;

		if(gcDsgetdate.CountRow > 0 ) TO_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 
	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/ 
	function ln_Query(){
		var parm = "&gstr1=" + ORDER_NO.Text
						 + "&gstr2=" + FROM_DATE.Text
						 + "&gstr3=" + TO_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr5=" + CARGO_TYPE.BindColVal
						 + "&gstr6=" + CUST_CD.Text
						 + "&gstr7=" + DLVL_TYPE.BindColVal;

		gcDs1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00119_s1?NOH=Y"+parm ; 
		gcDs1.Reset() ; 
	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(e){

		if (gcDs1.IsUpdated){
			if (confirm("�����Ͻ� ������û ������ ���Ͽ� �����Ͻðڽ��ϱ� ?")){	
				if (e=="01"){
					gcTr1.KeyValue = "tr00119_t1(I:USER=gcDs1)";
					gcTr1.Action = g_servlet+"/Transfer.tr00119_t1";
					gcTr1.Parameters = "v_str1=" + gs_moda +",v_str2=" + gs_userid;	
					gcTr1.post();
				} else if(e=="02"){
					gcTr1.KeyValue = "tr00119_t1(I:USER=gcDs1)";
					gcTr1.Action = g_servlet+"/Transfer.tr00119_t1";
					gcTr1.Parameters = "v_str1=" + gs_modb +",v_str2=" + gs_userid;	
					gcTr1.post();
				} else if(e=="03"){
					gcTr1.KeyValue = "tr00119_t1(I:USER=gcDs1)";
					gcTr1.Action = g_servlet+"/Transfer.tr00119_t1";
					gcTr1.Parameters = "v_str1=" + gs_modc +",v_str2=" + gs_userid;	
					gcTr1.post();
				}
			}
		}
	}
	
	/***********************************************************************************************
		Description : ��û��ü ã��
		parameter   : e==> 01 - Download, 02 - Upload
	**********************************************************************************************/
	function ln_Popup(){

		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "./tr00601_popup.jsp";
		arrParam[0]="ATUSEYN";
		strPos = "dialogWidth:395px;dialogHeight:519px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			CUST_CD.text = arrParam[0];
			CUST_CDNM.value = arrParam[1];
		} else {
			CUST_CD.text = "";
			CUST_CDNM.value ="";
		}
	} 

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "=����=" ;  
	}

	/******************************************************************************
		Description :  ADD COMBO == "����" 
	******************************************************************************/
	function AddChoiceProjct(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"PROJECT" )  = "" ; 
		obj.NameValue(1,"PROJECT_NM" )  = "=����=" ;  
	}
 </SCRIPT> 


<script language=JavaScript for=gcGR1 event=OnClick(row,colid)>

	if(colid == "CHECK") {
		if (gcDs1.NameValue(row,colid) == "T") gcDs1.NameValue(row,colid) = gcDs1.orgNameValue(row,colid);
		else gcDs1.NameValue(row,colid) = "T";
	} 
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>

<script language=JavaScript for=gcDs_etc2 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc2) ; 
	DLVL_TYPE.index = 0; 
</script> 
<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc3) ; 
	CARGO_TYPE.Index = 0 ; 
</script>

<script language=JavaScript for=LINE_PART event=OnSelChange2(row)>
	gcDs_etc11.Filter();
</script>

<script language=JavaScript for=gcDs_etc11 event=onFilter(row)>
	if (gcDs_etc11.NameValue(row,"LINE_PART") == LINE_PART.BindColVal) return true;
	else return false;
</script>

<script language=JavaScript for=gcDs_etc11 event=OnRowsetChanged()>
	if (gcDs_etc11.namevalue(1,"PROJECT")!="")	AddChoiceProjct(gcDs_etc11) ; 
	else gcDs_etc11.UndoAll();
</script>

 <!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
		TheStatusEnd(row) ; 
</script>

<script language="javascript" for="gcTr1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>

<script language="javascript" for="gcTr1" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
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
				<img src="../../../Common/img/com_b_sungin.gif" style="cursor:hand" onclick="ln_Save('01')">
				<img src="../../../Common/img/btn/btn_s_reservation.gif" style="cursor:hand" onclick="ln_Save('02')"> 
				<img src="../../../Common/img/btn/btn_s_cancle.gif" style="cursor:hand" onclick="ln_Save('03')">
				<img src="../../../Common/img/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11_left" style="height:30px;" bgcolor="#eeeeee">&nbsp;�ֹ���ȣ</td>
						<td class="tab11_left" align='left'>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:6px; width:180px; height:17px; font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="##############">
								<param name=PromptChar	  value="_">
								<param name=UpperFlag   value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab11_left" style="height:30px;" bgcolor="#eeeeee">&nbsp;��������</td>
						<td class="tab21">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:6px; width:65px; height:17px; font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:8px;top:2px;cursor:hand" onclick="__GetCallCalendar('FROM_DATE', 'Text');">&nbsp;&nbsp;~&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:2px;top:6px; width:65px; height:17px; font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:4px;top:2px;cursor:hand" onclick="__GetCallCalendar('TO_DATE', 'Text');">
						</td>
						
						<td class="tab11_left" bgcolor="#eeeeee">&nbsp;Project��</td>
						<td class="tab13_left" align='left'>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:2px;width:150px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
					<td class="tab12_left" style="height:30px" bgcolor="#eeeeee">&nbsp;���±���</td>
					<td class="tab12_left" align='left'>
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=CARGO_TYPE  style='border:0;position:relative;left:8px;top:1px;width:120px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=CBData			   value="''^=����=,R^��û,A^����,C^�ź�,B^����">
								<param name=CBDataColumns		value="Code,Parm">
								<param name=SearchColumn		value="Parm">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^80">
								<param name=BindColumn			value="Code">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
					
						<td class="tab12_left" bgcolor="#eeeeee">&nbsp;��û��ü��</td>
						<td class="tab12_left" align='left'>
						<%=HDConstant.COMMENT_START%>
							<OBJECT id=CUST_CD classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#######">
								<param name=PromptChar		value="_">
								<param name=Enable			value="false">
							</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;</nobr>
						<img name="btn_find" src="../../../Common/img/com_b_find.gif"	style="position:relative;top:2px;left:5px;cursor:hand"	 onclick="ln_Popup()">
						<input id="CUST_CDNM" name="CUST_CDNM" type="text" class="txt11" style='width:150;position:relative;left:8px;top:-2px;ime-mode:active'></td>
						<td class="tab12_left" bgcolor="#eeeeee">&nbsp;���籸��</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=DLVL_TYPE  style='border:0;position:relative;left:8px;top:1px;width:120px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc2>  
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^120">								
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td height=5px></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:0 solid #708090">
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:875;height:420px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true"> 
								<Param Name="UsingOneClick"     value="1">
								<PARAM NAME="Format"			VALUE=" 
								<F>	Name=''								ID='CHECK', 		width=20 	EditStyle=CheckBox HeadCheck=false Pointer=Hand 	HeadBgColor=#eeeeee HeadCheckShow=true align=center bgcolor=@acolor</F>
								<F> Name='SEQ'				 	 		ID='SeralNo' 		HeadAlign=Center HeadBgColor=#E8E8E8 Width=40	  align=center bgcolor='#EFEFEF' Value={ToString(CurRow)}	</F>
								<F> Name='������û��ȣ'				ID=MODIFY_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center</F> 
								<F> Name='��û����'     				ID=MOD_STS		HeadAlign=Center HeadBgColor=#eeeeee Width=60   align=center , EditStyle=Combo, Data='R:��û,A:����,C:����,B:����'</F> 
								<C> Name='�ֹ���ȣ'     				ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center </C> 
								<C> Name='��������'     				ID=ETD_DT			HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center  MASK='XXXX-XX-XX' </C>
								<C> Name='��û����'     				ID=REQ_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center   </C>
								<C> Name='��������'     				ID=APP_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center  </C>
								<C> Name='������Ʈ'					ID=LINE_PART		HeadAlign=Center HeadBgColor=#eeeeee Width=150  align=left editstyle=LookUp Data='gcDs_etc1:MINORCD:MINORNM'</C> 
								<C> Name='���籸��'					ID=CARGO_TYPE	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center editstyle=LookUp Data='gcDs_etc2:MINORCD:MINORNM'</C> 
								<C> Name='��ǰ����'					ID=DLVL_TYPE  	HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=center editstyle=LookUp Data='gcDs_etc33:MINORCD:MINORNM'</C> 
								<C> Name='��û��ü'					ID=CUST_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=201  align=left </C> 											
								<C> Name='�����'						ID=CUST_PRSN  	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left</C> 
								<C> Name='����ó'		   	 			ID=CUST_TELNO 	HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left  </C> 
								<C> Name=' ���� ��û ����'		    ID=MOD_REMARK HeadAlign=Center HeadBgColor=#eeeeee Width=1000  align=left  </C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 
			</td>
		</tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>


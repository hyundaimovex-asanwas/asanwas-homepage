<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ� ������ ��������
+ ���α׷� ID	: TR00209.HTML
+ �� �� �� ��	: ������ ��������
+ �� �� �� ��	: ���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :
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



<!-- /******************************************************************************
	Description : DataSet ����
******************************************************************************/ -->    
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=true>  
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
</OBJECT> 

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT> 

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT> 

<OBJECT id=gcDsBe classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>
<%=HDConstant.COMMENT_END%> 

 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ; 
	var gs_ordno = null ; 
	var gs_seq = null ; 
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
		Description :
	******************************************************************************/ 
	function Start(){
	
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCarAcc?NOH=Y&gstr1=";
		gcDs_etc2.Reset();

		gcDs_etc13.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //���� 
		gcDs_etc13.Reset(); 

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
		gcDsgetdate.Reset() ;

		if(gcDsgetdate.CountRow > 0 ) ETD_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 
		
	}



	/******************************************************************************
		Description : 
	******************************************************************************/
	function ls_EDI(){

	alert("������!");

	
	}




	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){
		var parm = "&gstr0=I"
						 + "&gstr1=" + ETD_DATE.Text
						 + "&gstr2=" + ORDER_NO.Text
						 + "&gstr3="
						 + "&gstr4=" + LINE_PART.BindColVal;

		gcDsBe.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsEdCar?NOH=Y"+parm; //���� "
		gcDsBe.Reset() ; 
	} 

 	/******************************************************************************
		Description :
	******************************************************************************/ 
	function CallLoadList(){
		if (confirm("���������� �ۼ��Ͻðڽ��ϱ� ?")){
			gcDs0.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCallSpTr00208?NOH=Y&gstr1="+ ETD_DATE.Text;
			gcDs0.Reset();

			if (gcDs0.namevalue(1,"PL2")=="C") alert("���������� ���������� �ۼ��Ǿ����ϴ�.");
			else alert("�������� �ۼ� �� ������ �߻��Ͽ����ϴ�.");
		}
  }

	/******************************************************************************
		Description :
	******************************************************************************/ 
  function ln_Save() {
		if (!gcDs1.isUpdated || gcDs1.countrow<1) return;

		if (confirm("�������� ������ �����Ͻðڽ��ϱ�?")){
			gcTr01.KeyValue = "trLoadLst2(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst2";
			gcTr01.post(); 
		}
  }

	/******************************************************************************
		Description : ������ ������������
	******************************************************************************/
	function ln_LoadSrh(e){
		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst2?NOH=Y&gstr7=" + e;
		gcDs1.Reset();
	}

	/******************************************************************************
		Description : ������� �˻�
	******************************************************************************/
	function ln_LoadData() {
		if (gcDsBe.countrow<1) return;

		var icnt = 0;
		for (var i=1; i<=gcDs1.countrow; i++){
			if (gcDs1.sysStatus(i)!="0") icnt++;
		}

		if (icnt>0) {
			alert("�������������� �����Ͻ� �� ��� �����͸� �˻��Ͻ� �� �ֽ��ϴ�.");
			return;
		}

		var strURL = "TR00109_E2.html";
		var myW = 730;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,window,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");

	}

	/******************************************************************************
		Description : ������� �˻�
	******************************************************************************/
	function ln_Del(){
		var row = gcDs1.rowposition;
		if (gcDs1.sysStatus(row)=="1") gcDs1.undo(row);
		else {
			if (confirm("�����Ͻ� �������� ������ �����Ͻðڽ��ϱ�?")){
				gcDs1.deleterow(gcDs1.rowposition);
				gcTr01.KeyValue = "trLoadLst2(I:USER=gcDs1)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst2";
				gcTr01.post(); 
			}
		}
	}

</SCRIPT> 

<script language=JavaScript for=gcDs1 event="OnLoadStarted()"> 
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible"; 
</script>

<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language=javascript for=gcgd_data1 event=onClick(row,colid)>
	ln_LoadSrh(gcDsBe.namevalue(row,"CAR_SEQ_NO"));
</script>

<script language="javascript" for=gcgd_data2 event=OnExit(row,colid,olddata)>
/*
	var org_val = gcDs1.OrgNameValue(row,"ARTC_CNT");
	var usr_val = gcDs1.NameValue(row,"ARTC_CNT");
	var org_cnt = gcDs1.NameValue(row,"ORG_CNT");
	var jaego_cnt = gcDs1.NameValue(row,"ORG_ARTC_CNT");

	if (org_val!=usr_val) {
		if (usr_val>org_cnt) {
			alert("���� �԰�� ��ǰ���� �̻��� �Է��Ͻ� �� �����ϴ�.");
			gcDs1.NameValue(row,"ARTC_CNT") = org_val;
			return;
		}
	} else {
		if (usr_val>org_cnt) {
			alert("���� �԰�� ��ǰ���� �̻��� �Է��Ͻ� �� �����ϴ�.");
			gcDs1.NameValue(row,"ARTC_CNT") = org_cnt;
			return;
		}
	}
	*/
</script>

<script language=javascript for=gcTr01 event=onSuccess()>
	alert("���������� ������ �Ϸ�Ǿ����ϴ�.");
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
			<td><img src="../img/TR00110_head.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../../common/img/btn/btn_edi.gif" style="cursor:hand" onclick="ls_EDI()">					
				<img src="../../common/img/btn/com_b_load.gif" style="cursor:hand" onclick="CallLoadList();">
				<img src="../../common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=70>��������</td>
						<td class="tab12_left">
						 <%=HDConstant.COMMENT_START%>
						 <OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:6px;top:2px;cursor:hand" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td>
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">�ֹ���ȣ</td>
						<td class="tab12_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="#############">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>

						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">��ü��</td>
						<td class="tab12_left" style="width:130px;">
						<input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:105;position:relative;left:8px;top:0px;ime-mode:active' ></td> 
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">Project</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;height:200;width:160px' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					</tr>
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2> 
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td height=25 bgcolor=#efefef colspan=2><B>&nbsp;&nbsp;�ֹ����� </B></td>
					</tr>
					<tr>
						<td class=tab11 style="border:0 solid #777777;border-top-width:1px;" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data1 style="width:100%;height:121px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDsBe">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true">  
								<PARAM NAME="Format"			VALUE="   
									<C> Name='������ȣ'		ID=CAR_SEQ_NO HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center</C> 
									<C> Name='��������'		ID=CAR_NAME		HeadAlign=Center HeadBgColor=#eeeeee Width=120	align=center</C> 
									<C> Name='����/����'	ID=IN_OUT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=center, EditStyle=combo, Data='I:����,O:����', show=false</C> 
									<C> Name='��ǥǰ��'		ID=CTN_STDRD	HeadAlign=Center HeadBgColor=#eeeeee Width=230	align=left</C> 
									<C> Name='����'				ID=CARGO_TYPE HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center</C>
									<C> Name='�ѿ���'			ID=CAR_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=right</C> 
									<C> Name='���߷�(KG)'	ID=CAR_TON		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C> 
									<C> Name='�ֹ���ȣ'		ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center</C> 
									<C> Name='���ҹ���'		ID=DIV_IO			HeadAlign=Center HeadBgColor=#eeeeee Width=60   align=left Value={Decode(DIV_IO,N,'�Ϲ�',Y,'���ҹ���','�Ϲ�')}, show=false</C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td style="height:5px;"></td></tr>
		<tr>
			<td colspan=2> 
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td height=25 bgcolor=#efefef><B>&nbsp;&nbsp;������������ </B></td>
						<td bgcolor=#efefef align=right>
							<!--<img src="../img/btn/btn_jaego.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadData()">-->
							<img src="../img/btn/b_save.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Save();">
							<img src="../img/btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Del();">
						</td>
						<td bgcolor=#efefef style="width:8px">&nbsp;</td>
					</tr>
					<tr>
						<td colspan=3>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2 style="width:100%;height:261px;border:0 solid #777777;border-top-width:1px" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true"> 
								<PARAM NAME="Format"			VALUE="  
									<F> Name='������ȣ' ID=CAR_SEQ_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center SUPPRESS=1, edit=none, editable=lookup, data='gcDs_etc2:CAR_SEQ_NO:CAR_NO'</F>
									<F> Name='�ֹ���ȣ' ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=90   align=center, edit=none </F>
									<F> Name='Seq'			ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center edit=none </F>
									<F> Name='ǰ��'			ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  edit=none </F>
									<C> Name='�԰�'			ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left edit=none, show=false </C>
									<C> Name='����'			ID=ARTC_UNIT	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=left  editstyle=LookUp Data='gcDs_etc13:MINORCD:MINORNM' edit=none</C>
									<C> Name='�԰����'	ID=ORG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=85		align=right, edit=none, bgcolor=#FAFCA7, show=false </C>
									<C> Name='����'			ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=85		align=right </C>
									<G> Name='��������' HeadBgColor=#eeeeee
										<C> Name='����'				ID=PUNIT_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=75		align=right, Dec=0, edit=none</C>
										<C> Name='�߷�(KG)'		ID='PUNIT_WEIGHT' HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, Dec=1, edit=none</C>
										<C> Name='����(CM)'		ID=PKG_LNGTH			HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none</C>
										<C> Name='��(CM)'			ID=PKG_WIDTH			HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none</C>
										<C> Name='����(CM)'		ID=PKG_HEIGHT			HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none</C>
										<C> Name='����(CBM)'  ID='' HeadAlign=Center HeadBgColor=#eeeeee Width=125  align=right, Value={PKG_LNGTH * PKG_HEIGHT * PKG_WIDTH / 1000000}, Dec=2, edit=none</C>
									</G>
									<C> Name='�Ѽ���'		ID='' HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, Value={ARTC_CNT/PUNIT_CNT},	Edit=none, Dec=2 </C>
									<C> Name='���߷�(KG)'		ID='' HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right, Value={PUNIT_WEIGHT*(ARTC_CNT/PUNIT_CNT)}, dec=2</C>
									<C> Name='�Ѽ���'		ID=ARTC_CNT HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right, show=false</C>
									<C> Name='���߷�'		ID=ARTC_CNT HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right, show=false</C>
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
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>


<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ�  �����ֹ���ȸ
+ ���α׷� ID	: TR00104.HTML
+ �� �� �� ��	: �����������
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
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>
</OBJECT>

<OBJECT id=gcDs_etc1_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>
</OBJECT>

<OBJECT id=gcDsDel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�ֹ� ������-->
</OBJECT>
<%=HDConstant.COMMENT_END%>


<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ;
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

		Save_bnt.style.display= "";

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project
		gcDs_etc1.Reset();

		gcDs_etc1_fr.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project
		gcDs_etc1_fr.Reset();

		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //���籸��
		gcDs_etc5.Reset();

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project
		gcDsgetdate.Reset() ;

		gcDs_etc0.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //����
		gcDs_etc0.Reset() ;

		if(gcDsgetdate.CountRow > 0 ) ETD_DT.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 


	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Query(){

		if(ETD_DT.Text == "" ) alert("�������ڸ� �Է��Ͻʽÿ�");

		var parm = "&gstr0=O"
						 + "&gstr1=" + ETD_DT.Text
						 + "&gstr2=" + ORDER_NO.Text
						 + "&gstr3=" + CAR_SEQ_NO.Text
						 + "&gstr4=" + LINE_PART.BindColVal;

		gcDs1.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsEdCar?NOH=Y"+parm; //���� "

		gcDs1.Reset() ;

	}

	/******************************************************************************
		Description : EDI ���� �˾�
	******************************************************************************/
	function ln_EDI_Send(){

		var strURL = "tr00104_EDI.jsp";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();

		arrParam[0]="A"; //�ֹ���������

		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");

	}

	/******************************************************************************
		Description : EDI ���� �˾�
	******************************************************************************/

	function ln_EDI_Receive(){

		var strURL = "tr00104_EDI_Receive.jsp";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();

		arrParam[0]="A"; //�ֹ���������

		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");

	}

	/******************************************************************************
		Description : �����߰�
	******************************************************************************/
	function NewCar(){

		strURL = "tr00104_e1.jsp?gstr1=&gstr2=insert&gstr3=O";
		PopupOpenDialog(350,230) ;
		gcDs1.Reset() ;
	}

	/******************************************************************************
		Description : ��������
	******************************************************************************/
	function UpdateCar(){

		var car_seq_no = null ;
    car_seq_no = gcDs1.NameValue(gcDs1.RowPosition,"CAR_SEQ_NO") ;

		strURL = "tr00104_e1.jsp?gstr1="+car_seq_no+"&gstr2=update&gstr3=O";
		PopupOpenDialog(350,230) ;
		gcDs1.Reset() ;
	}

	/******************************************************************************
		Description : ��������
	******************************************************************************/
	function ln_Delete(){

		if (confirm("�����Ͻ� ������ ����� ��ǰ ������ �Բ� �����˴ϴ�.  \n\n�����Ͻ� ������ �����Ͻðڽ��ϱ� ?  ")) {
			var row = gcDs1.rowposition;

			gcDsDel.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderCar2?v_str1=" + gcDs1.namevalue(row,"ORDER_NO") + "&v_str2=" + gcDs1.namevalue(row,"CAR_SEQ_NO"); //�ֹ���ȣ
			gcDsDel.Reset();

			if (gcDsDel.namevalue(1,"rst")=="Y") {
				gcDs1.DeleteRow(row);
				alert("���������� �����Ǿ����ϴ�.");
				gcDs1.Reset();
				gcDs2.Reset();
			}
		}
	}

	/******************************************************************************
		Description : �����ڷ� ����
	******************************************************************************/
  function CarGoods_SAVE(){

		if (!gcDs2.isUpdated) return;

		if (confirm("�������� ������ �����Ͻðڽ��ϱ� ?  ")){
			var ls_car_seq_no = gcDs1.NameValue(gcDs1.RowPosition,"CAR_SEQ_NO");
			var gs_ordno = gcDs1.NameValue(gcDs1.RowPosition,"ORDER_NO");

			gcTr01.KeyValue = "trOrderRegCarGoods(I:USER=gcDs2)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderRegCarGoodsEtc";
			gcTr01.Parameters = "gstr1="+gs_ordno+",gstr2="+ ls_car_seq_no ; //�ֹ���ȣ
			gcTr01.post();
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function gcGR2ColorChange(row,eventid){

		if(eventid == "acolor") {
			if(gcDs2.NameValue(row,"CHECK") == "T" ) return '#FAFCA7' ;
			else return '#FFFFFF' ;
		}

		if(eventid == "acolor1") {
			if(gcDs2.NameValue(row,"CHECK") == "T" ) return '#FFCCCC' ;
			else return '#FFFFFF' ;
		}

		if(eventid == "acolor2") {
			if(gcDs2.NameValue(row,"EXT_PKG_CNT") != 0 ) return "#FF0033" ;
			else return "#330000" ;
		}

		if(eventid == "acolor3") {
			if(gcDs2.NameValue(row,"EXT_ARTC_CNT") != 0 )	return "#FF0033" ;
			else return "#330000" ;
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function CheckTrueDataMove(row,colid){
		if(gcDs2.NameValue(row,colid) =="T"){ //üũ�Ǿ�����
			gcDs2.NameValue(row,"EXT_PKG_CNT") = 0 ;
			gcDs2.NameValue(row,"LD_PKG_CNT") = gcDs2.OrgNameValue(row,"EXT_PKG_CNT") * 1 + gcDs2.OrgNameValue(row,"LD_PKG_CNT") *1;
			CalLoadCarCargo(row,'LD_PKG_CNT');
			gcDs2.NameValue(row,"EXT_ARTC_CNT") = 0 ;
			gcDs2.NameValue(row,"LD_ARTC_CNT") = gcDs2.OrgNameValue(row,"EXT_ARTC_CNT") * 1 + gcDs2.OrgNameValue(row,"LD_ARTC_CNT") *1; ;
		}	else { //üũ ���� �Ǿ�����
			gcDs2.NameValue(row,"EXT_PKG_CNT") =gcDs2.OrgNameValue(row,"EXT_PKG_CNT") * 1 + gcDs2.OrgNameValue(row,"LD_PKG_CNT") *1;
			gcDs2.NameValue(row,"LD_PKG_CNT") = 0 ;
			CalLoadCarCargo(row,'LD_PKG_CNT');
			gcDs2.NameValue(row,"EXT_ARTC_CNT") =gcDs2.OrgNameValue(row,"EXT_ARTC_CNT") * 1 + gcDs2.OrgNameValue(row,"LD_ARTC_CNT") *1; ;
			gcDs2.NameValue(row,"LD_ARTC_CNT") = 0 ;
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function CalLoadCarCargo(row,colid){
		if(colid =="LD_PKG_CNT"   ){
			if(gcDs2.NameValue(row,"SAMEAS") !='T' ){
				gcDs2.NameValue(row,"EXT_PKG_CNT") = gcDs2.OrgNameValue(row,"EXT_PKG_CNT") * 1 + gcDs2.OrgNameValue(row,"LD_PKG_CNT")* 1  - gcDs2.NameValue(row,"LD_PKG_CNT") ;
				gcDs2.NameValue(row,"LD_ARTC_CNT") = gcDs2.NameValue(row,"PUNIT_CNT") * gcDs2.NameValue(row,"LD_PKG_CNT") ;
				gcDs2.NameValue(row,"EXT_ARTC_CNT")= gcDs2.OrgNameValue(row,"EXT_ARTC_CNT")*1 + gcDs2.OrgNameValue(row,"LD_ARTC_CNT")*1- gcDs2.NameValue(row,"LD_ARTC_CNT") ;
				gcDs2.NameValue(row,"LD_PUNIT_WGHT")= gcDs2.NameValue(row,"PUNIT_WGHT") * gcDs2.NameValue(row,"LD_PKG_CNT");
				gcDs2.NameValue(row,"LD_PKG_CBM")=gcDs2.NameValue(row,"PKG_CBM")  * gcDs2.NameValue(row,"LD_PKG_CNT");
				gcDs2.NameValue(row,"LD_PKG_WGHT")=gcDs2.NameValue(row,"PUNIT_WGHT")  * gcDs2.NameValue(row,"LD_PKG_CNT");
			}	else {
				gcDs2.NameValue(row,"EXT_PKG_CNT") =gcDs2.OrgNameValue(row,"EXT_PKG_CNT")*1+gcDs2.OrgNameValue(row,"LD_PKG_CNT")*1 - gcDs2.NameValue(row,"LD_PKG_CNT") ;
			}
		}

		if(colid =="LD_ARTC_CNT"   ){
			if(gcDs2.NameValue(row,"SAMEAS") !='T'){
				gcDs2.NameValue(row,"EXT_ARTC_CNT") =gcDs2.OrgNameValue(row,"EXT_ARTC_CNT")*1 + gcDs2.OrgNameValue(row,"LD_ARTC_CNT") *1 - gcDs2.NameValue(row,"LD_ARTC_CNT") ;
			}	else {
				gcDs2.NameValue(row,"EXT_ARTC_CNT") =gcDs2.OrgNameValue(row,"EXT_ARTC_CNT")*1 + gcDs2.OrgNameValue(row,"LD_ARTC_CNT") *1 - gcDs2.NameValue(row,"LD_ARTC_CNT") ;
			}
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function CheckTrueSameAs(row,colid){
		if(colid =="CHECK" ){
			var ls_check	= gcDs2.NameValue(row,colid)  ;
			var ls_no			= gcDs2.NameValue(row,"ORDER_NO") ;
			var ls_pkg		= gcDs2.NameValue(row,"ORDER_SEQ") ;
			var ls_pkg1		= gcDs2.NameValue(row,"SAMEAS") ;

			if (strim(ls_pkg1)=="" || strim(ls_pkg1)=="F" )	{
				CheckTrueDataMove(row,'CHECK');
			} else {
				for(i=1; i<=gcDs2.CountRow; i++) {
					if(ls_no == gcDs2.namevalue(i,"ORDER_NO") && ls_pkg1 == gcDs2.NameValue(i,"SAMEAS") ){
						gcDs2.NameValue(i,colid) = ls_check ;
						CheckTrueDataMove(i,'CHECK');
					}
				}
			}
		}
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
		Description : �����ڷ�
	******************************************************************************/
	function ln_LoadData(e){

		var row = gcDs1.rowposition;
		if (e=="B") LoadCarLD(row);
		else {
			var ls_car_seq_no = gcDs1.NameValue(row,"CAR_SEQ_NO") ;
			var in_out				= gcDs1.NameValue(row,"IN_OUT") ;
			var order_no			= gcDs1.NameValue(row,"ORDER_NO") ;
			var div_io				= gcDs1.NameValue(row,"DIV_IO") ;
			var edt_date			= gcDs1.NameValue(row,"EDT_DATE") ;

			gcDs2.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsEtc?NOH=Y&gstr1=&gstr2="+ ls_car_seq_no+"&gstr3="+in_out+"&gstr4="+div_io+"&gstr5="+edt_date+"&gstr6="+LINE_PART_fr.BindColVal;

			gcDs2.Reset() ;
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function LoadCarLD(row){

		var ls_car_seq_no = gcDs1.NameValue(row,"CAR_SEQ_NO") ;
		var in_out				= gcDs1.NameValue(row,"IN_OUT") ;
		var order_no			= gcDs1.NameValue(row,"ORDER_NO") ;
		var div_io				= gcDs1.NameValue(row,"DIV_IO") ;
		var edt_date			= gcDs1.NameValue(row,"EDT_DATE") ;

		if(div_io == "") div_io = "N";

		if( order_no != null && div_io =="Y"){
			alert("���� ������ �������� �ʽ��ϴ�. ") ;
			Save_bnt.style.display = "none";
		}	else {
			Save_bnt.style.display= "";
		}

		gcDs2.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsEtc1?NOH=Y&gstr1=&gstr2="+ ls_car_seq_no+"&gstr3="+in_out+"&gstr4="+div_io+"&gstr5="+edt_date;

		gcDs2.Reset() ;

	}
</SCRIPT>

<script language=JavaScript for=gcGR2 event=OnUserColor(row,eventid)>
	return gcGR2ColorChange(row,eventid);
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc1) ;
	LINE_PART.Index = 0 ;
</script>

<script language=JavaScript for=gcDs_etc1_fr event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc1_fr) ;
	LINE_PART_fr.Index = 0 ;
</script>

<script language=JavaScript for=gcGR2 event=OnExit(row,colid,olddata)>
	CalLoadCarCargo(row,colid) ;
</script>

<script language=JavaScript for=gcGR2 event=OnClick(row,colid)>

	if (row<1) return;
	if(colid=="CHECK"){
		if (gcDs2.NameValue(row,colid)=="T") gcDs2.NameValue(row,colid) = "F";
		else gcDs2.NameValue(row,colid) = "T";
	}
	CheckTrueSameAs(row,colid);
</script>

<script language="javascript"  for=gcGR2 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if (Colid=="CHECK"){
		if (bCheck=="1"){
			for (var i=1; i<=gcDs2.countrow; i++) {
				gcDs2.namevalue(i,"CHECK") = "T";
				CheckTrueSameAs(i,"CHECK");
			}
		} else {
			for (var i=1; i<=gcDs2.countrow; i++) {
				gcDs2.namevalue(i,"CHECK") = "F";
				CheckTrueSameAs(i,"CHECK");
			}
		}
	}
</script>

<script language=JavaScript for=gcGr1 event=OnClick(row,colid)>

	var row= gcDs1.RowPosition ;
	LoadCarLD(row) ;

</script>

 <!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1 event="OnLoadStarted()">
	//OnStatusStart() ;
</script>

<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
		//TheStatusEnd(row) ;
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
			<td  width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;position:relative; left:-2px;">
				<img src="../../../Common/img/btn/btn_edi.gif"     style="cursor:hand" onclick="ln_EDI_Send()">
				<img src="../../../Common/img/btn/btn_edi_re.gif" style="cursor:hand" onclick="ln_EDI_Receive()">
				<img src="../../../Common/img/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:884px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee" width=75>��������</td>
						<td class="tab12_left" style="width:140px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ETD_DT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:6px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:6px;top:0px;cursor:hand" onclick="__GetCallCalendar('ETD_DT', 'Text');">
						</td>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee"  width=75>�ֹ���ȣ</td>
						<td class="tab12_left" style="width:120px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:6px;top:3px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="###########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee" width=75>������ȣ</td>
						<td class="tab12_left" style="width:120px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=CAR_SEQ_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:6px;top:3px; width:60px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="#########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee" width=75>�����</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:6px;top:0px;width:160px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD">
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true">
								<param name=ComboStyle			value=2>
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
				<table  cellpadding="0" cellspacing="0" border="0" style="width:100%;height:300px;font-size:9pt;background-color:#ffffff;border:0 solid #708090;border-right-width:0px;" >
					<tr>
						<td bgcolor="#eeeeee" style="border:1 solid #777777;" class=tab11_right1 align="right">
							<img src="../../../Common/img/btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Delete()" alt="�ֹ����� ������ �����մϴ�.">
							<img src="../../../Common/img/btn/b_write.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="NewCar();" alt="�ֹ����� ������ �߰��մϴ�.">
							<img src="../../../Common/img/btn/update.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="UpdateCar();" alt="�ֹ����� ������ �����մϴ�.">&nbsp;
							<!-- <img src="../img/btn/b_save.gif" style="cursor:hand" style="position:relative;left:0px;top:2px" onclick="ln_Query()">  -->
						</td>
					</tr>
					<tr>
						<td class=tab11 style="border:1 solid #777777;border-top-width:0px;" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGr1 style="width:100%;height:121px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true">
								<PARAM NAME="Format"			VALUE="
									<C> Name='��û��ü��'		ID=USERNM		    	HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=LEFT  show=false</C>
									<C> Name='��ȭ��'		    	ID=VEND_NM		  	HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=LEFT   suppress=1</C>
									<C> Name='������ȣ'			ID=CAR_SEQ_NO  	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center  </C>
									<C> Name='��������'			ID=CAR_NAME		  	HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left</C>
									<C> Name='����'				  	ID=CARGO_TYPE		HeadAlign=Center HeadBgColor=#eeeeee Width=40   align=left edit=none  </C>
									<C> Name='��ǥǰ��'			ID=CTN_STDRD	  	HeadAlign=Center HeadBgColor=#eeeeee Width=178	align=left</C>
									<C> Name='������'				ID=LD_CARGONM		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left edit=none  </C>
									<C> Name='������'				ID=OFF_CARGONM	HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left edit=none </C>
									<C> Name='�ֹ���ȣ'			ID=ORDER_NO		 	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center</C>
									<C> Name='����'			    	ID=ORDER_STS		HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=center  EditStyle=Lookup Data='gcDs_etc0:MINORCD:MINORNM'</C>
									<C> Name='����'			    	ID=ING_STS		  		HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=center  EditStyle=combo, Data='I:�ű�,C:���'</C>
									<C> Name='����/����'			ID=IN_OUT				HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=center, EditStyle=combo, Data='I:����,O:����', show=false</C>
									<C> Name='����'					ID=CARGO_TYPE 	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center, show=false</C>
									<C> Name='�ѿ���(CBM)'		ID=CAR_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=right, show=false</C>
									<C> Name='���߷�(KG)'		ID=CAR_TON			HeadAlign=Center HeadBgColor=#eeeeee Width=110  align=right, show=false</C>
									<C> Name='���ҹ���'			ID=DIV_IO					HeadAlign=Center HeadBgColor=#eeeeee Width=60   align=left Value={Decode(DIV_IO,N,'�Ϲ�',Y,'���ҹ���','�Ϲ�')}, show=false</C>
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr><td height=5px></td></tr>
					<tr>
						<td style="border:1 solid #777777;" bgcolor="#eeeeee" align=right>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART_fr  style='border:0;position:relative;left:-6px;top:1px;width:160px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 bgcolor="white">
								<param name=ComboDataID		value=gcDs_etc1_fr>
								<param name=CBDataColumns	value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD">
								<param name=Sort						value=True>
								<param name=ListExprFormat		value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index					value=0>
								<param name=InheritColor			value="true">
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn/btn_carper.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadData('B')">
							<img src="../../../Common/img/btn/btn_bef.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadData('A')">
							<img id="Save_bnt" src="../../../Common/img/btn/b_save.gif" style="position:relative;left:0px;top:2px;display:none;cursor:hand" onclick="CarGoods_SAVE();" alt="�����Ͻ� ���������� �����մϴ�.">&nbsp;
						</td>
					</tr>
					<tr>
						<td class="tab11" style="border:1 solid #777777;border-top-width:0px;" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR2 style="width:100%;height:261px;display:block" viewastext>
								<PARAM NAME="DataID"					VALUE="gcDs2">
								<PARAM NAME="BorderStyle"			VALUE="0">
								<PARAM NAME="Fillarea"					VALUE="true">
								<PARAM NAME="Editable"					VALUE="true">
								<PARAM NAME="AllShowEdit"			VALUE="true">
								<PARAM NAME="EdgeLLineColor"	VALUE="Blue">
								<PARAM NAME="ColSizing"				VALUE="true">
								<PARAM NAME="TitleHeight"				VALUE="22">
								<PARAM NAME="RowHeight"			VALUE="20">
								<PARAM NAME="Format"					VALUE="
									<F> Name=''				ID=CHECK			HeadAlign=Center HeadBgColor=#eeeeee Width=20 Pointer=Hand EditStyle=CheckBox HeadCheck=false HeadCheckShow=true align=center, </F>
									<F> Name='No.'		ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center  edit=none bgcolor=@acolor</F>
									<F> Name='I/O'		ID=IN_OUT			HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center, edit=none, EditStyle=combo, Data='I:����,O:����', show=false</F>
									<F> Name='��ȭ��'	ID=VEND_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left    edit=none bgcolor=@acolor sumtext='Total' suppress=1</F>
									<F> Name='ǰ��'		ID=ARTC_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left    edit=none bgcolor=@acolor sumtext='Total'</F>
									<G> Name='����' HeadBgColor=#eeeeee
										<C> Name='��ǰ����'		ID=ARTC_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none show=false bgcolor=@acolor</C>
										<C> Name='�������'		ID=LD_ARTC_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=RealNumeric BGCOLOR=#CCCCFF bgcolor=@acolor1</C>
										<C> Name='�ܿ�����'		ID=EXT_ARTC_CNT 	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none bgcolor=@acolor Color=@acolor3</C>
									</G>
									<G> Name= '�������' HeadBgColor=#eeeeee
										<C> Name='�������'		ID=PKG_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none show=false bgcolor=@acolor</C>
										<C> Name='�������'		ID=LD_PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=RealNumeric bgcolor=@acolor1</C>
										<C> Name='�ܿ�����'		ID=EXT_PKG_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=right,edit=none  bgcolor=@acolor Color=@acolor2</C>
									</G>
									<G> Name='��������' HeadBgColor=#eeeeee
										<C> Name='����(CM)'		ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right show=TRUE bgcolor=@acolor</C>
										<C> Name='��(CM)'			ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right show=TRUE bgcolor=@acolor</C>
										<C> Name='����(CM)'		ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right show=TRUE bgcolor=@acolor</C>
										<C> Name='HSCODE' 		ID=HSCODE  			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left show=false bgcolor=@acolor</C>
									</G>
									<C> Name='���߷�(KG)'		ID=LD_PKG_WGHT	HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right bgcolor=@acolor</C>
									<C> Name='�ѿ���(CBM)'		ID=LD_PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right bgcolor=@acolor sumtext=@sum</C>
									<C> Name='�ֹ���ȣ' 			ID=order_no  			HeadAlign=Center HeadBgColor=#eeeeee Width=88  align=center show=true bgcolor=@acolor, edit=none</C>
									<C> Name='����'					ID=ARTC_UNIT			HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left edit=none show=false bgcolor=@acolor</C>
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


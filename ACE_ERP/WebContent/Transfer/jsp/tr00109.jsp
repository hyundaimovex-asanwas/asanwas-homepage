<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ� ������ ��������
+ ���α׷� ID	: TR00109.HTML
+ �� �� �� ��	: ������ ��������
+ �� �� �� ��	: ���̼�
+ �� �� �� ��	: TR00109.HTML
-----------------------------------------------------------------------------
+ �� �� �� �� : ���� ���� �ݿ� 	
+ ��   ��  �� : ������
+ �� �� �� �� : 2008.10.22
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
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><!-- <param name=UseChangeInfo    value=false>   -->
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDs0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> <!--�������� �ϰ� -->
</OBJECT>

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDsBe classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
</OBJECT>
<%=HDConstant.COMMENT_END%> 

 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�������� �Ǻ�-->
</OBJECT>

<OBJECT id="gcTr02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--�������� �ϰ�-->
  <param name="keyvalue" value="trLoadLst3_batch(I:USER=gcDs0)">   
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

		//f(gcDsgetdate.CountRow > 0 ) ETD_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 
		ETD_DATE.Text = gs_date;
		
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ls_EDI(){
	
		var strURL = "TR00104_EDI.html";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();
		
		arrParam[0]="B"; //�ֹ���������
		
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}


		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){
		var parm = "&gstr0=O"                   //O - ����, I- ���� 
						 + "&gstr1=" + ETD_DATE.Text    //��������
						 + "&gstr2=" + ORDER_NO.Text    //�ֹ���ȣ
						 + "&gstr3="                    // 
						 + "&gstr4=" + fn_trim(LINE_PART.BindColVal) //�����
						 + "&gstr5=" + CUST_NM.value;       //��ü�� 
						// + "&gstr6=T";

		gcDsBe.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsEdCar3?NOH=Y"+parm; //���� "

		gcDsBe.Reset() ; 
	} 
	
 	/******************************************************************************
		Description : �����ۼ�����
	******************************************************************************/ 
	function CallLoadList(){
	
	  	ln_SetDataHeader();
    	gcDs0.Addrow();
    	gcDs0.namevalue(gcDs0.rowposition,"ETD_DATE") =fn_trim(ETD_DATE.text);//��������
		gcDs0.namevalue(gcDs0.rowposition,"LINE_PART")=fn_trim(LINE_PART.bindcolval) ;//�����
		gcDs0.namevalue(gcDs0.rowposition,"GUSER") =gusrid ;//�����

		if (confirm("��������� �� �԰�� �����͸�\n\n���������� �ϰ� �ۼ��Ͻðڽ��ϱ�?")){       
      	gcTr02.Action ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst3_batch?"; 

			gcTr02.post();
			
		}

   /**
		if (confirm("���������� �ۼ��Ͻðڽ��ϱ� ?")){
			for(i =1 ; i<=gcDsBe.CountRow ; i++ ) {
				if(gcDsBe.NameValue(i,"CHK") =="T"){
					gcDs0.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCallSpTr00108?NOH=Y&gstr1="+ ETD_DATE.Text
					                                                              +"&gstr2="+gcDsBe.namevalue(i,"CAR_SEQ_NO") + "&gstr4=T" ;
					gcDs0.Reset();
					// 2007.09.04 ������ ����.
					if (gcDs0.namevalue(1,"PL2")=="C") alert("���������� ���������� �ۼ��Ǿ����ϴ�.");
					else alert("�������� �ۼ� �� ������ �߻��Ͽ����ϴ�.");
				}
		 }
	}
	**/
	
}
	/******************************************************************************
		Description :
	******************************************************************************/ 
  function ln_Save() {
  
		if (!gcDs2.isUpdated || gcDs2.countrow<1) return;

		if (confirm("�������� ������ �����Ͻðڽ��ϱ�?")){
		
			gcTr01.KeyValue = "trLoadLst3(I:USER=gcDs2)";
			
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst3";

			gcTr01.post(); 
		}
  }

	/******************************************************************************
		Description : ������ ������������
    Parameter   : A-���ǿ� �´� ��ü
		              �׿ܴ� ��������

	******************************************************************************/
	function ln_LoadSrh(e){

   //2008.03.08 ������ ����.
   /*
	  if(e=="A"){
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3?NOH=Y&gstr2=" + ORDER_NO.text 
			                                                         +"&gstr3=" + ETD_DATE.text
																															 +"&gstr4=" + CUST_NM.value
																															 +"&gstr5=O"
																															 +"&gstr6=" + LINE_PART.bindcolval
			gcDs2.Reset();
		}else{
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3?NOH=Y&gstr7=" + e;
			gcDs2.Reset();
		}
 */

	 if(e=="A"){
	    // �˻��������� ��ȸ
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3_1?NOH=Y&gstr1="                          //������ȣ       
			                                                         +"&gstr2=" + ETD_DATE.text					 //��������       
																															 +"&gstr3=" + ORDER_NO.text 				 //�ֹ���ȣ       
																															 +"&gstr4=" + CUST_NM.value					 //�ŷ�ó         
																															 +"&gstr5=" + fn_trim(LINE_PART.bindcolval)	 //�����         
																															 +"&gstr6=O";												 //���ⱸ���ڵ�   


			gcDs2.Reset();
		}else{
		  //�������� �׸��� Ŭ���� ������ȣ�� ��ȸ
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3_1?NOH=Y&gstr1=" + e
			                                                         +"&gstr2=" 
																															 +"&gstr3=" 
																															 +"&gstr4="
																															 +"&gstr5=" 
						
																															 +"&gstr6=O"; //����


			gcDs2.Reset();
		}
	}

 /******************************************************************************
		Description : ������ ��ȸ
	******************************************************************************/
	function LoadCarLD(row){
		var ls_car_seq_no = gcDsBe.NameValue(row,"CAR_SEQ_NO") ; 
		var in_out				= gcDsBe.NameValue(row,"IN_OUT") ; 
		var order_no			= gcDsBe.NameValue(row,"ORDER_NO") ; 
		var div_io				= gcDsBe.NameValue(row,"DIV_IO") ; 
		var edt_date			= gcDsBe.NameValue(row,"EDT_DATE") ;  

		if(div_io == "") div_io = "N";

   //20070828 ������ ����
   /*****
		if( order_no != null && div_io =="Y"){ 
			alert("���� ������ �������� �ʽ��ϴ�. ") ; 
			Save_bnt.style.display = "none";  
		}	else {
			Save_bnt.style.display= "";  
		}
   ***/
 
		gcDs2.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsEtc3?NOH=Y&gstr1=&gstr2="+ ls_car_seq_no+"&gstr3="+in_out+"&gstr4="+div_io+"&gstr5="+edt_date;
		gcDs2.Reset() ; 
	}



	/******************************************************************************
		Description : ������� �˻�
	******************************************************************************/
	function ln_LoadData() {
		if (gcDsBe.countrow<1) return;

    var icnt_0=0;
		var icnt = 0;

		for(var j=1;j<=gcDsBe.countrow;j++){
			if (gcDsBe.sysStatus(j)!="0") icnt_0++;
		}

		if (icnt_0==0) {
			alert("���������� �����Ͻʽÿ�.");
			return;
		}

		if (icnt_0>1) {
			alert("���������� �Ѱ��� �����Ͻʽÿ�.");
			gcDsBe.undoall();
			return;
		}


		for (var i=1; i<=gcDs2.countrow; i++){
			if (gcDs2.sysStatus(i)!="0") icnt++;
		}

		if (icnt>0) {
			alert("�������������� �����Ͻ� �� ��� �����͸� �˻��Ͻ� �� �ֽ��ϴ�.");
			return;
		}

		var strURL = "TR00109_E2.html";
		var myW = 850;
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
	/*function ln_Del(){
		var row = gcDs2.rowposition;
		if (gcDs2.sysStatus(row)=="1") gcDs2.undo(row);
		else {
			if (confirm("�����Ͻ� �������� ������ �����Ͻðڽ��ϱ�?")){
				gcDs2.deleterow(gcDs2.rowposition);
				gcTr01.KeyValue = "trLoadLst2(I:USER=gcDs2)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst2";
				gcTr01.post(); 
			}
		}
	}*/

	/******************************************************************************
		Description : ����������������
	******************************************************************************/
	function ln_Del(){

		var row = gcDs2.rowposition;
		if (gcDs2.sysStatus(row)=="1") gcDs2.undo(row);
		else {
		  //EDI ���۰��� �����Ұ�
			if(!ln_Chk_Del()) return;

			if (confirm("�����Ͻ� �������� ������ �����Ͻðڽ��ϱ�?")){
				  gcDs2.ClearAllMark();
					
					for (var i=1; i<=gcDs2.countrow; i++ ) {
						if(gcDs2.NameValue(i,"CHK") =="T"){
					  	gcDs2.RowMark(i)=1;
						}
					}
					gcDs2.DeleteMarked();
					gcTr01.KeyValue = "trLoadLst3(I:USER=gcDs2)";
					gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst3";

					gcTr01.post(); 
			}
		}
	}

 /******************************************************************************
		Description : ������������������ üũ : EDI ���۰��� ���� �� ��.
	******************************************************************************/
  function ln_Chk_Del(){

		return true;
	}

  /******************************************************************************
		Description : ���ǿ� ���� Grid ���� ����
	******************************************************************************/
	function gcGR2ColorChange(row,eventid){
		if(eventid == "acolor") {
			if(gcgd_data2.NameValue(row,"CHK") == "T" ) return '#FAFCA7' ; 
			else return '#FFFFFF' ; 
		}

		if(eventid == "acolor1") {
			if(gcgd_data2.NameValue(row,"CHK") == "T" ) return '#FFCCCC' ; 
			else return '#FFFFFF' ; 
		}

		if(eventid == "acolor2") { 
			if(gcgd_data2.NameValue(row,"EXT_PKG_CNT") != 0 ) return "#FF0033" ;
			else return "#330000" ;
		}

		if(eventid == "acolor3") { 
			if(gcgd_data2.NameValue(row,"EXT_ARTC_CNT") != 0 )	return "#FF0033" ;
			else return "#330000" ;
		}
	}

  /******************************************************************************
		Description : DataSet Head ����
	******************************************************************************/
	function ln_SetDataHeader(){
		if (gcDs0.countrow<1){   
			var s_temp = "ETD_DATE:STRING(8),LINE_PART:STRING(4),GUSER:STRING(10)"
			gcDs0.SetDataHeader(s_temp);
		}
  }

	/******************************************************************************
		Description : ������������Ÿ���� �԰�������� �԰�� ����Ÿ Ȯ��
	******************************************************************************/
	function ln_Popup_INWRHS(row){
		var strURL = "TR00109_E3_Popup.html";
		var myW = 440;
		var myH = 200;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,window,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
	}

/******************************************************************************
		Description : ��������
		2008.10.22 �߰�
 *****************************************************************************/
 function ln_EDI_Receive(){
		var strURL = "TR00104_EDI_Receive.html";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();
		
		arrParam[0]="D"; //����
		
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
 }
</SCRIPT> 

<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDsBe event="OnLoadStarted()">
	//OnStatusStart() ; 
</script> 
<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDsBe  event="onloadCompleted(row,colid)">
	//	TheStatusEnd(row) ; 
</script>

<script language=JavaScript for=gcDs2 event="OnLoadStarted()"> 
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible"; 
</script>

<script language=JavaScript for=gcDs2  event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden"; 
	// if (row <1) alert("�˻��� �����Ͱ� �����ϴ�!");      // 2007. 02. 08 �̵��� ����
</script>


<script language=javascript for=gcgd_data1 event=onClick(row,colid)>
	var strFlag="";
	if(row<1){
		if(colid=="CHK"){
			if(gcDsBe.namevalue(1,colid)=="T")	strFlag="F";
			else strFlag="T";
			for(i=1;i<=gcDsBe.countrow;i++){
				gcDsBe.namevalue(i,"CHK")=strFlag;
			}
			return;
		}else{
			return;
		}
	}
  
	gcDsBe.UndoAll();
  if(colid == "CHK") {
		if (gcDsBe.NameValue(row,colid) == "T") gcDsBe.NameValue(row,colid) = "F";
		else gcDsBe.NameValue(row,colid) = "T";
	} 

	ln_LoadSrh(gcDsBe.namevalue(row,"CAR_SEQ_NO"));

</script>

<script language=javascript for=gcgd_data2 event=onClick(row,colid)>
  if(row<1) return;  

	if(colid == "CHK") {
		if (gcDs2.NameValue(row,colid) == "T") gcDs2.NameValue(row,colid) = "F";
		else gcDs2.NameValue(row,colid) = "T";
	} 

</script>

<script language="javascript" for=gcgd_data2 event=OnExit(row,colid,olddata)>
	var org_val = gcDs2.OrgNameValue(row,"ARTC_CNT");
	var usr_val = gcDs2.NameValue(row,"ARTC_CNT");
	var org_cnt = gcDs2.NameValue(row,"ORG_CNT");
	var jaego_cnt = gcDs2.NameValue(row,"ORG_ARTC_CNT");

	if (org_val!=usr_val) {
		if (usr_val>org_cnt) {
			alert("���� �԰�� ��ǰ���� �̻��� �Է��Ͻ� �� �����ϴ�.");
			gcDs2.NameValue(row,"ARTC_CNT") = org_val;
			return;
		}
	} else {
		if (usr_val>org_cnt) {
			alert("���� �԰�� ��ǰ���� �̻��� �Է��Ͻ� �� �����ϴ�.");
			gcDs2.NameValue(row,"ARTC_CNT") = org_cnt;
			return;
		}
	}
</script>

<script language=JavaScript for=gcgd_data2 event=OnDblClick(row,colid)>
	if(row<1) return;
	if(colid ="ARTC_CNT"){
		ln_Popup_INWRHS(row); //�԰���� ���˾�
	}
</script>


<script language=javascript for=gcTr01 event=onSuccess()>
	alert("���������� ������ �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gcTr01 event=OnFail()>
	alert("Error Code : " + gcTr01.ErrorCode + "\n" + "Error Message : " + gcTr01.ErrorMsg + "\n");
</script>

<script language=javascript for=gcTr02 event=onSuccess()>
	alert("�������� "+ETD_DATE.TEXT+" ����Ÿ�� ���������� �������� �Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gcTr02 event=OnFail()>
	alert("Error Code : " + gcTr02.ErrorCode + "\n" + "Error Message : " + gcTr02.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "==== ����====" ; 
	LINE_PART.index = 0 ; 
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
			  <!-- 2008.10.22 EDI ���� �� ���������ۼ� ��� ����, ���������� �߰��� ����. -->
				<!-- <img src="../../common/img/btn/btn_edi.gif" style="cursor:hand" onclick="ls_EDI()"> -->
				<img src="../img/com_b_load.gif" style="cursor:hand" onclick="CallLoadList();"> 
				<img src="../img/btn/btn_edi_re.gif"  style="cursor:hand" onclick="ln_EDI_Receive()">
				<img src="../img/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
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
						<!--
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">����/����</td>
						<td class="tab12_left" style="width:90px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=IO_FLAG style='border:0;position:relative;left:8px;top:1px;height:150;width:70' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=CBData					value="^��ü,O^����,I^����">
								<param name=CBDataColumns		value="DIVCODE,DIVNAME">
								<param name=SearchColumn		value="DIVNAME">
								<param name=ListExprFormat	value="DIVNAME^0^70">
								<param name=BindColumn			value="DIVCODE">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						-->
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">��ü��</td>
						<td class="tab12_left" style="width:130px;"><input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:105;position:relative;left:8px;top:0px;ime-mode:active' ></td> 
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">�����</td>
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
						<td height=25 bgcolor=#efefef colspan=2><B>&nbsp;&nbsp;[��������] </B>
						<img id=imgAll src="../img/btn/btn_all.gif" style="position:relative;left:12px;top:2px;display:none;cursor:hand" onclick="__SelectAll();" alt="�ֹ������� ��ü �����մϴ�."><!-- &nbsp; -->
						<img id=imgAllCancle src="../img/btn/btn_all_cancel.gif" style="position:relative;left:-6px;top:2px;display:none;cursor:hand" onclick="__SelectCancle();"  alt="������ �ֹ������� ����մϴ�."></td>
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
								  	<C> Name=''	         		ID=CHK, width=20 EditStyle=CheckBox	Pointer=Hand HeadCheck=false	HeadBgColor=#eeeeee HeadCheckShow=true align=center bgcolor=@acolor, Edit=none</C>
									<C> Name='������ȣ'	  	ID=CAR_SEQ_NO  HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=center  </C> 
									<C> Name='����'				ID=CARGO_TYPE  HeadAlign=Center HeadBgColor=#eeeeee Width=100	 align=left </C>
									<C> Name='��������'	  	ID=CAR_NAME		 HeadAlign=Center HeadBgColor=#eeeeee Width=100	 align=left </C> 
									<C> Name='������ȣ'	 	ID=CAR_NO 		 HeadAlign=Center HeadBgColor=#eeeeee Width=90	 align=left </C> 
                  					<C> Name='����'	    	ID=PSN_KNAME	 HeadAlign=Center HeadBgColor=#eeeeee Width=60	 align=center </C>
									<C> Name='��ǥǰ��'		ID=CTN_STDRD	 HeadAlign=Center HeadBgColor=#eeeeee Width=100   align=left </C>
									<C> Name='������'	    	ID=LD_CARGONM	 HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  </C> 
									<C> Name='������'		  	ID=OFF_CARGONM HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  </C> 
									<C> Name='ȭ��'	  	 		ID=SHIPPNM     HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  </C> 
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
						<td height=25 bgcolor=#efefef><B>&nbsp;&nbsp;[������������] </B></td>
						<td bgcolor=#efefef align=right>
							<img src="../img/btn/btn_jaego.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadData()">
							<img src="../img/btn/b_save.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Save();">
							<!-- <img src="../img/btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Del();"> -->
							<img src="..//img/com_b_query.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadSrh('A');">
						</td>
						<td bgcolor=#efefef style="width:8px">&nbsp;</td>
					</tr>
					<tr>
						<td colspan=3>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2 style="width:100%;height:261px;border:0 solid #777777;border-top-width:1px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs2">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Editable"		VALUE="true">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true"> 
								<PARAM NAME="Format"			VALUE="  
									<F>	Name=''	          ID=CHK, width=20 EditStyle=CheckBox	Pointer=Hand HeadCheck=false	HeadBgColor=#eeeeee HeadCheckShow=true align=center edit=none </F>
									<F> Name='�ֹ���ȣ'   ID=ORDER_NO 	   HeadAlign=Center HeadBgColor=#eeeeee Width=90	align=left   edit=none bgcolor=@acolor</F>
									<C> Name='ǰ��'			  ID=ARTC_NM  		 HeadAlign=Center HeadBgColor=#eeeeee Width=110	align=left   edit=none bgcolor=@acolor</C>
									<C> Name='����'			  ID=ARTC_UNIT	 HeadAlign=Center HeadBgColor=#eeeeee Width=90	align=left   edit=none 
									editstyle=LookUp Data='gcDs_etc13:MINORCD:MINORNM' bgcolor=@acolor</C>
									<G> Name='����' HeadBgColor=#eeeeee
										<C> Name='�԰����'	ID=IN_ARTC_CNT	 HeadAlign=Center HeadBgColor=#eeeeee Width=75	align=right, edit=none  Dec=0, bgcolor=@acolor1</C>
										<C> Name='�������'	ID=ARTC_CNT			 HeadAlign=Center HeadBgColor=#eeeeee Width=75	align=right, edit=none  Dec=0, bgcolor=#DDF2FC</C>
										<C> Name='�ܿ�����'	ID=EXT_ARTC_CNT  HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none  Dec=0, bgcolor=@acolor Color=@acolor3</C>
									</G>
									<G> Name='��������' HeadBgColor=#eeeeee
										<C> Name='����'	    ID=PKG_LNGTH		 HeadAlign=Center HeadBgColor=#eeeeee Width=75	align=right, edit=none  Dec=0, bgcolor=@acolor1</C>
										<C> Name='��'	      ID=PKG_WIDTH     HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none  Dec=0, bgcolor=@acolor Color=@acolor3</C>
										<C> Name='����'	    ID=PKG_HEIGHT    HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none  Dec=0, bgcolor=@acolor Color=@acolor3</C>
									</G>
									<C> Name='���߷�(KG)'	ID=TOTAL_WEIGHT  HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right, edit=none dec=2 bgcolor=@acolor</C>
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


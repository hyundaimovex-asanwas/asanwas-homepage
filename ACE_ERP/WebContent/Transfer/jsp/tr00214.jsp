<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	����ƻ�  �ֹ����º���
+ ���α׷� ID	: TR00214.HTML
+ �� �� �� ��	: �ֹ����º���
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
</OBJECT> 

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
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

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT> 

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	
		gcDs_etc0.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //����
		gcDs_etc0.Reset() ; 

		gcDs_etc1.DataId =   "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; //Project
		gcDs_etc1.Reset() ; 

		gcDs_etc2.DataId =   "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //Project
		gcDs_etc2.Reset() ;

		gcDs_etc3.DataId =   "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //Project
		gcDs_etc3.Reset() ;

		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc4.Reset();

		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //������ 
		gcDs_etc5.Reset(); 

		if(location.search){
		
			var str0=location.search.split("&")[0];
			var str1=location.search.split("&")[1];
			var str2=location.search.split("&")[2];
			var str3=location.search.split("&")[3];
			var str4=location.search.split("&")[4];
			var str5=location.search.split("&")[5];
			var str6=location.search.split("&")[6];
		}

		if (str1=="" || str1==undefined){
		
			TO_DATE.Text = gs_date ;
			FROM_DATE.Text =gs_date ; 
			
		} else {
		
			TO_DATE.Text		= str1;
			FROM_DATE.Text	= str2;
			
			PROJECT.index		= PROJECT.IndexOfColumn("MINORCD", str3);
			
			QMANAGER.Value	= str4;
			ORDER_NO.Text		= str5;
			
			if (PROJECT.IndexOfColumn("MINORCD", str6)<0) ORDER_STS.index = 0;
			
			else ORDER_STS.index = PROJECT.IndexOfColumn("MINORCD", str6);

			ln_Query();
		}

		curr_date.Text = gs_date ; 
		
		MANAGER.value = gusrid ; 
		MANAGER.disabled = "true" ; 
		
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
	
		var ls_from_date = FROM_DATE.Text ; 
		var ls_to_date = TO_DATE.Text ; 
		var ls_project = PROJECT.BindColVal ; 
		var ls_ordno = ORDER_NO.Text ;
		var ls_ordsts = ORDER_STS.BindColVal ;

		if(ORDER_STS.BindColVal =='0001'){
			ORDER_STS1.index=ORDER_STS1.IndexOfColumn("MINORCD", "0002");
			ORDER_STS1.Enable=false;
			ORDER_STS12.value = "����";
		} else {
			ORDER_STS1.index = 0 ; 
			ORDER_STS1.Enable=false;
		}

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderSts?NOH=Y&gstr0=I&gstr1="+ls_from_date+"&gstr2="+ls_to_date+"&gstr3="+ls_project+"&gstr4="+ls_ordno+"&gstr5=" + ls_ordsts ; 
		gcDs1.Reset();
	} 

	/******************************************************************************
		Description : 
	******************************************************************************/ 
	function ln_Save(){
		if (confirm("�����Ͻ� �ֹ������� ���¸� �����Ͻðڽ��ϱ� ?")){
			gcTr01.KeyValue = "trOrderRegMst(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderSts";
			gcTr01.post();
		}
	}

	/******************************************************************************
		Description :	����
	******************************************************************************/ 
	function ln_Delete(){

    var strSendGb="";     //���۱���
    var strChkGb="";      //üũ�ڽ� ����

		gcDs1.ClearAllMark();
		if (gcDs1.countrow<1) return;

		if (gcDs1.namevalue(gcDs1.rowposition,"ORDER_STS")!="0001"){
      for(i=1;i<=gcDs1.CountRow;i++){
				if(gcDs1.namevalue(i,"CHK")=="T"){
           strChkGb="Y";
					 if(gcDs1.namevalue(i,"EDI_STS")=="S"||gcDs1.namevalue(i,"EDI_STS")=="A"||gcDs1.namevalue(i,"EDI_STS")=="Y"){
							alert("EDI ������ �Ǿ����ϴ�. ���� �� �� �����ϴ�.");
              return false;
           }else{
							strSendGb="Y";
           }
        }
      } 

      if(strChkGb!="Y"){
				alert("������ �����͸� �����Ͻʽÿ�.");
        return false;
      }

      if(strSendGb=="Y"){
				alert("������ �ֹ������̿��� �ѹ��� Ȯ���� �ֽʽÿ�.");
      }
		}

		
		if (confirm("�����Ͻ� �ֹ������� �����Ͻðڽ��ϱ� ?  ")){
			for(i=1;i<=gcDs1.CountRow;i++) {
				if(gcDs1.namevalue(i,"CHK")=="T") {
					gcDs1.RowMark(i)=1;		
				}
			}	
	
			gcDs1.DeleteMarked();
			gcTr01.KeyValue = "trOrderCar(I:DATA=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_t1";
			gcTr01.post();
		}
	}



	/******************************************************************************
		Description : 
	******************************************************************************/ 
	function ln_Save(){
		//2007.08.22 ������
		var ins_sts="";
		for(i=1;i<=gcDs1.countrow;i++){
			if(gcDs1.NameValue(i,"CHK")=="T"){
				if(gcDs1.NameValue(i,"ORDER_STS")=="0002"){
					alert("�̹� ������ ���Դϴ�. ") ; 			
					gcDs1.NameValue(i,"CHK" )="F" ;  
					gcDs1.RowMark(i) = 1;
					return;
				}else if(gcDs1.NameValue(i,"ORDER_STS")=="0001"&&fn_trim(gcDs1.NameValue(i,"ING_STS"))=="X"){
					alert("�̹� ��ҵ� ���Դϴ�. �� ������ �� �����ϴ�.") ; 			
					gcDs1.NameValue(i,"CHK" )="F" ;  
					gcDs1.RowMark(i) = 1;
					return;
				}
			}
		}
		
		//�ű� ����
		if (confirm("�����Ͻ� �ֹ������� ���¸� �����Ͻðڽ��ϱ� ?")){
			gcTr01.KeyValue = "trOrderRegMst(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderSts";
			//prompt("",gcDs1.text);
			gcTr01.post();
		}

		//EDI ������ ��� �� �������� ���
	}

	/******************************************************************************
	Description : �ֹ� ��� (2008.11.10)
******************************************************************************/ 
function ln_Cancel(){
  var strChkGb="";
	
	if (gcDs1.namevalue(gcDs1.rowposition,"ORDER_STS")!="0001"){
		for(i=1;i<=gcDs1.CountRow;i++){
			if(gcDs1.namevalue(i,"CHK")=="T"){
				strChkGb="Y";
				if(gcDs1.namevalue(i,"EDI_STS")!="S"&&gcDs1.namevalue(i,"EDI_STS")!="A"&&gcDs1.namevalue(i,"EDI_STS")!="Y"){
					alert("EDI ������ ���� �ʾҽ��ϴ�. ����� �� �����ϴ�.");
					return false;
				}
			}
		} 

		if(strChkGb!="Y"){
			alert("�ֹ������ �����͸� �����Ͻʽÿ�.");
			return false;
    }
	}else{
		alert("EDI ������ ������� ��Ҹ� ���� ���� �����Ͻʽÿ�.");
		return false;
	}

	if (confirm("�����Ͻ� �ֹ������� ���¸� ����Ͻðڽ��ϱ� ?")){
		gcTr01.KeyValue = "trOrderCancel(I:USER=gcDs1)";
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderCancel";

		gcTr01.post();
	}
}

</SCRIPT> 

<script language=JavaScript for=gcTr01 event=OnSuccess()>
	gcDs1.Reset() ;
</script>

<script language=JavaScript for=gcDs_etc2 event=OnLoadCompleted(rowcnt)>
	gcDs_etc2.InsertRow(1) ; 
	gcDs_etc2.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc2.NameValue(1,"MINORNM" )  = "===����===" ; 
	ORDER_STS.Index = 0 ;
</script>

<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	gcDs_etc3.InsertRow(1) ; 
	gcDs_etc3.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc3.NameValue(1,"MINORNM" )  = "===����===" ; 
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "===����===" ; 
	PROJECT.index = 0 ; 
</script>

<script language="javascript"  for=gcGR1 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(bCheck == "1")	{
		for(i=1;i<=gcDs1.CountRow;i++){ 
			if(gcDs1.NameValue(i,"ORDER_STS") != "0002") gcDs1.NameValue(i,"CHK") = "T";
		} 
	} else {
		for(i=1;i<=gcDs1.CountRow;i++){ 
			if(gcDs1.NameValue(i,"ORDER_STS") != "0002") gcDs1.NameValue(i,"CHK") = gcDs1.OrgNameValue(i,"CHK");
		} 
	}
</script>

<script language=JavaScript for=gcGR1 event=OnClick(row,colid)>

  if(colid!="CHK") return;
  
  if(gcDs1.CountRow<1) return;
	

	if(gcDs1.NameValue(row,"ORDER_STS") == "0002"&&gcDs1.NameValue(row,"INS_STS") == ""){ 
		alert("�̹� ������ ���Դϴ�. ") ; 
		gcDs1.NameValue(row,"CHK" )   ="F" ;  
		return false ;
	}

	if(gcDs1.NameValue(row,"ORDER_STS") == "0004"){ 
		alert("�߰� ������ ���� �߰���ǰ ó���� ���ż� ó���Ͻñ� �ٶ��ϴ�. ") ; 
		gcDs1.NameValue(row,"CHK" )   ="F" ;  
		return false ;
	}

	if(colid == "CHK") {
		var ls_chk = gcDs1.NameValue(row,"CHK");
		if (strim(ls_chk)=="" || strim(ls_chk)=="F") gcDs1.NameValue(row,"CHK") = "T";
		else gcDs1.NameValue(row,"CHK") = gcDs1.OrgNameValue(row,"CHK");

		//ORDER_NO �� ������ ���� ��� üũ��.
		for(i =1 ; i<=gcDs1.CountRow ; i++ ) {
			if(gcDs1.NameValue(row,"ORDER_NO") == gcDs1.NameValue(i,"ORDER_NO" )){
				gcDs1.NameValue(i,"CHK" ) = gcDs1.NameValue(row,"CHK") ; 
			} 
		}
	} 

</script>

<script language=JavaScript for=gcGR1 event=OnDblClick(row,colid)>

		if (row<1) return;
	
		if (colid=="CHK") return;

		var result="";
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

	    arrParam[0]="update1";
	    arrParam[1]=gcDs1.namevalue(row,"ORDER_NO");
	    arrParam[2]="A";	  

		strURL = "<%=dirPath%>/Transfer/jsp/tr00202.jsp?gstr1=update&gstr2="+gcDs1.NameValue(row,"ORDER_NO")+"&A" ; 
		
		strPos = "dialogWidth:900px;dialogHeight:700px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
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
			<td width="876" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="<%=dirPath%>/Common/img/btn/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()">
				<img src="<%=dirPath%>/Common/img/btn/b_save.gif" style="cursor:hand" onclick="ln_Save()"> 
				<img src="<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
				<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11" style="height:30px;" bgcolor="#eeeeee" width=75>&nbsp;��������</td>
						<td class="tab21" style="width:250px;">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:65px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="cursor:hand;position:relative;left:0px;top:1px;" onclick="__GetCallCalendar('FROM_DATE', 'Text');">&nbsp;&nbsp;<font style="position:relative;top:-2px;">~</font>&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:65px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="cursor:hand;position:relative;left:0px;top:1px;" onclick="__GetCallCalendar('TO_DATE', 'Text');">  
						</td>
						<td class="tab11" bgcolor="#eeeeee" width=75>&nbsp;Project</td>
						<td class="tab21" >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PROJECT  style='border:0;position:relative;left:0px;top:2px;width:160px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab11" bgcolor="#eeeeee"  width=75>&nbsp;Ȯ����</td>
						<td class="tab22"  >&nbsp;<input id="QMANAGER" name="QMANAGER" type="text" class="txt11" style='width:130;position:relative;left:0px;top:0px;ime-mode:active'></td>
					</tr>
					<tr>
						<td class="tab12" style="height:30px;" bgcolor="#eeeeee"  width=75>&nbsp;�ֹ���ȣ</td>
						<td class="tab12" style="text-align:left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:6px; width:70px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab12" bgcolor="#eeeeee"  width=75>&nbsp;�������</td>
						<td class="tab12" style="text-align:left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_STS  style='border:0;position:relative;left:0px;top:2px;width:120px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc2>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
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
		<tr><td height=5 colspan=2></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td bgcolor="#eeeeee" align=right class=tab11 colspan=2 style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							Ȯ����&nbsp;&nbsp;:<input id="MANAGER" name="MANAGER" type="text" class="txt11" style='width:130;position:relative;left:0px;top:-1px'>&nbsp;&nbsp; Ȯ���Ͻ�&nbsp;: &nbsp; 
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=curr_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:130px;height:17px;font-family:����; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> &nbsp;&nbsp;&nbsp;������ ����&nbsp;&nbsp;:
							<input id="ORDER_STS12" name="ORDER_STS12" type="text" class="txt11" style='width:0;position:relative;left:0px;top:-1px' style=dispaly:none>��� -- > ����							
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_STS1  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=0 height=100  >
								<param name=ComboDataID			value=gcDs_etc3>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=Visible					value=false>
								<param name=ListExprFormat	value="MINORCD^2^32,MINORNM^1^100">								
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>&nbsp;&nbsp; 
							
							</td>
					</tr> 
					<tr>
						<td colspan=2 >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:874;height:402px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME=ColSelect			VALUE="false"> 
								<PARAM NAME="IndWidth"		VALUE="17">
								<PARAM NAME="AllShowEdit" VALUE="true">  
								<param name=ColSizing  value="true">
								<param name="TitleHeight"	VALUE=30>
								<PARAM NAME="Format"			VALUE="  
									<F>	Name=''	ID=CHK, width=20 EditStyle=CheckBox	Pointer=Hand HeadCheck=false	HeadBgColor=#eeeeee HeadCheckShow=true align=center bgcolor=@acolor, Edit=none  bgcolor={IF(ING_STS='C','Gold')} </F>
									<C> Name='Project'				ID=LINE_PART	HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' edit=none  suppress=1, show=false</C> 
									<C> Name='����'					ID=ORDER_STS	HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center EditStyle=Lookup Data='gcDs_etc0:MINORCD:MINORNM' edit=none, suppress=1 bgcolor={IF(ING_STS='C','Gold')} </C> 
									<C> Name='��������'			ID=EDT_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=center  MASK='XXXX-XX-XX' edit=none, suppress=2  bgcolor={IF(ING_STS='C','Gold')} </C>
									<C> Name='�ֹ���ȣ'			ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center edit=none, suppress=6  bgcolor={IF(ING_STS='C','Gold')} </C>  
									<C> Name='ȭ��'					ID=SHIPPER			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, suppress=3 edit=none  bgcolor={IF(ING_STS='C','Gold')} </C> 
									<C> Name='������'				ID=LD_CARGO		HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=center, suppress=4 edit=none,	 editstyle=LookUp Data='gcDs_etc4:MINORCD:MINORNM'  bgcolor={IF(ING_STS='C','Gold')}</C> 
									<C> Name='������'				ID=OFF_CARGO	HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=center, suppress=5 edit=none,	 editstyle=LookUp Data='gcDs_etc5:MINORCD:MINORNM'  bgcolor={IF(ING_STS='C','Gold')}</C> 
									<C> Name='������ȣ'			ID=CARINFO			HeadAlign=Center HeadBgColor=#eeeeee Width=190  align=left, edit=none  bgcolor={IF(ING_STS='C','Gold')}</C> 
									<C> Name='ǰ��'					ID=ARTC_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, edit=none  bgcolor={IF(ING_STS='C','Gold')}</C>   
									<C> Name='����'					ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=right edit=none   bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='����(CBM)'		ID=PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=60   align=right edit=none   bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='�߷�(KG)'			ID=PKG_WGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=right edit=none   bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='���Ը���/����' 	ID=OBJ_REMK		HeadAlign=Center HeadBgColor=#eeeeee Width=120 align=left edit=none, suppress=3  bgcolor={IF(ING_STS='C','Gold')} </C>
									<C> Name='���ۻ���' 			ID=EDI_STS  		HeadAlign=Center HeadBgColor=#eeeeee Width=55   align=left edit=none  EditStyle=Combo Data='1:������,S:������,Y:���ۿϷ�' bgcolor={IF(ING_STS='C','Gold')}</C>   
									<C> Name='��������' 			ID=ING_STS  		HeadAlign=Center HeadBgColor=#eeeeee Width=55   align=left edit=none  EditStyle=Combo Data='U:����,C:���,I:�ű�'  bgcolor={IF(ING_STS='C','Gold')}</C>          
									<C> Name='��������'			ID=CRE_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=80 align=center  edit=none bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='��ǰ����'			ID=LD_DATE			HeadAlign=Center HeadBgColor=#eeeeee Width=80 align=center MASK='XXXX-XX-XX' edit=none, show=false  </C>
									<C> Name='�����'				ID=PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=90 align=right edit=none, show=false  </C> 
									<C> Name='�ֹ���ȣ'			ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center edit=none, show=false  </C>  
									<C> Name='SEQ'					ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=right show=false edit=none  </C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr style="display:none">
						<td width=29 class="tab11" bgcolor="#eeeeee">
						</td>
						<td class="tab11">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:860;height:102px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_educ">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='��'				ID=GRAYY		HeadAlign=Center HeadBgColor=#eeeeee Width=30 Mask='XXXX' align=center</C>  
									<C> Name='����'			ID=PERFECT	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C> 
									<C> Name='Ȯ����'		ID=GRAYY		HeadAlign=Center HeadBgColor=#eeeeee Width=100 Mask='XXXX' align=center</C> 
									<C> Name='Ȯ���Ͻ�'	ID=EDCCD  		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, editstyle=LookUp data='gcds_hreduc:minorcd:minornm'</C>  
									<C> Name='�Է���'		ID=PGCCD		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left, editstyle=LookUp data='gcds_preduc:minorcd:minornm'</C> 
									<C> Name='�Է��Ͻ�'	ID=EDCCD		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, editstyle=LookUp data='gcds_hreduc:minorcd:minornm'</C>  
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

<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ڵ���ǥ - POS ������ ���ε� 
+ ���α׷� ID	:  xat1004.jsp
+ �� �� �� ��	:  POS ������(����) ���ε�   
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2018.04.23
+ �� �� �� ��	:  
+ ���콺 ����    :  5.2 
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� ��     :	         
+ ��   ��  ��      : 
+ �� �� �� ��     : 
+ �� �� �� ��     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>POS ������ ���ε�</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�

var gs_upload_gb="";  //���� �׸��� ���ε�� �����ϱ� 


<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	
	gcem_saledt_fr.text = gs_date;
	gcem_saledt_to.text = gs_date;
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){
	gcds_grid_info.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_s1?v_str1=&v_str2=&v_str3=&v_str4=&v_str5=T";                           
	gcds_grid_info.Reset();
}

<%
/******************************************************************************
	Description : ���� ���� ��ư �۾��� ����Data ==> Grid�� ���ε� ��               
******************************************************************************/
%>
function ln_Excel_Apply(){
		
  	var s_temp = "";
  	
  	gs_upload_gb="1";

    //excel_upload ( grid�� ���� )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head �����
    //���ϰ��
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL")  = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_xat1004_t1(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_xat1004_t1?";
	gctr_data_excel.post();
	
}

<%
/******************************************************************************
	Description : ����  �������� ����.. �н� 
******************************************************************************/
%>

/*
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_excel_grid.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue = "Account.a400020_t2(I:USER=gcds_excel_grid)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_excel_grid.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}	
*/

<%
/******************************************************************************
	Description : ����� üũ
******************************************************************************/
%>
/*
function ln_Chk_Save() {
	
    //�ʼ��׸� üũ 
	for(i=1;i<=gcds_excel_grid.countrow;i++){
		if(gcds_excel_grid.namevalue(i,"ACCTNO") == ""){ 			
			alert("���¹�ȣ�� �Է��ϼ���.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"ACCTCD") == ""){
			alert("�����ڵ带 Ȯ���ϼ���.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"DEALDT") == ""){ 				
			alert("�ŷ��Ͻø� Ȯ���ϼ���.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"CURUNIT") == ""){ 				
			alert("��ȭ�� Ȯ���ϼ���.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"CURUNIT") != "WON"){ 				
			if(gcds_excel_grid.namevalue(i,"EXRATE")==0){
				alert("ȯ���� �Է��Ͻʽÿ�.");
				return false;
			}
		}
	} 
	
	return true;
}
*/

<%
/******************************************************************************************
	Description : ���ε� ������ ������.
*****************************************************************************************/
%>
function ln_Create(){
	
	// ���ε� �������� �ߺ� üũ�ϱ� 
	
	
	if(gcds_excel_grid.countrow>0) {	
		if (confirm("POS ���� ������  ���ε� �Ͻðڽ��ϱ�?")){	
			
			//gctr_data.KeyValue = "Account.a400020_t1(I:USER=gcds_excel_grid)";
			
			gctr_data.KeyValue = "Account.xat1004_t1(I:USER=gcds_excel_grid)";
			
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			
			//prompt('gcds_excel_grid',gcds_excel_grid.text);
			
			gctr_data.post();
		}
	}else{
		alert("�����Ͻ� ������ �����ϴ�.");
	}
}


<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(e){
	//data Recode 
    gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1004_s1?v_str1="+gcem_dfscost.text
    		                                                                  +"&v_str2="+gcem_saledt_fr.text
    		                                                                  +"&v_str3="+gcem_saledt_to.text;
    		                                                                  	
	gcds_excel_grid.Reset();
}



<%
/******************************************************************************************
	Description : ����
*****************************************************************************************/
%>
function ln_Delete(){

}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/





<%
/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
%>
function ln_Excel(){

	gcgd_disp01.GridToExcel("POS ������","",2);
}



<%
/******************************************************************************
Description : ��������
******************************************************************************/
%>
/*
function ln_Popup_Dfsinfo(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//strURL = "./acctinfo_popup.jsp";

    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_dfscd.text = arrResult[0];   // �����ڵ� 
		gcem_dfsnm.text = arrResult[1];  // �����
	}else{
		gcem_dfscd.text = "";
		gcem_dfsnm.text = "";
	}
}
*/

<%//���� ã��   %>
function ln_Popup_DfsCost(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0] = "001"; //��������
	
	strURL = "./xat_dfscost_popup.jsp";
	strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
	    gcem_dfscost.text    = arrParam[0];
	}else{
	    gcem_dfscost.text    = "";
	}
}



<%
/******************************************************************************
Description : ���ε������ �׸��� ������ ���� 
******************************************************************************/
%>
function fn_user_id(){
	
	for(var j=1;j<=gcds_excel_grid.countrow;j++){
		
		//�۾���  id ����		
		gcds_excel_grid.namevalue(j,"CREATE_ID") =gs_userid ;     
		
	}
	gs_upload_gb="";
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">


<!--���� -->
<object  id=gcds_excel classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�������ε� �� �׸��� DATA -->
<object  id=gcds_excel_grid classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�׸��� ���� ���� -->
<object  igcds_grid_infonfo classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--�׸��� Data�� Table�� insert Tail -->
<object  id=gcds_tail_b classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="gcds_head_a" event="onloadCompleted(row,colid)">
	//alert("gcds_head_a:row:"+row);
</script>

<script language="javascript" for="gcds_tail_b" event="onloadCompleted(row,colid)">
	//alert("gcds_tail_b:row:"+row);
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	//alert("gcds_excel_grid:row:"+row);
	if(gs_upload_gb=="1"){
		fn_user_id();
	}
	
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>

	if(row>0){ 
		if(colid=="EXRATE"){
			if(gcds_excel_grid.namevalue(row,"CURUNIT")!="WON"){
				gcgd_disp01.ColumnProp("EXRATE","Edit")="";
			}else{
				gcgd_disp01.ColumnProp("EXRATE","Edit")="none";
			}
		}
	}

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("������ ������ ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("������ ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	//ln_Upload_Grid();
	alert("���� ���ε� �غ� �Ϸ��Ͽ����ϴ�. [����]��ư�� �����Ͽ� ERP�� ���밡���մϴ�.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<!--<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">-->
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="1000px"> 
					<td width="100px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>��������</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
						<input type="text" name="file_path" value="" style="width:630px;position:relative;top:-2px" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcip_file classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE	style="width:70;height:20;position:relative;top:4px;fontSize=8"  >
						<param name = "Text"		value="ã�ƺ���">
						</OBJECT>&nbsp;
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:2px"  onClick="ln_Excel_Apply()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_create.gif"    style="cursor:hand;position:relative;top:2px"  onClick="ln_Create()">
						</comment><script>__ws__(__NSID__);</script>  
						</nobr>
					</td> 
				</tr>
			</table>
		</td>
	</tr>
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:270px">
						<object id=gcem_dfscost classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:200px">
							<param name=Text			value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=GeneralEdit     value="true">
							<param name=Enable          value=false>
							<param name=PromptChar	    value="_">
						</object>
					    </comment><script>__ws__(__NSID__);</script></nobr>&nbsp;
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_DfsCost()">
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:500px">
						<comment id="__NSID__">
							<object  id=gcem_saledt_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_saledt_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							~
							
							<object  id=gcem_saledt_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_saledt_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							</nobr>
					</td>
										
				
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:597px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<FG> Name ='��������'     	            HeadAlign=Center HeadBgColor=#B9D4DC   
								<FC> Name='�ڵ�'     	ID=DFSCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	    align=center	SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='�����'     	ID=DFSNM        HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=left  	SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='��������'	    ID=SALEDT       HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  edit=none MASK ='XXXX/XX/XX'</FC> 
								<FC> Name='����'     	ID=POSNO        HeadAlign=Center HeadBgColor=#B9D4DC Width=30   	align=center	SumBgColor='#C3D0DB'  edit=none SumText='�Ǽ�'</FC>
								<FC> Name='������'	    ID=RECNO  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none SumText=@count</FC>
								</FG>
							    <C> Name='����1'	        ID=GUBUN  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none</C>	   
								<C> Name='����2'	        ID=GUBUN2  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40   	align=center  	SumBgColor='#C3D0DB'  edit=none</C>
								<G> Name ='�ֹ��ð�'                      HeadAlign=Center HeadBgColor=#B9D4DC   
								<C> Name='����'	        ID=ORDTM  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='����'	        ID=APPTM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center 	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								<G> Name ='��ǰ����'                      HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��ǰ�ڵ�'       ID=GOODCD	    HeadAlign=Center HeadBgColor=#B9D4DC Width=50  	    align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='���ڵ�'	        ID=BARCD        HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='��ǰ��'	        ID=GOODNM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
				                </G>
				                
				                <G> Name ='�Ǹ�����'                      HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='����'	    	ID=GOODCNT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���԰�'	        ID=BUYAMT  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�Ѹ����'       ID=TSALAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���ξ�'        ID=DISCAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���α���'      ID=DISGB  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80   	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='�Ǹ����'      ID=SALAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='����'         ID=PRIAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�ΰ���'        ID=VATAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='������'        ID=ADJAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�����հ�'      ID=APPSUM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='��ȭ�հ�'      ID=WONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�ſ�ī��'      ID=CARDAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���ݿ�ȭ'      ID=CASHAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='����'         ID=CNYAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='���ȿ�ȭ'      ID=CWONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�޷�'         ID=USDAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='�޷���ȭ'      ID=UWONAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='����Ʈ'        ID=PNTAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@SUM</C>
								<C> Name='ī���ڵ�'	    ID=CARDCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center  	SumBgColor='#C3D0DB'  edit=none	</C>
								<C> Name='ī���'	        ID=CARDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
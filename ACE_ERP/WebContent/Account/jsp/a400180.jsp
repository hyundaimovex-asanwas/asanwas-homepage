<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ΰ����� - �ְ�(���)�� ���缱 ����
+ ���α׷� ID	: a400180.jsp
+ �� �� �� ��	: �ְ�(���)�� ���缱 ����
+ �� �� �� ��	: 2017.05.16 jys
+ ���콺 ����    : 5.2
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: a400110_s1, a400110_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
    ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
	ds_gc_aptype.Reset();	// �������� AP005 - �������� �����ڵ� �о����
	
	gcra_input_gb_1.codevalue="1";
	
	ln_Query("S");
}
<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query(strSignet_id){		
	
	if(strSignet_id=="S"){
		strSignet_id="9999";
	}else{
		strSignet_id=gcem_signet_id_0.text;
	}
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400180_s1?v_str1="+strSignet_id;
	gcds_data.Reset();
}
<%
/******************************************************************************
	Description : �߰�
******************************************************************************/
%>
function ln_Add(){
    
    var rowcnt = gcds_data.countrow;
		
	if(gcra_input_gb_1.codevalue=="1"){
		for(var i=rowcnt+1;i<=rowcnt+4;i++){
			gcds_data.addrow();
			gcds_data.namevalue(i,"SIGNET_ID")=gcem_signet_id_1.text;
			gcds_data.namevalue(i,"SIGNET_GB")=gclx_signet_gb_1.bindcolval;
			gcds_data.namevalue(i,"MGR_TEAMNM")=gcem_mgr_teamnm_1.text;
			gcds_data.namevalue(i,"SIGNET_HEAD_NO")=gcem_signet_head_no_1.text;
			gcds_data.namevalue(i,"SEQ")=rowcnt+5-i;
			gcds_data.namevalue(i,"AP_TYPE")=rowcnt+5-i;
			
			//�Էµ� �ΰ� id�� ������ ��������.....
		}
	}else if(gcra_input_gb_1.codevalue=="2"){
		gcds_data.addrow();	
		gcds_data.namevalue(gcds_data.rowposition,"SIGNET_ID")=gcem_signet_id_1.text;
		gcds_data.namevalue(gcds_data.rowposition,"SIGNET_GB")=gclx_signet_gb_1.bindcolval;
		gcds_data.namevalue(gcds_data.rowposition,"MGR_TEAMNM")=gcem_mgr_teamnm_1.text;
		gcds_data.namevalue(gcds_data.rowposition,"SIGNET_HEAD_NO")=gcem_signet_head_no_1.text;
		gcds_data.namevalue(gcds_data.rowposition,"SEQ")=0;
		gcds_data.namevalue(gcds_data.rowposition,"AP_TYPE")="";
	}
}

<%
/******************************************************************************
	Description : ���߰�
******************************************************************************/
%>
function ln_Row_Add(){
	gcds_data.addrow();	
	gcds_data.namevalue(gcds_data.rowposition,"SIGNET_ID")=gcem_signet_id_1.text;
	gcds_data.namevalue(gcds_data.rowposition,"SIGNET_GB")=gclx_signet_gb_1.bindcolval;
	gcds_data.namevalue(gcds_data.rowposition,"MGR_TEAMNM")=gcem_mgr_teamnm_1.text;
	gcds_data.namevalue(gcds_data.rowposition,"SIGNET_HEAD_NO")=gcem_signet_head_no_1.text;
	gcds_data.namevalue(gcds_data.rowposition,"SEQ")=0;
	gcds_data.namevalue(gcds_data.rowposition,"AP_TYPE")="";
}


<%
/******************************************************************************
	Description : �����
******************************************************************************/
%>
function ln_Row_Del(){
	var strSignet_id =gcds_data.namevalue(gcds_data.rowposition,"SIGNET_ID");
	var vcnt = 0;
	gcds_data.DeleteRow(gcds_data.rowposition);
	
	for(var i=1;i<=gcds_data.countrow;i++){
		if(strSignet_id == gcds_data.namevalue(i,"SIGNET_ID")){
			vcnt=vcnt+1;
		}	
	}
	
	for(var i=1;i<=gcds_data.countrow;i++){
		if(strSignet_id == gcds_data.namevalue(i,"SIGNET_ID")){
			gcds_data.namevalue(i,"SEQ")=vcnt; 
			vcnt=vcnt-1;
		}	
	}
	
}


<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400180_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
		//prompt('',gcds_data.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

<%
/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
%>
function ln_Chk_Save() {
		
    //�ʼ��׸� üũ 
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){
			
			if(gcds_data.namevalue(i,"SIGNET_ID") == ""){ 			
				alert("�ΰ�ID�� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"SEQ") == ""){
				alert("SEQ�� �Է��ϼ���");
				return false;
			}
			
			if(gcds_data.namevalue(i,"AP_TYPE") == ""){ 				
				alert("����Ÿ���� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"EMPNO") == ""){ 				
				alert("�����ڸ� �Է��ϼ���.");
				return false;
			}
		}
	} 
	
	return true;
}

<%
/******************************************************************************
	Description : ���
******************************************************************************/
%>
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}

<%	
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Delete(){
		
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data.KeyValue = "Account.a400180_t1(I:USER=gcds_data)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400180_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
		//prompt('',gcds_data.text);
		gctr_data.post();
		return ln_Query();
	}
	else gcds_data.undo(gcds_data.rowposition);
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

<%
/******************************************************************************
Description : �ΰ�ID 
******************************************************************************/
%>
function ln_Popup_Signet_Id_0(){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./signet_id_popup.jsp";
	strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_signet_id_0.text  = arrParam[0];
		gclx_signet_gb_0.bindcolval  = arrParam[1];
		gcem_signet_head_no_0.text = arrParam[2];
		gcem_mgr_teamnm_0.text = arrParam[4];
		
	}else{
		gcem_signet_id_0.text="";
		gclx_signet_gb_0.text="";
		gcem_signet_head_no_0.text="";
		gcem_mgr_teamnm_0.text="";
	}
}

<%
/******************************************************************************
Description : �ΰ�ID 
******************************************************************************/
%>
function ln_Popup_Signet_Id_1(){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./signet_id_popup.jsp";
	strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_signet_id_1.text  = arrParam[0];
		gclx_signet_gb_1.bindcolval  = arrParam[1];
		gcem_signet_head_no_1.text = arrParam[2];
		gcem_mgr_teamnm_1.text = arrParam[4];
		
	}else{
		gcem_signet_id_1.text="";
		gclx_signet_gb_1.text="";
		gcem_signet_head_no_1.text="";
		gcem_mgr_teamnm_1.text="";
	}
}


<%
/******************************************************************************
Description : �ΰ�ID 
******************************************************************************/
%>
function ln_Popup_Signet_Id(){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./signet_id_popup.jsp";
	strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_signet_id.text  = arrParam[0];
		gclx_signet_gb.bindcolval  = arrParam[1];
		gcem_signet_head_no.text = arrParam[2];
		gcem_mgr_teamnm.text = arrParam[4];
		
	}else{
		gcem_signet_id.text="";
		gclx_signet_gb.text="";
		gcem_signet_head_no.text="";
		gcem_mgr_teamnm.text="";
	}
}


<%
/******************************************************************************
Description : �������˾� 
******************************************************************************/
%>
function ln_Popup_Empno(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_empno.text   = arrParam[1];
		gcem_empnm.text   = arrParam[0];
	}else{
		gcem_empno.text="";
		gcem_empnm.text="";
	}
}


<%
/******************************************************************************
Description : �̷³��� ������ �� ��� ���� 
******************************************************************************/
%>
function SetDataHeader() {
	 var s_temp = "SIGNET_ID:STRING,SEQ:DECIAML,AP_TYPE:STRING,EMPNO:STRING,ORG_SEQ:STRING,"
		        + "WRID:STRING,WRDT:STRING,UPID:STRING,UPDT:STRING";
	 gcds_data.SetDataHeader(s_temp);
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=ds_gc_aptype classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a400110_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Cancel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
	 	<td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" >�˻�</td>
			<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">�ΰ�ID</td>
			<td width="800px"  class="tab18"  align=left colspan=2  >
		    	<comment id="__NSID__">
				<object id=gcem_signet_id_0 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
					<param name=Text		  value="">
					<param name=Alignment	  value=0>
					<param name=GeneralEdit   value="true">
					<param name=Border		  value=true>
					<param name=Enable		  value="false">
				</object>
			    </comment><script>__ws__(__NSID__);</script></nobr>
		    	
		    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Signet_Id_0()">
		    	
		    	<comment id="__NSID__">
				<object  id=gclx_signet_gb_0 classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:2px;top:2px;font-size:12px;width:100px;">
					<param name=CBData			        value="1^�����ΰ�,2^����ΰ�">
					<param name=CBDataColumns	 		value="CODE,NAME">
					<param name=SearchColumn	     	value=NAME>
					<param name=Sort			        value=false>
					<param name=ListExprFormat       	value="NAME">								
					<param name=BindColumn		     	value="CODE">
					<param name=Enable                  value="false">
				</object>
				
				<object  id=gcem_mgr_teamnm_0  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:100px;height:20px;position:relative;left:5px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language	  value=1>
				</object>
				
				<object  id=gcem_signet_head_no_0  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:50px;height:20px;position:relative;left:5px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language	  value=1>
				</object></comment>
				
				<script>__ws__(__NSID__);</script>
			</td>
		</tr>
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" >�Է�</td>
			<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">�ΰ�ID</td>
			<td width="500px"  class="tab18"  align=left  >
		    	<comment id="__NSID__">
				<object id=gcem_signet_id_1 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
					<param name=Text		  value="">
					<param name=Alignment	  value=0>
					<param name=GeneralEdit   value="true">
					<param name=Border		  value=true>
					<param name=Enable		  value="false">
				</object>
			    </comment><script>__ws__(__NSID__);</script></nobr>
		    	
		    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Signet_Id_1()">
		    	
		    	<comment id="__NSID__">
				<object  id=gclx_signet_gb_1 classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:2px;top:2px;font-size:12px;width:100px;">
					<param name=CBData			        value="1^�����ΰ�,2^����ΰ�">
					<param name=CBDataColumns	 		value="CODE,NAME">
					<param name=SearchColumn	     	value=NAME>
					<param name=Sort			        value=false>
					<param name=ListExprFormat       	value="NAME">								
					<param name=BindColumn		     	value="CODE">
					<param name=Enable                  value="false">
				</object>
				
				<object  id=gcem_mgr_teamnm_1  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:100px;height:20px;position:relative;left:5px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language	  value=1>
				</object>
				
				<object  id=gcem_signet_head_no_1  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:50px;height:20px;position:relative;left:5px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language	  value=1>
				</object>
				
				<object id=gcra_input_gb_1 classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0	style="position:relative;left:3px;top:2px;width:150px;height:20px;">
					<param name=Cols	value="2">
					<param name=Format	value="1^�ű�,2^����">
				</object>
				
				</comment>
				
				<script>__ws__(__NSID__);</script>
			</td>
			
			<td width="300px"  class="tab18"  align="right" > &nbsp;
			     <!--
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"	style="cursor:hand" onclick="ln_Row_Add()" >
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"	style="cursor:hand" onclick="ln_Row_Del()" >
			  	-->
			</td>
			
		</tr>
		
		</table>
		</td>
	</tr>	
	
	<tr>
		<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
						<td ALIGN=LEFT VALIGN=TOP>
							<comment id="__NSID__"><object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_pyo style="WIDTH:650px;HEIGHT:425px;border:1 solid #777777;display:block;" viewastext>
	 						 <PARAM NAME="DataID"		VALUE="gcds_data">
							 <PARAM NAME="BorderStyle"  VALUE="0">
							 <PARAM NAME="Indwidth"		VALUE="0">
							 <PARAM NAME="Fillarea"		VALUE="true">
							 <PARAM NAME="ColSizing"	VALUE="true">
							 <param name="sortview"     value=left>
						     <PARAM NAME="Format"		VALUE="  
								<FG> Name='�ΰ�����'     HeadAlign=Center    HeadBgColor=#B9D4DC
								<FC>ID=SIGNET_ID       Name=�ΰ�ID,	   	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false  </FC>
								<FC>ID=SIGNET_GB       Name=����,    	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false  EditStyle=Combo,  Data='1:�����ΰ�,2:����ΰ�'</FC>
								<FC>ID=MGR_TEAMNM      Name=������,	   	width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = false  </FC>
								<FC>ID=SIGNET_HEAD_NO  Name=�ΰ���ȣ,	   	width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false  </FC>
								</FG>
								<C> ID=SEQ   	       Name=SEQ,	  	width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false  </C>
								<C> ID=AP_TYPE,	       Name=����Ÿ��,     width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false  EditStyle=Combo,  Data='1:���,2:����,3:Ȯ��,4:����'</C>
								<C> ID=EMPNO,		   Name=���, 	   	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = false  </C>
								<C> ID=EMPNM,		   Name=����,	   	width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = false  </C>
							">
						 	</object></comment><script>__ws__(__NSID__);</script> 
						</td>
				  	</tr>
				 </table>
			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:346px;height:425px;border:1 solid #708090;">
				
				    <tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ΰ�ID</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gcem_signet_id classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
									<param name=Text		  value="">
									<param name=Alignment	  value=0>
									<param name=GeneralEdit   value="true">
									<param name=Border		  value=true>
									<param name=Enable		  value="false">
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#C0C0C0">
								</object>
						    </comment><script>__ws__(__NSID__);</script>
						    <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Signet_Id()">
						</nobr>
						</td>
					</tr>
				
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__">
							<object  id=gclx_signet_gb classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:2px;top:2px;font-size:12px;width:100px;">
								<param name=CBData			        value="1^�����ΰ�,2^����ΰ�">
								<param name=CBDataColumns	 		value="CODE,NAME">
								<param name=SearchColumn	     	value=NAME>
								<param name=Sort			        value=false>
								<param name=ListExprFormat       	value="NAME">								
								<param name=BindColumn		     	value="CODE">
								<param name=Enable                  value="false">
							</object>
				
						    </comment><script>__ws__(__NSID__);</script>
						    </nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object id=gcem_mgr_teamnm   classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:100px">
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=IsComma       value=false>
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
								<param name=ReadOnly      value="true">
								<param name=ReadOnlyBackColor   value="#C0C0C0">
							</object>
						    </comment><script>__ws__(__NSID__);</script>
						    </nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ΰ���ȣ</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gcem_signet_head_no  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:3px;top:0px;width:50px;height:20px;" class="txtbox">
									<param name=Alignment	  value=0>
									<param name=Border	      value=true>
									<param name=IsComma       value=false>
									<param name=GeneralEdit   value="true">
									<param name=UpperFlag     value=1 >
									<param name=ReadOnly      value="true">
									<param name=ReadOnlyBackColor   value="#C0C0C0">
								</object>
							</comment><script>__ws__(__NSID__);</script>
							</nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>SEQ</nobr></td>
						<td  class="tab13" style="text-align:left"><nobr>
						    <comment id="__NSID__">
								<object id=gcem_seq  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative; left:3px;top:0px;width:50px;height:20px;" class="txtbox">
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=UpperFlag     value=1>
								<param name=ReadOnly      value="false">
								<param name=ReadOnlyBackColor   value="#C0C0C0">
								</object>
							</comment><script>__ws__(__NSID__);</script>
							</nobr>
						</td> 
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����Ÿ��</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object  id=gclx_ap_type  classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197   style="position:relative;left:3px;top:0px;font-size:12px;width:120px;">
										<param name=ComboDataID      value="ds_gc_aptype">
										<param name=CBDataColumns	 value="DETAIL,DETAIL_NM">
										<param name=SearchColumn	 value=DETAIL_NM>
										<param name=Sort			 value=false>
										<param name=ListExprFormat   value="DETAIL^0^30,DETAIL_NM^0^100">								
										<param name=BindColumn		 value="DETAIL">
								</object>
						    </comment><script>__ws__(__NSID__);</script>
							</nobr>
						</td>
					</tr>
				
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gcem_empno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:3px;left:3px;width:50px">
									<param name=Text		  value="">
									<param name=Alignment	  value=0>
									<param name=Border		  value=true>
									<param name=Format		  value="#######">
									<param name=PromptChar	  value="_">
									<param name=Enable		  value="false">
								</object>
							</comment><script>__ws__(__NSID__);</script></nobr>
						    <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:5px;cursor:hand"	 onclick="ln_Popup_Empno()">	
						    <comment id="__NSID__">
								<object  id=gcem_empnm   classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:100px;height:20px;position:relative;left:5px;top:3px" >		
									<param name=Text		  value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object>
							</comment><script>__ws__(__NSID__);</script>
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�Է���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:3px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�Է��Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:3px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_upid"    type="text"   class="txtbox"  style= "position:relative;left:3px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_updt"    type="text"   class="txtbox"  style= "position:relative;left:3px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td  class="tab12" align=center colspan=2  style= "height:120px" > </td>
					</tr>
			  </table>
		 </td>
		 </tr>
		</table>
	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
	</tr>	
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp2 classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=SIGNET_ID        Ctrl=gcem_signet_id         Param=text</C>
	<C>Col=SIGNET_GB        Ctrl=gclx_signet_gb         Param=bindcolval</C>
	<C>Col=MGR_TEAMNM       Ctrl=gcem_mgr_teamnm        Param=text</C>
	<C>Col=SIGNET_HEAD_NO   Ctrl=gcem_signet_head_no    Param=text</C>
	<C>Col=SEQ              Ctrl=gcem_seq               Param=text</C>
	<C>Col=AP_TYPE          Ctrl=gclx_ap_type           Param=bindcolval</C>
	<C>Col=EMPNO            Ctrl=gcem_empno             Param=text</C>
	<C>Col=EMPNM            Ctrl=gcem_empnm             Param=text</C>
	<C>Col=WRID             Ctrl=txt_wrid               Param=value</C>
	<C>Col=WRDT             Ctrl=txt_wrdt               Param=value</C>
	<C>Col=UPID             Ctrl=txt_upid               Param=value</C>
	<C>Col=UPDT             Ctrl=txt_updt               Param=value</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




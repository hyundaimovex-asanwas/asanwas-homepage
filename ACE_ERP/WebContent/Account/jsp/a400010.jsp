<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ���ݰ��� - ��������
+ ���α׷� ID	: a400010.jsp
+ �� �� �� ��	: ��������
+ �� �� �� ��	: 2016.10.17 jys
+ ���콺 ����    : 5.2
-----------------------------------------------------------------------------
+ �� �� �� ��	:  2016.11.25 JYS 
+ �� �� �� ��	:  �����ڵ� �߰�
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

    gcra_status.codevalue ="";	
    gcra_status2.codevalue="T"

	gcds_acctgb.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2250&v_str2=&v_str3=&v_str4=C";   
	gcds_acctgb.Reset();	
	
	gcds_rstremark.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2260&v_str2=&v_str3=&v_str4=C";   
	gcds_rstremark.Reset();	
	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400010_s1?v_str1="+gcem_acctcd2.text
			                                                            +"&v_str2="+gcem_acctno2.text
			                                                            +"&v_str3="+gcem_bankcd2.text
			                                                            +"&v_str4="+gcem_banknm2.text
			                                                            +"&v_str5="+gcra_status2.codevalue;
   //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();	
	gcra_status.CodeValue="T";	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400010_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
		
	//�����ڵ尡 ������ ��� ���¹�ȣ�� �����Ұ�..
	//���п� ���� ������ �ʼ��׸� �� �� ����.
	
    //�ʼ��׸� üũ 
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){
			
			/* �ű��϶��� ����....�����Ǹ� ����
			if(gcds_data.namevalue(i,"EMPID") == ""){ 			
				alert("������ �Է��ϼ���.");
				return false;
			}
			*/
			
			if(gcds_data.namevalue(i,"EMPNO") == ""){
				alert("�����ڻ���� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"EMPNMK") == ""){ 				
				alert("�����ڼ����� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"S_DATE") == ""){ 				
				alert("�������ڸ� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"E_DATE") == ""){ 				
				alert("�������ڸ� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"USEGB") == ""){ 				
				alert("��������� �Է��ϼ���.");
				return false;
			}
		}
	} 
	
	return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/
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
		gctr_pyo.KeyValue = "Account.a400010_t1(I:USER=gcds_data)";
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400010_t1";
		gctr_pyo.post();
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
Description : ���������˾�
******************************************************************************/
%>
function ln_Popup_Acctinfo(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./acctinfo_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_acctcd2.text = arrResult[0];  // �����ڵ� 
		gcem_acctno2.text = arrResult[1];  // ���¹�ȣ
	}else{
		gcem_acctcd2.text = "";
		gcem_acctno2.text = "";
	}
}

<%
/******************************************************************************
Description : ���������˾�
******************************************************************************/
%>
function ln_Popup_Bank2(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="2168";//����

	strURL =  "./commdtil_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_bankcd2.text =arrResult[0];
		gcem_banknm2.text =arrResult[1];
	}else{
		gcem_bankcd2.text ="";
		gcem_banknm2.text ="";
	}

	
}


<%
/******************************************************************************
Description : ���������˾�
******************************************************************************/
%>
function ln_Popup_Bank(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="2168";//����

	strURL =  "./commdtil_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_bankcd.text =arrResult[0];
		gcem_banknm.text =arrResult[1];
	}else{
		gcem_bankcd.text ="";
		gcem_banknm.text ="";
	}	
}

<%
/******************************************************************************
Description : ��������
******************************************************************************/
%>
function ln_Popup_Branch(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="0022";//��������
    
	strURL =  strURL = "./commdtil_popup2.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_brchcd.text =arrResult[0];
		gcem_brchnm.text =arrResult[1];
	}else{
		gcem_brchcd.text ="";
		gcem_brchnm.text ="";
	}
}


<%
/******************************************************************************
Description : ��
******************************************************************************/
%>
function ln_Popup_Team(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] ="0002";
	arrParam[1] = "";
	arrParam[2]="A";
	arrParam[3]="";
	arrParam[4]="02";

	//2007.10.08.ȸ������ �߰�(�μ� CHGYM ����)
	//var stractdat = gcem_actdat02.text;
	arrParam[5]="201610";
	
    strURL = "./hcdept_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    result = showModalDialog(strURL,arrParam,strPos);
    
    if (result != null) {
		arrResult = result.split(";");
		gcem_teamcd.text =arrResult[0];
		gcem_teamnm.text =arrResult[1];
	}else{
		gcem_teamcd.text ="";
		gcem_teamnm.text ="";
	}
}

<%
/******************************************************************************
Description : ����
******************************************************************************/
%>
function ln_Popup_Cost(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] ="0030";
	arrParam[1] = "";
	arrParam[2]="";
	arrParam[3]="";
	arrParam[4]="02";

	//2007.10.08.ȸ������ �߰�(�μ� CHGYM ����)
	//var stractdat = gcem_actdat02.text;
	arrParam[5]="201610";
	
    strURL = "./commdtil_cost_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    result = showModalDialog(strURL,arrParam,strPos);
    
    if (result != null) {
		arrResult = result.split(";");
		gcem_costcd.text =arrResult[0];
		gcem_costnm.text =arrResult[1];
	}else{
		gcem_teamcd.text ="";
		gcem_teamnm.text ="";
	}
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- �α��� ��� üũ  -->
<object  id=gcds_acctgb classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<!-- �ǻ籸�� -->
<object  id=gcds_rstremark classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
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
					<td height ="'vAlign="center"><strong><h4>* </h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Cancel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
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
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" rowspan=2 >�˻�</td>
			<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">���¹�ȣ</td>
			<td width="600px"  class="tab18"  align=left  colspan=3>
		    	<comment id="__NSID__">
				<object id=gcem_acctcd2 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:40px">
					<param name=Text		  value="">
					<param name=Alignment	  value=0>
					<param name=Border		  value=true>
					<param name=Format		  value="####">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="false">
				</object>
			    </comment><script>__ws__(__NSID__);</script></nobr>
		    	
		    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Acctinfo()">
		    	
		    	<comment id="__NSID__">
				<object  id=gcem_acctno2 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:5px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language			value=1>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		<tr> 
			<td width="100px;" class="tab21"  bgcolor="#eeeeee" align="center">�����ڵ�</td>
			<td width="400px"  class="tab21"   >
				<comment id="__NSID__">
				<object id=gcem_bankcd2 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:40px">
					<param name=Text		  value="">
					<param name=Alignment	  value=0>
					<param name=Border		  value=true>
					<param name=Format		  value="###">
					<param name=PromptChar	  value="_">
					<param name=Enable		  value="false">
				</object>
			    </comment><script>__ws__(__NSID__);</script></nobr>
		    	
		    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Bank2()">
		    	
		    	<comment id="__NSID__">
				<object  id=gcem_banknm2 classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:4px;top:2px" >		
					<param name=Text		  value="">
					<param name=Border        value=true>
					<param name=GeneralEdit   value="true">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=Language			value=1>
				</object></comment><script>__ws__(__NSID__);</script>
				
			</td>
			<td class="tab21" width="100px;" bgcolor="#eeeeee" align="center">�������</td>
			<td class="tab21" >&nbsp;
				<comment id="__NSID__">
				<object id=gcra_status2 classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:175px;height:20px" >
					<param name=Cols		value="3">
					<param name=Format	value="T^���,F^�̻��,A^��ü">
				</object></comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr> 
	</table>

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
								<FC>ID=ACCTCD,	     Name=����,		    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </FC>
								<FC>ID=ACCTNO	     Name=���¹�ȣ,		width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  </FC>
								<C> ID=BANKCD,	     Name=����,		    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=BANKNM,		 Name=�����, 		width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
								<C> ID=BRCHNM,		 Name=��������,		width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
								<C> ID=ACCTUSE,	     Name=���¿뵵,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
								<C> ID=ACCTGBNM,	 Name=���±���,	    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=DEPOGB,	     Name=��Ȳ����,	    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true   EditStyle=Combo,  Data='1:������Ȳ,2:����,3:��Ź��ġ��,4:�㺸����' </C>
								<C> ID=INRATE,		 Name=������, 		width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,  sort = true  </C>
								<C> ID=REMARK,		 Name=����,  		width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  </C>
								<C> ID=STATUS,	     Name=����,	        width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true   EditStyle=Combo,  Data='T:���,F:�̻��' </C>
								<C> ID=TEAMNM,	     Name=�����,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
								<C> ID=RESULT,		 Name=��������,		width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,  	sort = true,  EditStyle=Combo,  Data='1:�Ա�,2:���' </C>
								<C> ID=RSTREMARK,	 Name=��������,		width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,  	sort = true,  EditStyle=Lookup  Data='gcds_rstremark:CDCODE:CDNAM'</C>
								<C> ID=RSTSEQ,		 Name=��������,		width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true, </C>
								<C> ID=COSTCD,		 Name=����,		    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true, </C>
								<C> ID=COSTNM,		 Name=������,		    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true, </C>
							
							">
						 	</object></comment><script>__ws__(__NSID__);</script> 
						</td>
				  	</tr>
				 </table>
			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:346px;height:400px;border:1 solid #708090;">
					<tr>
						<td style="width:80px;height:25px;" bgcolor="#eeeeee" align=center class="tab19" ><nobr>&nbsp;���¹�ȣ(*)</nobr></td>               
						<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<input id="txt_acctcd" class="txtbox" type="text" style="width:40px;position:relative;left:5px;top:0px" maxlength="4" onBlur="bytelength(this,this.value,7);" ReadOnly>
							<input id="txt_acctno" class="txtbox" type="text" style="width:180px;position:relative;left:5px;top:0px" >
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����(*)</nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__">
							<object id=gcem_bankcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:30px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="###">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Bank()">
					    	<comment id="__NSID__">
							<object  id=gcem_banknm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:150px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center><nobr>��������(*)</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object id=gcem_brchcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:45px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="######">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Branch()">
					    	<comment id="__NSID__">
							<object  id=gcem_brchnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:140px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script>
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_rstremark   classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:5px;top:2px;font-size:12px;width:145px;">
									<param name=ComboDataID      value="gcds_rstremark">
									<param name=CBDataColumns	 value="CDCODE,CDNAM">
									<param name=SearchColumn	 value="CDNAM">
									<param name=Sort			 value=true>
									<param name=SortColumn       value="CDCODE">
									<param name=ListExprFormat   value="CDNAM^0^150">								
									<param name=BindColumn		 value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�����̸�(*)</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_acctuse"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:225px;height:20px;">
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���±���(*)</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>&nbsp;
							<comment id="__NSID__">
							<object  id=gclx_acctgb classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:-5px;top:2px;font-size:12px;width:145px;">
									<param name=ComboDataID      value="gcds_acctgb">
									<param name=CBDataColumns	 value="CDCODE,CDNAM">
									<param name=SearchColumn	 value="CDNAM">
									<param name=Sort			 value=true>
									<param name=SortColumn       value="CDCODE">
									<param name=ListExprFormat   value="CDNAM^0^150">								
									<param name=BindColumn		 value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script> 
							</nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��Ȳ����(*)</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>&nbsp;
							<comment id="__NSID__">
							<object  id=gclx_depogb classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:-5px;top:2px;font-size:12px;width:145px;">
									<param name=CBData			 value="1^������Ȳ,2^����,3^��Ź��ġ��,4^�㺸����,5^���Ա���Ȳ">
									<param name=CBDataColumns	 value="CODE,NAME">
									<param name=SearchColumn	 value=NAME>
									<param name=Sort			 value=false>
									<param name=ListExprFormat   value="NAME^0^110">								
									<param name=BindColumn		 value="CODE">
									<param name=Enable           value=true>
							</object></comment><script>__ws__(__NSID__);</script> 
							</nobr>
						</td>
					</tr>
					<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_inrate classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:50;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=Alignment		value=2>
								<param name=Numeric			value=true>
								<param name=IsComma			value=true>
								<param name=MaxLength		value=2>
								<param name=MaxDecimalPlace	value=2>
							</object></comment><script>__ws__(__NSID__);</script>
						</nobr> </td> 
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;">
						</nobr> </td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object id=gcem_teamcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:45px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="######">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Team()">
					    	<comment id="__NSID__">
							<object  id=gcem_teamnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:140px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script>
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object id=gcem_costcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:45px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="######">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Cost()">
					    	<comment id="__NSID__">
							<object  id=gcem_costnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:140px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script>
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">	
							<object  id=gclx_result classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:5px;top:2px;font-size:12px;width:120px;">
									<param name=CBData			 value="1^�Ա�,2^���">
									<param name=CBDataColumns	 value="CODE,NAME">
									<param name=SearchColumn	 value=NAME>
									<param name=Sort			 value=false>
									<param name=ListExprFormat   value="NAME^0^110">								
									<param name=BindColumn		 value="CODE">
									<param name=Enable           value=true>

							</object></comment><script>__ws__(__NSID__);</script> 
						</nobr></td>
					</tr>

					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_rstseq classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:4px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language	  value=1>
							</object>
							</comment><script>__ws__(__NSID__);</script>
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_status classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
								<param name=Cols	value="2">
								<param name=Format	value="T^���,F^�̻��">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_enddat classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_enddat', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;</nobr>
						</td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td height="20px" class="tab12" align=center colspan=2 > * ǥ�ð��� �ʼ� �׸��Դϴ�.</td>
					</tr>
			  </table>
		 </td>
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
	</tr>	
	
	<tr>
		<td colspan="2" height="24" align="left"> <font size="2" color="blue"><strong> 1���� 1������ ��츸 �����ڵ� �Է�</strong></font></td>
	</tr>	
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp2 classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=ACCTNO       Ctrl=txt_acctno        Param=value</C>
	<C>Col=BANKCD	    Ctrl=gcem_bankcd       Param=text</C>
	<C>Col=BANKNM	    Ctrl=gcem_banknm       Param=text</C>
	<C>Col=ACCTCD	    Ctrl=txt_acctcd        Param=value</C>
	<C>Col=BRCHCD	    Ctrl=gcem_brchcd       Param=text</C>
	<C>Col=BRCHNM	    Ctrl=gcem_brchnm       Param=text</C>
	<C>Col=ACCTUSE	    Ctrl=txt_acctuse       Param=value</C>
	<C>Col=ACCTGB	    Ctrl=gclx_acctgb       Param=bindcolval</C>
	<C>Col=DEPOGB	    Ctrl=gclx_depogb       Param=bindcolval</C>
	<C>Col=INRATE	    Ctrl=gcem_inrate       Param=text</C>
	<C>Col=REMARK	    Ctrl=txt_remark        Param=value</C>
	<C>Col=STATUS	    Ctrl=gcra_status       Param=codevalue</C>
	<C>Col=ENDDAT	    Ctrl=gcem_enddat       Param=text</C>
	<C>Col=TEAM 	    Ctrl=gcem_teamcd       Param=text</C>
	<C>Col=TEAMNM	    Ctrl=gcem_teamnm       Param=text</C>
	<C>Col=RESULT	    Ctrl=gclx_result       Param=bindcolval</C>
	<C>Col=RSTREMARK    Ctrl=gclx_rstremark    Param=bindcolval</C>
	<C>Col=RSTSEQ	    Ctrl=gcem_rstseq       Param=text</C>
	<C>Col=WRDT 	    Ctrl=txt_wrdt          Param=value</C>
	<C>Col=COSTCD 	    Ctrl=gcem_costcd       Param=text</C>
	<C>Col=COSTNM 	    Ctrl=gcem_costnm     Param=text</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ��ü��Ͽ�û (�ؿ�,���� ) 
+ ���α׷� ID	: a010052.jsp
+ �� �� �� ��	: ��ü��Ͽ�û (�ؿ�,���� )
+ �� �� �� ��	: 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010050_s1, a010050_t1
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
    
    gclx_status_0.bindcolval ="N";    
    gclx_status.bindcolval ="N";
    
    txt_empno_0.value =gusrid;
	txt_empnmk_0.value = gusrnm;
	
    document.getElementById("txt_vend_nm").disabled = true;
    document.getElementById("txt_vend_nm").className = "input_ReadOnly";
}

<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query(){
		
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010052_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="    
                                                                        +"&v_str5="+txt_empno_0.value   	
                                                                        +"&v_str6="     
	                                                                    +"&v_str7=A";                                                                                                                                                                                                                                                            
   // prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

<%
/******************************************************************************
	Description : �߰�
******************************************************************************/
%>

function ln_Add(){
	
    document.getElementById("txt_vend_nm").disabled = false;
    document.getElementById("txt_vend_nm").className = "";	
	
	ln_SetDataHeader();
	gcds_data.addrow();	
    gclx_status.bindcolval ="N";
    gcds_data.namevalue(gcds_data.rowposition,"USE_TAG")="Y";
    
    txt_empnok.value="";
}

<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
	    if(!ln_Chk_Save_Status())return;
	    
	    //���� �ŷ�ó ���̺��� Ȯ�� ��. 
	    //������ ��� �ŷ�ó �ڵ� üũ ���ϰ� �����ϴ���....  
	    //�ؿ��� ��� ���� �ŷ�ó �� �����ϴ��� üũ ......
	    
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010052_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt(this, gcds_data.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

<%
/******************************************************************************
	Description : ���� 
******************************************************************************/
%>
function ln_Delete(){

    //���°� üũ 
    if(!ln_Chk_Delete_Status()) return false;
    
	if (confirm(" �ش� �����͸� ���� �Ͻðڽ��ϱ�?")){	
		gcds_data.DeleteMarked();
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		ln_Query();
	}	
}

<%
/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
%>
function ln_Chk_Save() {

  //���°��� ��� �ϰ�츸 ���� 
   for(i=1;i<=gcds_data.countrow;i++){
   		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
   		
			if(fn_trim(gcds_data.namevalue(i,"VEND_NM")) == ""){//�ŷ�ó��
				alert("�ŷ�ó����  �Է��ϼ���.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VENDER_USERGB")) == ""){//����
				alert("������  �Է��ϼ���.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VENDER_USERGB")) == "K"){//����
				if(fn_trim(gcds_data.namevalue(i,"EMPNO")) == ""){//����
					alert("������ ������ ��� ��������� �Է��Ͻʽÿ�.");
					return false;
				}
			}
			
			if(fn_trim(gcds_data.namevalue(i,"STATUS")) == ""){//����
				alert("���¸�  �Է��ϼ���.");
				return false;
			}
			
			gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010052_s2?v_str1="+gcds_data.namevalue(i,"VENDER_USERGB")
																		          +"&v_str2="+gcds_data.namevalue(i,"VEND_NM")
																		          +"&v_str3="+gcds_data.namevalue(i,"EMPNO");
                                                                                                                                                                                                                                                 
			// prompt('',gcds_data.DataID);
			gcds_temp01.Reset();
			
			if(gcds_temp01.namevalue(gcds_temp01.rowposition,"CNT")>0){
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� �̹� ������ ������ �Դϴ�.");
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
	Description : ���ο�û
******************************************************************************/
%>
function ln_AppReq(){
    //���°� üũ : ��� �ݼ� ���¸� ��û ������ 
    if(!ln_Chk_Status()) return false;
   
	if (confirm(" �ش� �ŷ�ó ��� ���� ��û �Ͻðڽ��ϱ�?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t2";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
	//	prompt('',gcds_data.text);
		gctr_data.post();
		ln_Query();
	}else{
		gcds_data.UndoAll();
	}	
}

<%
/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
%>
function ln_Chk_Save_Status(){
	for(var i =1; i<=gcds_data.countrow;i++){
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data.SysStatus(i)==3){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ���� ���ɰ��� �ƴմϴ�.");
				return false;
			}
		}
	}
	return true;
}
<%
/******************************************************************************
	Description : ���°� üũ 
******************************************************************************/
%>
function ln_Chk_Status(){
    var vcnt=0;
    
    for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.SysStatus(i)=="1"){
				alert("���� �� ���ο�û �Ͻʽÿ�.");
				return false;
			}
			vcnt+=1;	
		}
	}
    
    
    if (vcnt==0){
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	
    
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� ��û ���ɰ��� �ƴմϴ�.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
		}
	}
	
	return true;
}
<%
/******************************************************************************
	Description : ���°� üũ ����
******************************************************************************/
%>
function ln_Chk_Delete_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")=="Y"){
				alert(gcds_data.namevalue(i,"VEND_NM") + "��  ���� ���ɰ��� �ƴմϴ�.");
				return false;
			}
			gcds_data.MarkRows(i,i);
			vcnt+=1;
		}
	}
	
	if (vcnt==0){
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	return true;
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : ���ڿ�üũ
******************************************************************************/

/******************************************************************************
	Description : Dataset Head ���� -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
					+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
					+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
					+ "USE_TAG:STRING,"
					+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
					+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
					+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
					+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING,VENDER_USERGB:STRING,EMPNO:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
}

<%
/***********************************************************************************************
	Description : ���ã��
	parameter   :
**********************************************************************************************/
%>
function ln_Popup_Empno_0(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]=""; //

	strURL =  "./empno_popup.jsp";
	strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno_0.value =arrResult[1];
		txt_empnmk_0.value = arrResult[0];
	}else{
   		txt_empno_0.value="";
		txt_empnmk_0.value="";
	}
}

<%
/***********************************************************************************************
	Description : ���ã��
	parameter   :
**********************************************************************************************/
%>
function ln_Popup_Empno(){
	
	if(gcra_vender_usergb.codevalue!="K"){
		alert("�����ڵ尡 ������ �����մϴ�.");
		return false;
	}
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="" ;//

	strURL =  "./empno_popup.jsp";
	strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno.value =arrResult[1];
		txt_empnmk.value = arrResult[0];
		txt_vend_nm.value = arrResult[0];
	}else{
   		txt_empno.value="";
		txt_empnmk.value="";
	}
}



</script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 
</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
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
//		ln_Query();
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcra_vender_usergb event=OnSelChange()>
    if(gcra_vender_usergb.codevalue=="K"){
    	
    }else{
        txt_empno.value="";
    	txt_empnmk.value="";
    }
</script>



<script language=JavaScript for=gcgd_data event=OnClick(row,colid)>
	if(gcra_vender_usergb.codevalue=="K"){
		
	}else{
	    txt_empno.value="";
		txt_empnmk.value="";
	}
   
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

</script>
 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010050_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
    
            
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"	style="cursor:hand" onclick="ln_AppReq()" >&nbsp;&nbsp;
    
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="90px;" bgcolor="#eeeeee" align="center">�ŷ�ó�ڵ�</td>
			<td class="tab18" width="80px" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:70px" >
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit		    value="true">
				<param name=PromptChar		    value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="80px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td class="tab24" width="130px"  align="left" ><comment id="__NSID__">
				<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:120px" >
				<param name=Text			     value="">
				<param name=Alignment		    value=0>
				<param name=Border			    value=true>
				<param name=GeneralEdit		    value="true">
				<param name=PromptChar		    value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="70px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab24" >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
						<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
						<param name=CBDataColumns	     value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			      value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
		
		<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">�ۼ���</td>
		<td class="tab14" ><nobr> &nbsp;
			<input type="text" class="txt11" id="txt_empno_0"  style="position:relative;top:2px;left:-2px;width:60px;background-color:#d7d7d7" readOnly>
			<img src="../../Common/img/btn/com_b_find.gif" alt="�ڵ� �� �ڵ���� �˻��մϴ�" style="cursor:hand;position:relative;top:2px;left:-3px" onclick="ln_Popup_Empno_0()">
		    <input type="text" class="txt11" id="txt_empnmk_0" maxlength=8 style="position:relative;top:2px;left:-4px;width:90px;"></nobr> 
		</td> 	 
			
		</tr>
		
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:555px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"		VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="true">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="sortview"     value=left>
						 <param name="Editable"     value='true'>
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"		VALUE="  
					        <FC>ID=CHK 	         Name='����'             Width=28    HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<FC>ID=VEND_CD	     Name=�ŷ�ó�ڵ�,		    width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
							<FC>ID=VEND_NM	     Name=�ŷ�ó��,			width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
							<C>ID=REMARK	     Name=���,		    	width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</C>
							<C>ID=STATUS		 Name=����,			    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
						    <C>ID=SB_REASON      Name=�ݼۻ���,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:310px;height:400px;border:1 solid #708090;">
				
				<tr>
				    <td style="width:100px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�ڵ� </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;position:relative;left:-7px;top:0px;background-color:#d7d7d7"    ReadOnly>
					</td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee"  class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;�ŷ�ó�� </nobr></td>               
					<td Style="width:200px;height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;position:relative;left:-7px;top:0px"   >
					</td>
				</tr>
				<tr>
				    <td style="width:100px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;���� </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
							<object id=gcra_vender_usergb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:120px;height:20px;position:relative;top:2px" >
								<param name=Cols	value="2">
								<param name=Enable 	value="true">
								<param name=Format	value="F^�ؿ�,K^����">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						
						<!-- 
						<span id=sp0 style="display:none;">
						<input id="txt_empno_k" class="txtbox" type="text"  maxlength=7 style="width:55px;position:relative;left:-10px;top:-3px"   >
						</span>
						 -->
						</nobr>
					</td>
				</tr>
				
				<tr>
					<td width="80px"   height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;������</nobr></td>
					<td class="tab13"  height="25px" style="text-align:left"><nobr>
						<input type="text" class="txtbox" id="txt_empno"  style="position:relative;top:0px;left:4px;width:60px;background-color:#d7d7d7" readOnly>
						<img src="../../Common/img/btn/com_b_find.gif" alt="�ڵ� �� �ڵ���� �˻��մϴ�" style="cursor:hand;position:relative;top:2px;left:0px" onclick="ln_Popup_Empno()">
						<input type="text" class="txtbox" id="txt_empnmk" maxlength=7 style="position:relative;top:0px;left:-4px;width:85px;"></nobr> 
					</nobr></td>
				</tr>
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;���</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
					</nobr></td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;�����</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
					</nobr></td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;����Ͻ�</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
					</nobr></td>
				</tr>
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;����</nobr></td>
					<td class="tab13" style="text-align:left"><nobr><comment id="__NSID__">
					 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
										<param name=CBData			         value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
										<param name=CBDataColumns	 value="CODE,NAME">
										<param name=SearchColumn	     value=NAME>
										<param name=Sort			             value=false>
										<param name=ListExprFormat       value="NAME">								
										<param name=BindColumn		     value="CODE">
										<param name=Enable                   value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
					</nobr> </td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;�ݼۻ���</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_sb_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
					</nobr></td>
				</tr>
				<tr>
					<td height="202px" align=center colspan=2 > <font color="#ff0000">*</font> ǥ�ð��� �ʼ� �׸��Դϴ�.
					<br> �ؿ� - F, ���� - K 
					
					</td>
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

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=VEND_CD,       Ctrl=txt_vend_cd         Param=value		</C>
		<C>Col=VEND_NM,       Ctrl=txt_vend_nm         Param=value		</C>
		<C>Col=REMARK,    	  Ctrl=txt_remark          Param=value		</C>
		<C>Col=WRID,      	  Ctrl=txt_wrid            Param=value		</C>
		<C>Col=WRDT,      	  Ctrl=txt_wrdt            Param=value		</C>
		<C>Col=STATUS,   	  Ctrl=gclx_status 	       Param=bindcolval	</C>
		<C>Col=SB_REASON,     Ctrl=txt_sb_reason       Param=value     	</C>
		<C>Col=VENDER_USERGB, Ctrl=gcra_vender_usergb  Param=codevalue	</C>
		<C>Col=EMPNO,   	  Ctrl=txt_empno 	       Param=value   	</C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ŷ�ó������ڰ���
+ ���α׷� ID	: a010047.jsp
+ �� �� �� ��	: �ŷ�ó������ڰ���
+ �� �� �� ��	: ���ϳ�
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ �� �� �� ��  :	���������� �ŷ�ó ã�� ��ư ��� ����
+ ��   ��  ��  :  ������
+ �� �� �� ��  :  2009.10.09

+ �� �� �� ��	: �̵��� 2020.07.21 630��° �ٿ� Format�� ��������
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010047_s1, a010047_t1
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

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	if(gf_empno_Enable(gs_userid,gcds_userid2)){
			sp0.style.display = "";
		}else{
		sp0.style.display = "none"; //����
	}

    gcra_useyn.codevalue ="T";	
    gcra_usegb_0.codevalue="1"
    gclx_status_0.bindcolval="Y";

	txt_vend_cd.value  = "" ;
	txt_vend_nm.value  = "" ;
	gcem_vend_id2.text	= "" ;
	txt_empnm.value	= "" ;	
	txt_email.value	= "" ;	
	txt_deptnm.value = "" ;	
	txt_hpno.value	= "" ;	
	txt_telno.value	= "" ;	
	gcem_dsudt.text = "" ;	
	gcra_usegb.CodeValue = "" ; 
	txt_bsns_cnd.value	= "" ;	
	txt_bsns_knd.value = "" ;											
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_s1?v_str1="+gcem_vend_cd.text
			                                                            +"&v_str2="+gcem_vendnm.text
			                                                            +"&v_str3="+gcem_vend_id.text
			                                                            +"&v_str4="+gcem_empnm.text
			                                                            +"&v_str5="+gcra_useyn.codevalue
																		+"&v_str6="+gclx_status_0.bindcolval
																		+"&v_str7="+gcra_usegb_0.codevalue;
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	ln_SetDataHeader();
	gcds_data.addrow();	
	gcra_usegb.CodeValue="T";
	
	//���� ���μ��� ����. 
	//gclx_status.bindcolval ="N";
	gclx_status.bindcolval ="Y";
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_pyo.post();
		ln_Query();
		}	
	}
}

/******************************************************************************************
	Descrition : �α��ν� �ش����� ���� ������.
	parameter  : ����ڵ�
	retun      : true - ���� , false - �Ұ���
	             gcds_name - dataset ��
******************************************************************************************/
function gf_empno_Enable(s, gcds_name){
	gcds_name.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s5?v_str1=2169"
													                    +"&v_str2="+s;	                                                 
  //prompt("",gcds_name.DataID );																							
	gcds_name.Reset();			

	if(gcds_name.countrow>0){
		return true;
  	}else { 
		return false;
	}
}


/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){

	//	alert("::i:"+i+"::gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i)); 

				if(gcds_data.namevalue(i,"VEND_CD") == ""){ //�ŷ�ó				
					alert("�ŷ�ó�� �Է��ϼ���.");
					return false;
				}
				if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
					alert("����ڵ�Ϲ�ȣ�� �Է��ϼ���.");
					return false;
				}
				if(gcds_data.namevalue(i,"EMPNM") == ""){ //����ڸ�				
					alert("����ڸ��� �Է��ϼ���.");
					return false;
				}
				if(gcds_data.namevalue(i,"BSNS_CND") == "" || gcds_data.namevalue(i,"BSNS_KND") == "" ){ //����, ����				
					alert("���� �Ǵ� ���¸� ��ü �ڵ�������� ���� �Է����ּ��� .");
					return false;
				}
				if(gcds_data.namevalue(i,"EMAIL") == "" ){ //EMAIL				
					alert("EMAIL�� �Է��ϼ���.");
					return false;
				}else{
					var aa = gcds_data.namevalue(i,"EMAIL");
					if(!ln_email(aa)){
					//	alert("result::"+result);  
						alert("EMAIL�� ��Ȯ�� �Է��ϼ���.");
						return false;
					} 
				}
			}

	} return true;
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.KeyValue = "Account.A010047_t1(I:USER=gcds_data)";
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t1";
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


/******************************************************************************
	Description : ���ڿ�üũ
******************************************************************************/
function ln_email(src){

	var src;
	for (j=0;j<src.length;j++){
	//  alert("::j::::"+j);
		if(src.charAt(j) =="@"){
			return true;		
		}
	}  
	
	return false;
} 


/******************************************************************************
	Description : �˾�
******************************************************************************/
function ln_Find2(){
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

  //

	if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
    alert("�ű� ��Ͻÿ��� ã�� ��ư ���� �����մϴ�.");
		return;
	}
	//if(gcds_data.countrow >0&& gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")<>""&&gcds_data.namevalue(gcds_data.rowposition."VEND_NM")<>""){
   // alert("�űԵ�Ͻÿ��� ã�� ��ư ���� �����մϴ�.");
	//	return;
//	}


	strURL = "../../Account/jsp/a010047_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
//alert("result::"+arrParam);
	 	txt_vend_nm.value = arrParam[1];
		txt_vend_cd.value = arrParam[0];
		gcem_vend_id2.text = arrParam[2];
		txt_bsns_cnd.value = arrParam[3];
		txt_bsns_knd.value = arrParam[4];
	} else {
		txt_vend_nm.value = "";
		txt_vend_cd.value = "";
		gcem_vend_id2.text = "";
		txt_bsns_cnd.value = "";
		txt_bsns_knd.value = "";
	} //�ŷ�ó ã��
}



/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){

}


/******************************************************************************
	Description : Dataset Head ���� -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "CHK:String(1),SEQ:Decimal(2),VEND_CD:String(13),VEND_NM:String(62),VEND_ID:String(15),EMPNM:String(30),"
					+ "EMAIL:String(40),DEPTNM:String(30),HPNO:String(15),"
					+ "TELNO:String(15),ENDDT:String(8),USEGB:String(1),BSNS_CND:String(62),BSNS_KND:String(62),I_EMPNO:String(10),"
					+ "U_EMPNO:String(10),STATUS:String(1),VEND_ID_LEN:Decimal(2),SB_REASON:String(100)";
		gcds_data.SetDataHeader(THeader);		//Header Set
	}
}


<%
/******************************************************************************
Description : ���ο�û
******************************************************************************/
%>
function ln_AppReq(){
    //���°� üũ : ��� �ݼ� ���¸� ��û ������ 
	if(!ln_Chk_Status("���ο�û")) return false;
	
	if (confirm(" �ش� �ŷ�ó ��� ���� ��û �Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010047_t2";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
	//	prompt('',gcds_data.text);
		gctr_pyo.post();
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
function ln_Chk_Status(strReq){
	var vcnt=0;
	
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.SysStatus(i)=="1"){
				alert("���� �� "+strReq+" �Ͻʽÿ�.");
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
				alert(gcds_data.namevalue(i,"VEND_NM")+"�� "+strReq+" ��� ���� �ƴմϴ�.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
		}
	}
	return true;
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</object>
	
	<!-- �α��� ��� üũ  -->
	<object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
 	<object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
	</object>
</comment><script>__ws__(__NSID__);</script>

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
//		ln_Query();
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";


</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id.Format = "000-00-00000";    //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
</script>

<script language=JavaScript for=gcgd_pyo event=OnClick(row,colid)>
    var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }

	if(intChk==10){ //
		gcem_vend_id2.Format = "000-00-00000";    //���� 
	}else if(intChk==13){
		gcem_vend_id2.Format = "000000-0000000";  //���� 
	}
	
	gcem_vend_id2.text = gcds_data.namevalue(row,"VEND_ID");
	
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id2.Format = "000-00-00000";    //���� 
	}else if(intChk==13){
		gcem_vend_id2.Format = "000000-0000000";  //���� 
	}
	gcem_vend_id2.text = gcds_data.namevalue(row,"VEND_ID");

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
	    <td ><img src="../img/A010047_head.gif"></td>
	    <td width="685" align="right" background="../../Common/img/com_t_bg.gif"         style="padding-top:4px;">
				<!-- <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"   	 style="cursor:hand" onclick="ln_AppReq()">&nbsp;&nbsp; -->
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	     style="cursor:hand" onclick="ln_Add()" >
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"       style="cursor:hand" onclick="ln_Cancel()">
				<span id=sp0 style="display:none;">
					<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"   style="cursor:hand" onclick="ln_Delete()"> 
				</span>
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		 style="cursor:hand" onclick="ln_Save()">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		 style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
   </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15"  width="100px;" bgcolor="#eeeeee" align="center">�ŷ�ó�ڵ�</td>
			<td class="tab18"  width="90px" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit			value="true">
				<param name=PromptChar			value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td class="tab24" width="200px"  align="left" ><comment id="__NSID__">
				<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab24" align="left" >
				<comment id="__NSID__">
					<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
								<param name=CBDataColumns	     value="CODE,NAME">
								<param name=SearchColumn	     value=NAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat       value="NAME">								
								<param name=BindColumn		     value="CODE">
								<param name=Enable               value="false">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		<tr> 
		<td class="tab17" width="100px;" bgcolor="#eeeeee" align="center">����ڹ�ȣ</td>
		<td class="tab11" width="230px" >
			<comment id="__NSID__">
			    <object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:130px;height:20px" >
					<param name=Cols		value="2">
					<param name=Format	value="1^�����,2^�ֹ�">
			    </object>
			
				<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
					<param name=Text		  value="">
					<param name=Alignment     value=0>
					<param name=Border        value=true>
					<param name=Numeric       value=false>
					<param name=Format        value="###-##-#####">
					<param name=PromptChar    value="">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">����ڸ�</td>
		<td class="tab21" width="200px"  align="left" ><comment id="__NSID__">
			<object  id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">����</td>
		<td class="tab11" >&nbsp;
			<comment id="__NSID__">
			<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:175px;height:20px" >
				<param name=Cols	value="3">
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
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:592px;HEIGHT:397px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"		VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="true">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="Editable"     	value='true'>
						 <param name="sortview"     value=left>
					     <PARAM NAME="Format"		VALUE="  
							<FC>ID=CHK 	        Name='����'          Width=28    HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </FC>
							<FC>ID=SEQ,		    Name=����,			width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true show = false </FC>
							<FC>ID=VEND_CD,	    Name=�ŷ�ó�ڵ�,		width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true</FC>
							<FC>ID=VEND_NM,	    Name=�ŷ�ó��,		width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   edit=none, sort = true</FC>
							<FC>ID=VEND_ID,	    Name=����ڹ�ȣ,		width=90,	HeadBgColor=#B9D4DC, align=center,   mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-*XXXXXX')} , edit=none, sort=true</FC>
							<FC>ID=EMPNM,		Name=����ڸ�,		width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </FC>
							<C> ID=EMAIL,		Name=E-mail,		width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=DEPTNM,	    Name=����ںμ���,	    width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=HPNO,		Name=�ڵ���,		    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true show = true </C>
							<C> ID=TELNO,		Name=��ȭ��ȣ,		width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none, sort = true show = true </C>
							<C> ID=ENDDT,		Name=�������,		width=85,	HeadBgColor=#B9D4DC, align=center,   Mask='XXXX/XX/XX', edit=none, sort=true</C>
							<C> ID=BSNS_CND,	Name=����,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=BSNS_KND,	Name=����,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	edit=none, sort = true show = true </C>
							<C> ID=USEGB		Name=��뱸��,		width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, 	edit=none, sort = true, EditStyle=Combo, Data='T:���,F:�̻��', show = true </C>
							<C> ID=STATUS,	    Name=����,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   edit=none, sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�',show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:230px;height:400px;border:1 solid #708090;">
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee" align=center class="tab19" rowspan="2" ><nobr>&nbsp;�ŷ�ó(<font color="#ff0000">*</font>)</nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:180px;position:relative;left:-5px;top:0px"  ReadOnly >
					</td>
				</tr>
				<tr>
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:80px;position:relative;left:-5px;top:0px" maxlength="7"  ReadOnly>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:-8px;top:3px;cursor:hand;" onclick="ln_Find2()">						
					</td>
				</tr>
				<tr>
					<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����ڹ�ȣ(<font color="#ff0000">*</font>)</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:1px;top:3px">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
				<!--  	<param name=Format        value="###-##-#####"> -->
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=readOnly      value=true>
					   </object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����ڸ�(<font color="#ff0000">*</font>)</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_empnm"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
					</nobr></td>
				</tr>
					<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>���ڿ���(<font color="#ff0000">*</font>)</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
						<input id="txt_email"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:160px;height:20px;">
						</nobr></td>
					</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�μ���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_deptnm"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
						</nobr></td>
				</tr>
				<tr>
						<td width="80px" height="35px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ڵ���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_hpno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
						</nobr> ��)000-0000-0000 </td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>��ȭ</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_telno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:80px;height:20px;">
						</nobr> ��)000-0000-0000 </td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>&nbsp;<comment id="__NSID__">
							<object  id=gcem_dsudt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							style="position:relative;top:3px;left:1px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_dsudt', 'Text')" style="position:relative;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
						</td>
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�������</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_usegb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:-6px;top:2px;width:114px;height:20px;">
								<param name=Cols	value="2">
								<param name=Format	value="T^���,F^�̻��">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_cnd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
						</nobr></td>

				</tr>
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bsns_knd"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
				
				<tr>
						<td class="tab19"  width="80px" height="25px" bgcolor="#eeeeee" align=center ><nobr>����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<comment id="__NSID__">
					 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
										<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�,B^�ݼ�">
										<param name=CBDataColumns	     value="CODE,NAME">
										<param name=SearchColumn	     value=NAME>
										<param name=Sort			     value=false>
										<param name=ListExprFormat       value="NAME">								
										<param name=BindColumn		     value="CODE">
										<param name=Enable               value="false">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						</nobr></td>
				</tr>
				<tr>
						<td class="tab19"  width="80px" height="25px" bgcolor="#eeeeee" align=left><nobr>&nbsp;&nbsp;&nbsp;�ݼۻ���</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_sb_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
				</tr>
				
				<tr>
						<td height="25px"  align=center colspan=2 > <font color="#ff0000">*</font> ǥ�ð��� �ʼ� �׸��Դϴ�.</td>
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

		<C>Col=VEND_CD,	    Ctrl=txt_vend_cd    Param=value			</C>
		<C>Col=VEND_NM,	    Ctrl=txt_vend_nm	Param=value			</C>
		<C>Col=VEND_ID,	    Ctrl=gcem_vend_id2	Param=text			</C>
		<C>Col=EMPNM,	    Ctrl=txt_empnm		Param=value			</C>
		<C>Col=EMAIL,	    Ctrl=txt_email		Param=value			</C>
		<C>Col=DEPTNM,		Ctrl=txt_deptnm		Param=value			</C>
		<C>Col=HPNO,		Ctrl=txt_hpno		Param=value			</C>
		<C>Col=TELNO,		Ctrl=txt_telno		Param=value			</C>
		<C>Col=ENDDT,		Ctrl=gcem_dsudt		Param=text			</C>
		<C>Col=BSNS_CND,	Ctrl=txt_bsns_cnd	Param=value			</C>
		<C>Col=BSNS_KND,	Ctrl=txt_bsns_knd	Param=value			</C>
		<C>Col=USEGB		Ctrl=gcra_usegb		Param=CodeValue		</C>
		<C>Col=STATUS		Ctrl=gclx_status	Param=bindcolval    </C>
		<C>Col=SB_REASON	Ctrl=txt_sb_reason	Param=value         </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �繫���� -�⺻��������-���� ���� ����
+ ���α׷� ID	: a500040.jsp
+ �� �� �� ��	: ���� ���� ���� ( ���� ������¿� �ŷ�ó �ڵ� ���� ) 
+ �� �� �� ��	: 2017.02.14
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
+ �� �� �� ��	: 
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� ��	: a500040_s1, a500040_t1
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
    gcra_usegb_0.codevalue ="1";
    gclx_bank_cd_0.index=0;
}

<%
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
%>
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.";
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500040_s1?v_str1="+gcem_vend_cd_0.text
																	    +"&v_str2="+gcem_vend_nm_0.text	
																		+"&v_str3="+gcem_vend_id_0.text 
																		+"&v_str4="+gclx_bank_cd_0.bindcolval
	                                                                    +"&v_str5="+txt_vacctno_0.value 
	                                                                    +"&v_str6="+gcra_use_yn_0.codevalue; 
	gcds_data.Reset();
	
}

<%
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Save(){
	
    if (gcds_data.IsUpdated){ 
		if(!ln_Chk_Save())return;
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){			
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500040_t1";
			gctr_pyo.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_pyo.post();	
		}
	}else{
		alert("������ �� �����ϴ�.");
	}
}

<%
/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
%>
function ln_Chk_Save() {
		
	for(var i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==3){
			if(gcds_data.namevalue(i,"BANK_CD") == ""){
				alert("���� �ڵ带 �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"BANK_NM") == ""){
				alert("������� �Է��ϼ���.");
				return false;
			}

			if(gcds_data.namevalue(i,"VEND_CD") == ""){ //�ŷ�ó	
				alert("�ŷ�ó�� �Է��ϼ���.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
				alert("����ڵ�Ϲ�ȣ�� �Է��ϼ���.");
				return false;
			}

			if(gcds_data.namevalue(i,"VACCTNO") == ""){
				alert("���¹�ȣ�� �Է��ϼ���.");
				return false;
			}	
		}
	} 
	return true;	
}

<%
/******************************************************************************
Description : �ŷ�ó �˾�
******************************************************************************/
%>
function ln_Find_Vend(e){
	
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	//�˻�����  
	if(e=="1"){
		
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:yes";
		arrResult = showModalDialog(strURL,'',strPos);	
		
		if (arrResult != null) {		
			arrParam = arrResult.split(";");
			gcem_vend_cd.text = arrParam[0];
			gcem_vend_nm_0.text = arrParam[1];
			
			ln_usegb_format(arrParam[5],"0");
		} else {
		
			gcem_vend_cd_0.text = "";
			gcem_vend_nm_0.text = "";
			gcem_vend_id_0.text ="";
		
		}
	//�Է�	
	}else if(e=="2"){
		
		if(gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")!=""){
		    alert("�ŷ�ó �ű� ����ÿ��� ã�� ��ư ����� �����մϴ�.");
			return;
		}		
		
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:yes";
		arrResult = showModalDialog(strURL,'',strPos);			
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_vend_cd.value = arrParam[0];
			txt_vend_nm.value = arrParam[1];	
			ln_usegb_format(arrParam[5],"1");
		} else {
			txt_vend_cd.value = "";
			txt_vend_nm.value = "";
			gcem_vend_id.text="";
		}		
	}
}

<%
/******************************************************************************
	Description : �����˾�
******************************************************************************/
%>
function ln_Find_Bank(strgb){
		
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	strURL = "./a500000_popup3.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
		
	if(strgb=="1"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_bank_cd.value = arrParam[0];
			txt_bank_nm.value = arrParam[1];		
		} else {
			txt_bank_cd.value = "";
			txt_bank_nm.value = "";
		} 
	}	
}

<%
/******************************************************************************
Description : data clear
******************************************************************************/
%>
function ln_usegb_format(strVendid,strGB){

	intChk = strVendid.length;
	
	if(strGB=="0"){
		
		if(intChk==10){ //
			gcem_vend_id_0.Format= "000-00-00000";    //���� 
			gcra_usegb_0.codevalue="1";
		}else if(intChk==13){
			gcem_vend_id_0.Format= "000000-0000000";  //���� 
			gcra_usegb_0.codevalue="2";
		}
		
		gcem_vend_id_0.text = strVendid;
		
	}else{
		
		if(intChk==10){ //
			gcem_vend_id.Format= "000-00-00000";    //���� 
		}else if(intChk==13){
			gcem_vend_id.Format= "000000-0000000";  //���� 
		}
		
		gcem_vend_id.text = strVendid;
		
	}
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �α��� ��� üũ  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A500010_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	if (rowcount ==0 ){		
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}else{

	}	
	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

</script>


<script language=JavaScript event="OnLoadError()" for=gcds_data>

	alert("������ �߻� �߽��ϴ�.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=gcgd_data event=OnClick(row,Colid)>
   
	if(row>0){
	
	}
	
	var intChk=0;
	
	if (row>=1){
		intChk = gcds_data.namevalue(row,"VEND_ID").length;
	}
	
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");
	
	
</script>


<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //���� 
	}
	
</script>


<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

	var intChk=0;
    
    if (row>=1){
    	intChk = gcds_data.namevalue(row,"VEND_ID").length;
    }
      
	if(intChk==10){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(intChk==13){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
	gcem_vend_id.text = gcds_data.namevalue(row,"VEND_ID");

</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.")
	//ln_Query();
</script>

<script language="javascript" for="gctr_pyo" event="onfail()">

	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
	
</script>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="1000" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:15px;">    
			<!--<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"		style="cursor:hand" onclick="ln_Add()" >-->
			<!--<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"    	style="cursor:hand" onclick="ln_Delete()"> --> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
	 <td>
		<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			
			<td class="tab15" width="80px;" bgcolor="#eeeeee" align="center" >�ŷ�ó��</td>
			<td class="tab18" width="300px"  align="left">
			<comment id="__NSID__">
				<object  id=gcem_vend_nm_0 	classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:5px;top:2px;cursor:hand;" onclick="ln_Find_Vend(1)">
			<comment id="__NSID__">			
			<object  id=gcem_vend_cd_0		classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:10px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit			value="true">
				<param name=PromptChar			value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>

			<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
			<td class="tab18" width="160px"  ><comment id="__NSID__">
				<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
					<param name=Cols	value="2">
					<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
		
			<td class="tab18" width="60px;" bgcolor="#eeeeee" align="center">��ȣ</td>
			<td class="tab18" width="90px"  Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
					<param name=Text		   value="">
					<param name=Alignment      value=0>
					<param name=Border         value=true>
					<param name=Numeric        value=false>
					<param name=Format         value="000-00-00000">
					<param name=PromptChar     value="">
					<param name=BackColor      value="#CCCCCC">
					<param name=InheritColor   value=false>
					<param name=readOnly       value=false>
			   </object></comment><script>__ws__(__NSID__);</script>
			</td>
		</tr> 
		<tr> 
			<td class="tab17"  width="80px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab20"  align="left"  >
			     <comment id="__NSID__">
					<object  id=gclx_bank_cd_0 classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:4px;top:0px;font-size:12px;width:120px;">
						<param name=CBData			        value="^��ü,081^KEB�ϳ�����,023^SC��������,004^��������,003^�������,011^��������,088^��������,020^�츮����,071^��ü��,027^�ѱ���Ƽ����">
						<param name=CBDataColumns	 		value="CODE,NAME">
						<param name=SearchColumn	     	value=NAME>
						<param name=Sort			        value=false>
						<param name=ListExprFormat       	value="NAME">								
						<param name=BindColumn		     	value="CODE">
					</object>
				 </comment><script>__ws__(__NSID__);</script>
			</td>
			
			
			<td class="tab20" width="80px;" bgcolor="#eeeeee" align="center">���¹�ȣ</td>
			<td class="tab20"   align="left" >
				<input id="txt_vacctno_0"   type="text"   class="txtbox"  style= "position:relative;left:2px;width:150px;height:20px;">				
			</td>
			
			<td class="tab20" width="80px;" bgcolor="#eeeeee" align="center">�������</td>
			<td class="tab20"   align="left" >
				<object id=gcra_use_yn_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:180px;height:20px" >
					<param name=Cols	 value="3">
					<param name=Format	 value="^��ü,T^���,F^�̻��">
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
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:650px;HEIGHT:500px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle" 		VALUE="0">
						 <PARAM NAME="Indwidth"			VALUE="0">
						 <PARAM NAME="Fillarea"			VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="Editable"     	value='true'>						 
						 <param name="sortview"    		value=left>
					     <PARAM NAME="Format"			VALUE="  
							<FC>ID=BANK_CD,	     Name=����,				width=50,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true show = true </FC>
							<FC>ID=BANK_NM,	     Name=�����, 	        width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </FC>
							<FC>ID=VACCTNO,	     Name=�������,	        width=120,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </FC>
							<FC>ID=SEQ,	     	 Name=����,			    width=30,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = false</FC>
							<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,			width=80,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=120,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,			width=90,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true mask = {decode(Len(VEND_ID),10,'XXX-XX-XXXXX',13,'XXXXXX-XXXXXXX')}</FC>
							<C> ID=USE_YN,       Name=���,           	width=50,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	 edit=none  sort = true show = true EditStyle=Combo, Data='T:���,F:�̻��'</C>
							<C> ID=FR_DT,	     Name=��������,			width=60,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true show = false</C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>
			</td>
			<td>
				<!--�Է�â -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:345px;height:500px;border:1 solid #708090;">
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>����</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_bank_cd"   type="text"   class="txtbox"  style= "position:relative;left:5px;width:30px;height:20px;background-color:#d7d7d7" readOnly>
						<!-- <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:1px;top:0px;cursor:hand;" onclick="ln_Find_Bank('1')">-->						
						<input id="txt_bank_nm"   type="text"   class="txtbox"  style= "position:relative;left:0px;width:153px;height:20px;background-color:#d7d7d7" readOnly>						
					</nobr></td>
				</tr>
				<tr>
					  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>���¹�ȣ</nobr></td>
					  <td class="tab13" style="text-align:left"><nobr>
						<input id="txt_vacctno"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:185px;height:20px;background-color:#d7d7d7"  ReadOnly>
					</nobr></td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee" align=left class="tab19"><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>�ŷ�ó�ڵ�</nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:80px;position:relative;left:-5px;top:-1px;background-color:#d7d7d7"    ReadOnly >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:-5px;top:0px;cursor:hand;" onclick="ln_Find_Vend(2)">						
					</td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee" align=left class="tab19"><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>�ŷ�ó��</nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:230px;position:relative;left:-5px;top:0px;background-color:#d7d7d7"  ReadOnly>
					</td>
				</tr>
				<tr>
					<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;<font color="#ff0000">*</font>����ڹ�ȣ</nobr></td>
					<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:150px;height:20px;position:relative;left:0px;top:2px">		
						<param name=Text					value="">
						<param name=Alignment     			value=0>
						<param name=Border        			value=true>
						<param name=Numeric       			value=false>
						<param name=Format        			value="###-##-#####">
						<param name=PromptChar    			value="">
						<param name=ReadOnlyBackColor   	value="#d7d7d7">
						<param name=InheritColor  			value=false>
						<param name=readOnly      			value=true>
					   </object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;�������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<comment id="__NSID__">
							<object id=gcra_use_yn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
								<param name=Cols	value="2">
								<param name=Format	value="T^���,F^�̻��">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;��������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
									<object id=gcem_fr_dt classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70px;height:20px;position:relative;left:4px;top:3px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_fr_dt', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;��������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
									<object id=gcem_to_dt classid=clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:70px;height:20px;position:relative;left:4px;top:3px">		
									<param name=Text		  value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									</object>
									</comment><script>__ws__(__NSID__);</script>   
									<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_to_dt', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						</nobr> </td>
				</tr>
				
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;�����</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>
					
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>								
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;������</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_upid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>	
				<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;�����Ͻ�</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_updt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:230px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr> </td>
				</tr>	
		
				<tr>
						<td height="100px" align=center colspan=2 > <font color="#ff0000">*</font> ǥ�ð��� �ʼ� �׸��Դϴ�.</td>
				</tr>
			  </table>
		 </td>
		 </tr>
		</table>

	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td>
		<br>
   </tr>
   
  
  
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=VEND_CD,	    Ctrl=txt_vend_cd    Param=value			</C>
		<C>Col=VEND_NM,	    Ctrl=txt_vend_nm	Param=value			</C>
		<C>Col=VEND_ID,	    Ctrl=gcem_vend_id	Param=text			</C>
		<C>Col=BANK_CD,	    Ctrl=txt_bank_cd	Param=value			</C>
		<C>Col=BANK_NM,	    Ctrl=txt_bank_nm	Param=value			</C>
		<C>Col=VACCTNO,		Ctrl=txt_vacctno	Param=value			</C>		
		<C>Col=USE_YN,   	Ctrl=gcra_use_yn 	Param=codevalue	    </C>
		<C>Col=FR_DT,   	Ctrl=gcem_fr_dt 	Param=text   	    </C>
		<C>Col=TO_DT,   	Ctrl=gcem_to_dt 	Param=text  	    </C>
		<C>Col=WRID,    	Ctrl=txt_wrid 		Param=value			</C>
		<C>Col=WRDT,    	Ctrl=txt_wrdt 		Param=value			</C>	
		<C>Col=UPID,     	Ctrl=txt_upid 		Param=value			</C>
		<C>Col=UPDT,   	    Ctrl=txt_updt 		Param=value			</C>	
	'>
</object></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




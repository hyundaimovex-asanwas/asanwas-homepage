<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	ȸ�����/��꼭 ����ڰ���
+ ���α׷� ID: A010049.html
+ �� �� �� ��	: ����� ���
+ �� �� �� ��	: ������
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� �� : ���λ� �̸��� ��ȸ, ��� �����ϰ� ��. 	
+ ��   ��  �� :  ������
+ �� �� �� �� : 2012.05.04
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010049_s1 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

<title>��꼭 ����ڰ���</title>

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
//document.domain = "http://erp.hdasan.com"; 
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gclx_cocode.index=2;

	if(gf_empno_Enable(gs_userid,gcds_userid2)){
			sp0.style.display = "";
		}else{
		sp0.style.display = "none"; //����
	}


	ln_Find_Regno();
	ln_Query();
}
/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010049_s2?v_str1=" + gcem_regno.text //����� ��Ϲ�ȣ 
	                                                      +"&v_str2="+gs_userid//
	//prompt("",gcds_data.DataID);
  gcds_data.Reset();
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Add(){
	gcds_data.Addrow();
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

    if(gcds_data.namevalue(gcds_data.rowposition,"SMART_ID")==""){
    	alert("����Ʈ�� ID�� �ʼ� �׸��Դϴ�.");
    	return ;
    }
    
    if(gcds_data.namevalue(gcds_data.rowposition,"SMART_PASSWORD")==""){
    	alert("����Ʈ�� PW�� �ʼ� �׸��Դϴ�.");
    	return ;
    }

    if(gcds_data.namevalue(gcds_data.rowposition,"SMART_EMAIL")==""){
    	alert("����Ʈ�� EMAIL�� �ʼ� �׸��Դϴ�.");
    	return ;
    }

	if (gcds_data.IsUpdated) {
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010049_t1?"
			//prompt('',gcds_data.text);
			gctr_data.post();
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
	gcds_name.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s5?v_str1=2170"
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
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (confirm("�ش� ���� �����Ͻðڽ��ϱ�?")){	
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010049_t1?"
		//prompt('',gcds_data.text);
		gctr_data.post();
	}	
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
/*
function ln_Cert_Reg(){

  if(!ln_Chk()) return;
  
  var v_left = (screen.width-300)/2;
  var v_top  = (screen.height-300)/2;
  //var v_left = screen.availWidth/2 - 300/2; 
  //var v_top  = screen.availHeight/2 - 300/2;            

	
	if(gcds_data.namevalue(1,"CHK")=="T"){        //������ ���
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_s+"&CERT_COMNAME="+gs_comname_s;		
	}else if(gcds_data.namevalue(2,"CHK")=="T"){  //������ ���
		url=gs_url+"/callSB/XXSB_DTI_CERT.asp?CERT_REGNO="+gs_regno_g+"&CERT_COMNAME="+gs_comname_g;	
	}

  window.open(url,"", "status=1, width=300, height=280, left="+v_left+", top="+v_top );
}
*/

/******************************************************************************
	Description : ����� �ڵ�� ����ڵ�Ϲ�ȣ ã�� 
******************************************************************************/
function ln_Find_Regno(){
	if(gclx_cocode.bindcolval=="01"){
		gcem_regno.text =gs_regno_g;
	}else if(gclx_cocode.bindcolval=="02"){
    gcem_regno.text =gs_regno_s;
	}else{
    gcem_regno.text ="";
	}
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Chk(){
	var intcnt = 0; 

  //������ ������ �� �͵� �� �Ȱ��
  for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			intcnt+=1;
		}
	}
	
  if (intcnt==0){
		alert("�ش� ����� ��ȣ�� �����Ͻʽÿ�.");
		return false;
	}else if(intcnt==1){
    return true;
	}else if(intcnt==2){
		alert("����� ��ȣ�� 1�Ǹ� �����Ͻʽÿ�.");
		return false;
	}else{
    alert("��Ÿ");
    return false;
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
</comment><script>__ws__(__NSID__);</script>
<!-- �α��� ��� üũ  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
	<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a010049_t1(I:USER=gcds_data)">
 </object>
 </comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
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
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
	ln_Find_Regno();
  ln_Query();
</script>

<script language="javascript"  for=gcgd_data event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data.countrow;i++) {
			if(i != Row) {
				gcds_data.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>


<script language=JavaScript for=gcgd_data event=OnPopup(row,colid,data)>
  
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	arrSend[0]="H050005";
	strURL = "../../Payroll/jsp/H030003_popup.jsp"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_data.namevalue(row,"FND_USER_NAME") = arrParam[0]; //����
		gcds_data.namevalue(row,"FND_USER") = arrParam[1];  //���
	} else {
		gcds_data.namevalue(row,"FND_USER_NAME") ="";
		gcds_data.namevalue(row,"FND_USER")="";
	}

</script>

<script language=JavaScript for=gcgd_data event=OnCloseUp(row,colid)>

     gs_comname_s = "����ƻ��ֽ�ȸ��(��������)";   //����ƻ��ֽ�ȸ��(���� ����)
     gs_comname_g = "����ƻ��ֽ�ȸ��(��������)";   //����ƻ��ֽ�ȸ��(���� ����)  

	 if(gcds_data.namevalue(row,"FND_REGNO")==gs_regno_s){
			gcds_data.namevalue(row,"FND_REGNO_NAME")=gs_comname_s;
	 }else if(gcds_data.namevalue(row,"FND_REGNO")==gs_regno_g){
            gcds_data.namevalue(row,"FND_REGNO_NAME")=gs_comname_g;
	 }

</script>



<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>
 
<script language="javascript" for=gctr_data event=onsuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
 
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010049_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
<span id=sp0 style="display:none;">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"    style="cursor:hand" onclick="ln_Delete()"> 
			</span>
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onClick="ln_Query()"> 
		</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>�����</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gclx_cocode      classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120>
					<param name=CBData			  value="00^��ü,01^����,02^����">
					<param name=CBDataColumns	value="CODE,NAME">
					<param name=SearchColumn	value=NAME>
					<param name=Sort			      value=false>
					<param name=ListExprFormat	Value="CODE^1^30,NAME^1^90">								
					<param name=BindColumn		  value="CODE">
				</object>
        </comment><script>__ws__(__NSID__);</script>
			</td>
			<td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>����ڵ�Ϲ�ȣ</nobr></td>
			<td width="400px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
			<object id=gcem_regno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:80px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="000-00-00000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=true>
				</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
			</tr>
		</table>
   </td>
	</tr>
	<tr>
	<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_data">
						<PARAM NAME="BorderStyle"   VALUE="0">
						<param name="IndWidth"          value="0">
						<param name="Fillarea"		     VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<param name=SortView        value="Left">
  					<PARAM NAME="Format"			  VALUE="  		
						<C> Name='����ڵ�Ϲ�ȣ'	  ID=FND_REGNO	             HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=center   EditStyle=Combo	Data='2218113834:221-81-13834' </C>
						<C> Name='������'		      ID=FND_REGNO_NAME 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=180	align=left		  BgColor='#C1FFFF'  edit=none </C>
						<C> Name='���'   		          ID=FND_USER 	             HeadAlign=Center HeadBgColor=#B9D4DC Width=60      align=center	  BgColor='#C1FFFF'  edit=none  sort=true</C>
						<C> Name='�����'                 ID=FND_USER_NAME       HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center   EditStyle=PopupFix sort=true </C>
						<C> Name='����Ʈ��ID'           ID=SMART_ID	              HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left	   </C>
						<C> Name='����Ʈ��PW'         ID=SMART_PASSWORD   HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left  	 password=true </C>
						<C> Name='����Ʈ��Email'      ID=SMART_EMAIL 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=220	align=left  	 </C>
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		</table> 
  </td>
	</tr>
	<tr><td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td> </tr>	 
</table>

<!-- <iframe id="eTax_ifrm"  name="eTax_ifrm" style="width:870;height:100px;border:0 solid #708090;" src="../../Account/html/eTax_ifrm.html" frameborder=0 ></iframe>
 --></body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




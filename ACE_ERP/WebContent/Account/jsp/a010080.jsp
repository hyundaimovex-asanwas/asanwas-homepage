<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ����������  
+ ���α׷� ID	: a010080.jsp
+ �� �� �� ��	: ����������   
+ �� �� �� ��	: 2016.03.07 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ �� �� �� ��  : 
+ ��   ��  ��  :  
+ �� �� �� ��  : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010080_s1, a010080_t1
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
	
	
    if(gs_userid="6070001"){
		sp0.style.display = "";
	}else{
		sp0.style.display = "none"; //����
	}
	
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
		
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

    gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010080_s1?v_str1="+gcem_vend_cd_0.text
	                                                                    +"&v_str2="+gcem_vend_nm_0.text         
	                                                                    +"&v_str3="+gcem_vend_id_0.text;   
    //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}
	
	
/******************************************************************************
Description : �߰�
******************************************************************************/
function ln_Add(){
	ln_SetDataHeader();
	gcds_data.addrow();		
	gcds_data.namevalue(gcds_data.rowposition,"USE_TAG")="T";
}
	
/******************************************************************************
Description : ���� 
******************************************************************************/
function ln_Delete(){

	if (confirm(" �ش� �����͸� ���� �Ͻðڽ��ϱ�?")){	
		gcds_data.DeleteMarked();
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010080_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		gctr_pyo.post();
		ln_Query();
	}	

}



/******************************************************************************
Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {

	//���°��� ��� �ϰ�츸 ���� 
	for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
			
				if(gcds_data.namevalue(i,"VEND_CD") == ""){//�ŷ�ó�ڵ�
					alert("�ŷ�ó�ڵ带 �Է��ϼ���.");
					return false;
				}
				
				if(gcds_data.namevalue(i,"VEND_ID") == ""){//����ڵ�Ϲ�ȣ
				alert("��Ϲ�ȣ�� �Է��ϼ���.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VEND_NM")) == ""){//�ŷ�ó��
				alert("�ŷ�ó����  �Է��ϼ���.");
				return false;
			}
			
			
			if(fn_trim(gcds_data.namevalue(i,"MINOR_CD")) == ""){ //�����ȣ				
				alert("��������ڵ带  �Է��ϼ��� .");
				return false;
			}	
			
			
			if(fn_trim(gcds_data.namevalue(i,"POST_NO")) == ""){ //�����ȣ				
				alert("�����ȣ��  �Է��ϼ��� .");
				return false;
			}	
			
					
			if(fn_trim(gcds_data.namevalue(i,"ADDRESS1")) == "" ){ //�ּ�				
				alert("�ּҸ�  �Է��ϼ��� .");
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
function ln_Save(){

	if(!ln_Chk_Save()) return;

	if (gcds_data.IsUpdated ){
		if (confirm("�����Ͻðڽ��ϱ� ?")) {
			gctr_pyo.KeyValue = "Account.a010080_t1(I:USER=gcds_data)";
			gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010080_t1";
            gctr_pyo.Parameters="v_str1="+gusrid;
           	gctr_pyo.post();
		}
	}
}


/******************************************************************************
	Description : Dataset Head ���� -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "CHK:STRING,VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VD_DIRECT:STRING,"
					+ "BSNS_CND:STRING,BSNS_KND:STRING,USE_TAG_1:STRING,"
					+ "VEND_SEQ:DECIMAL,MINOR_CD:STRING,POST_NO:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
					+ "USE_TAG:STRING,CLOSE_DT:STRING,"
					+ "IPT_MAN:STRING,UPT_MAN:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
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

	strURL = "../../Account/jsp/a010047_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
	 	txt_vend_nm.value = arrParam[1];
		txt_vend_cd.value = arrParam[0];
		gcem_vend_id.text = arrParam[2];
	} else {
		txt_vend_nm.value = "";
		txt_vend_cd.value = "";
		gcem_vend_id.text = "";
	} //�ŷ�ó ã��
}

</script>

<!--  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->

<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>

<script>
    /*
    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ְ�, Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
                var strpostcode="";  //���� �����ȣ ( 6�ڸ� )
                var strzonecode="";  //�ű� �����ȣ ( 5�ڸ� )
                strzonecode = data.zonecode;    
                //strpostcode = data.postcode;  
                //strpostcode = strpostcode.substring(0,3)+strpostcode.substring(4,7)
                //document.getElementById('gcem_post').text = strpostcode;
                document.getElementById('gcem_post_no').text = strzonecode;
                
                //document.getElementById('gcem_post_1').text = data.postcode1;
                //document.getElementById('gcem_post_2').text = data.postcode2;
                document.getElementById('txt_address1').value = data.address;

                //��ü �ּҿ��� ���� ���� �� ()�� ���� �ִ� �ΰ������� �����ϰ��� �� ���,
                //�Ʒ��� ���� ���Խ��� ����ص� �ȴ�. ���Խ��� �������� ������ �°� �����ؼ� ��� �����ϴ�.
                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
                //document.getElementById('addr').value = addr;

                document.getElementById('txt_address2').focus();
            }
        }).open();
    }
    */
    
 function openDaumPostcode() {
    	
    var width =500;
    var height =600; 	
    	
    new daum.Postcode({
    	
    	 width:width,
         height:height,
    	
    	
        oncomplete: function(data) {
            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ��Դϴ�.
            // ������ �����Ͽ� �پ��� Ȱ����� Ȯ���� ������.
            
        	 var strpostcode="";  //���� �����ȣ ( 6�ڸ� )
             var strzonecode="";  //�ű� �����ȣ ( 5�ڸ� )
             strzonecode = data.zonecode;    
             document.getElementById('gcem_post_no').text = strzonecode;
             document.getElementById('txt_address1').value = data.address;
             document.getElementById('txt_address2').focus();
        }
    }).open({
    	    left:(window.screen.width/2)-(width/2),
		    top:(window.screen.height/2)-(height/2)
    	
    		});
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
 <comment id="__NSID__"><object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
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

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
   	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
    document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for="gcds_data" event="onloadCompleted(row,colid)" >//�� ��ȸ �Ǽ�
    var icnt=0;
    
   	if(gcds_data.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
		ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_data.RealCount(1,row) + " ��";
	}else {
	  	ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_data.RealCount(1,row) + " ��";
	}
 
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcgd_pyo" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

		if(gcds_data.namevalue(1,"CHK")=="T"){
		  	for(i=1;i<=gcds_data.countrow;i++){
       		 	gcds_data.namevalue(i,"CHK")="F";
		 	}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
       		 	gcds_data.namevalue(i,"CHK")="T";
		 	}
		}
	 }
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

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
   <tr> 
   		<td width="878" align="right"  style="padding-top:4px;" colspan=2>
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand;position:relative;top:-4px;" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand;position:relative;top:-4px;" onclick="ln_Cancel()">
			<span id=sp0 style="display:none;">
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"  style="cursor:hand;position:relative;top:-4px;" onclick="ln_Delete()"> 
			</span>
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:-4px;"onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:-4px;" onclick="ln_Query()">&nbsp;</td>
	   </td>
   </tr>
  
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:878px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center    bgcolor="#eeeeee"   class="tab15" >�˻�����</td>
			<td class="tab18" width="100px;" bgcolor="#eeeeee" align="center">�ŷ�ó�ڵ�</td>
			<td width="90px" class="tab18" align=CENTER><comment id="__NSID__">
				<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:80px" >
					<param name=Text			value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit		value="true">
					<param name=PromptChar		value="_">
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td width="250px" class="tab24" align="left" ><comment id="__NSID__">
				<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:240px" >
					<param name=Text			value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit		value="true">
					<param name=PromptChar		value="_">
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">����ڵ�Ϲ�ȣ</td>
			<td class="tab14" >&nbsp;
			<comment id="__NSID__">
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
			    </object>
			</comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
	</table>
	</td>
	</tr>

	<tr>
	<td colspan=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:876px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:876px;HEIGHT:322px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		    VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="sortview"         value=left>
						 <param name="Editable"     	value='true'>
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"			VALUE="  
					        <FC>ID=CHK 	         Name='����'             Width=28      HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	EditStyle=CheckBox   </C>  
							<FC>ID=VEND_CD,	     Name=�ŷ�ó,		        width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=150,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none, sort = true  MASK='XXX-XX-XXXXX'</FC>
							<FC>ID=MINOR_CD,	 Name=�������,		    width=75,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none, sort = true</FC>						
							<C> ID=ADDRESS1,	 Name=��������ּ�,	    width=300,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		edit=none  sort = true show = true </C>
							<C> ID=VD_DIRECT,	 Name=��ǥ��,	            width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	edit=none  sort = true show = true </C>
							<C> ID=USE_TAG		 Name=�������,			width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit=none, sort = true, EditStyle=Combo, Data='T:���,F:�̻��', show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
					 <fieldset style="position:relative;left:0px;width:878px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
				</td>
			  </tr>
			 </table>
			</td>
		 </tr>
		</table>
  </td>	
  </tr>		
  </table>

  <table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td><b><font size="2" color="blue">[������� �Է�]</font></b></td>
    </tr>
  </table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>�ŷ�ó</td>
		<td width="550px"   class="tab24" colspan=3 >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:-4px;top:-3px;width:70px;height:20px;" readOnly >&nbsp;&nbsp;
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:-8px;top:3px;cursor:hand;" onclick="ln_Find2()">
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:280px;height:20px;" readOnly>&nbsp;&nbsp;
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:3px;width:90px;height:20px;">
				<param name=Text            value="">
				<param name=Alignment	    value=1>
				<param name=Border	        value=True>
				<param name=Format	        value="000-00-00000">
				<param name=PromptChar	    value="_">
				<param name=BackColor       value="#CCCCCC">
				<param name=InheritColor    value=false>
				<param name=ReadOnly        value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		
		<td class="tab24"  width="80px"     bgcolor="#eeeeee" align=center>����� ��ǥ��</td>
		<td class="tab24"  >&nbsp;
			<input id="txt_vd_direct" type="text" class="txtbox"  style= "position:relative;left:-2px;top:0px;width:70px;height:20px;"  >&nbsp;&nbsp;
		</td>
		
		
	</tr>
	<tr> 
		<td class="tab27"  width="80px"     bgcolor="#eeeeee" align=center>��������ڵ�</td>
		<td class="tab19"  width="200px" >&nbsp;
			<comment id="__NSID__">
			<object  id=gcem_minor_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
				style="position:relative;top:3px;left:1px;width:50px;height:20px;">
				<param name=Alignment	  value=0>
				<param name=Border	      value=true>
				<param name=Format	      value="0000">
				<param name=PromptChar	  value="_">
			</object>
			</comment><script>__ws__(__NSID__);</script>&nbsp;
			<font size="2" color="blue">��)0001</font>
		</td>
		
		<td class="tab19"  width="80px"    bgcolor="#eeeeee" align=center>�������</td>
		<td class="tab19"  width="200px" >&nbsp;
			<comment id="__NSID__">
			<object id=gcra_use_tag classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0  style="height:20px;width:120px;" >
				<param name=Cols		value="2">
				<param name=Format	    value="T^���,F^�̻��">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab19"  width="80px"     bgcolor="#eeeeee" align=center>�������</td>
		<td class="tab19"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gcem_close_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
				style="position:relative;top:3px;left:1px;width:70px;height:20px;">
				<param name=Alignment	  value=0>
				<param name=Border	      value=true>
				<param name=Format	      value="YYYY/MM/DD">
				<param name=PromptChar	  value="_">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_close_dt OnClick="__GetCallCalendar('gcem_close_dt', 'Text')" style="position:relative;top:2px;width:20px;left:6px;cursor:hand;">&nbsp;</nobr>
		</td>
	</tr>
	
	<tr> 
		<td class="tab27"  width="80px"     bgcolor="#eeeeee" align=center>��������ּ�</td>
		<td class="tab19"  colspan=5>&nbsp;
		  <comment id="__NSID__">
      		<object id=gcem_post_no classid='clsid:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F' height=20 width=40 align=center class="textbox" >
                   <param name=Text          value="">
                   <param name=Alignment     value=1>     
                   <param name=Format        value="#####">                     
                   <param name=Border        value="true">      
            </object>               
     	    </comment><script>__WS__(__NSID__);</script>&nbsp;
     	    <input type="button" onclick="openDaumPostcode()"  style="position:relative;top:0px;width:100px" value="�����ȣ ã��">&nbsp;
            <input type="text" name='txt_address1'  id="txt_address1" style="position:relative;top:0px;width:300px" >
            <input type="text" name='txt_address2'  id="txt_address2" style="position:relative;top:0px;width:220px" >    
		</td>
	</tr>
</table>


    
<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_data">
<PARAM NAME="BindInfo" VALUE="
	<C>Col=VEND_CD		  Ctrl=txt_vend_cd		Param=value </C>
	<C>Col=VEND_NM		  Ctrl=txt_vend_nm		Param=value </C>
	<C>Col=VEND_ID		  Ctrl=gcem_vend_id	    Param=Text  </C>
	<C>Col=MINOR_CD		  Ctrl=gcem_minor_cd    Param=Text  </C>
	<C>Col=POST_NO		  Ctrl=gcem_post_no     Param=Text  </C>
	<C>Col=ADDRESS1		  Ctrl=txt_address1	    Param=value </C>
	<C>Col=ADDRESS2		  Ctrl=txt_address2	    Param=value </C>
	<C>Col=USE_TAG		  Ctrl=gcra_use_tag	    Param=codevalue  </C>
	<C>Col=CLOSE_DT		  Ctrl=gcem_close_dt	Param=Text  </C>
	<C>Col=VD_DIRECT	  Ctrl=txt_vd_direct	Param=value </C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




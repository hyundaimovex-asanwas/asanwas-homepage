<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ŷ�ó ���� ��� ����
+ ���α׷� ID	: a500020.jsp
+ �� �� �� ��	: �ŷ�ó ���� ��� ����
+ �� �� �� ��	: 2016.12.12
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: �� �� ��
-----------------------------------------------------------------------------
+ �� �� �� ��	: a500020_s1, a500020_t1
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
    
    gclx_status_0.bindcolval ="N";
	
    gcra_usegb_0.codevalue ="1";
  
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	
	
	document.all.LowerFrame.style.visibility="visible";


	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500020_s1?v_str1="+gcem_vendnm.text
    																	+"&v_str2="+gcem_bankcd.text			
	                                                                    +"&v_str3="+gclx_status_0.bindcolval
	                                                                    +"&v_str4="+gcra_usegb_0.codevalue	
    																	+"&v_str5="+gcem_vend_id_0.text	
	 																	+"&v_str6="+txt_acctno.value; 
	 
    //prompt('',gcds_data.DataID);
    
	gcds_data.Reset();
	

	
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Apply(){

	if(!ln_Chk_Status()){
		
		return;
		
	}else if (gcds_data.IsUpdated) {
		
		if (confirm("�ŷ�ó ���¹�ȣ�� ���� �Ͻðڽ��ϱ�?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500020_t1";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
		
		//prompt('',gcds_data.text);
		
		gctr_pyo.post();
		
		ln_Query();
		
		}	
	}
}


/******************************************************************************
	Description : �ݼ�
******************************************************************************/
function ln_SendBack(){
		
	if(!ln_Chk_SendBack_Status())return;
	
	else if (gcds_data.IsUpdated) {
		
		if (confirm("�ŷ�ó ���¹�ȣ�� �ݼ� �Ͻðڽ��ϱ�?")){	
			
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500020_t2";
		
		gctr_pyo.Parameters = "v_str1="+gs_userid;
		
		gctr_pyo.post();
		
		ln_Query();
		
		}	
	}
}



/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/

function ln_Chk_Status(){
		
    var vcnt=0;
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")!="R"){
				
				alert("���� ��� ���� �ƴմϴ�.");
				
				return false;
				
			}else{
				
				gcds_data.namevalue(i,"STATUS")="Y"; 
				
			}
			
			vcnt+=1;
		}
		
	}
	
	if(vcnt==0){
		
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		
		return false;
		
	}
	

  	 // ���� ���¹�ȣ üũ 
  	 for(var p =1; p<=gcds_data.countrow;p++){
  		 
		if(gcds_data.namevalue(p,"CHK")=="T"){
			
			gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a500020_s2?v_str1="+gcds_data.namevalue(p,"VEND_CD")
						                                                          +"&v_str2="+gcds_data.namevalue(p,"ACCT_NO");

			gcds_temp01.Reset();
			
			if(gcds_temp01.namevalue(1,"ACCT_NO")>0){
				
				alert(gcds_data.namevalue(p,"VEND_NM")+"�� �ߺ��� ���� ��ȣ�� �����մϴ�.\n\nȮ���Ͻð� �ٽ� �Է��� �ֽʽÿ�.");
				
				ln_Query();
				
			}
		}
	}

	return true;
}




/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/

function ln_Chk_SendBack_Status(){
		
    var vcnt=0;
    
	for(var i =1; i<=gcds_data.countrow;i++){
		
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"STATUS")!="R"){
				
				alert("�ݼ� ��� ���� �ƴմϴ�.");
				
				return false;
			
			}else if(gcds_data.namevalue(i,"REJECT_REASON") == ""){
				
				alert("�ݼ� ������ �Է��Ͻʽÿ�.");
				
				return false;
				
				
			}else{
				
				gcds_data.namevalue(i,"STATUS")="B"; 
				
			}
			
			vcnt+=1;
			
		}
	}
	
	if(vcnt==0){
		
		alert("���õ� �׸��� ���� ���� �ʽ��ϴ�.");
		
		return false;
		
	}
	
	return true;
}



/******************************************************************************
Description : �˾�
******************************************************************************/
function ln_Find2(){
	
	gcem_vendcd.text = "";
	gcem_vendnm.text = "";
	gcem_bankcd.text = "";
	gcem_banknm.text = "";	
	
	
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	strURL = "../../Account/jsp/a500000_popup2.jsp";
	
	strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:yes";
	
	arrResult = showModalDialog(strURL,'',strPos);
	
		if (arrResult != null) {
			
		arrParam = arrResult.split(";");

		gcem_vendcd.text = arrParam[0];		
		gcem_vendnm.text = arrParam[1];
		gcem_bankcd.text = arrParam[2];
		gcem_banknm.text = arrParam[3];
		
	} else {
		
		gcem_vendcd.text = "";
		gcem_vendnm.text = "";
		gcem_bankcd.text = "";
		gcem_banknm.text = "";
		
	}
		
		ln_Query();

}

/******************************************************************************
Description : �˾�
******************************************************************************/
function ln_Find_Bank(){
	
	gcem_bankcd.text = "";
	gcem_banknm.text = "";	
	
	
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	strURL = "../../Account/jsp/a500000_popup3.jsp";
	
	strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:yes";
	
	arrResult = showModalDialog(strURL,'',strPos);
	
		if (arrResult != null) {
			
		arrParam = arrResult.split(";");

		gcem_bankcd.text = arrParam[0];		
		gcem_banknm.text = arrParam[1];

		
	} else {
		
		gcem_vendcd.text = "";
		gcem_vendnm.text = "";
		gcem_bankcd.text = "";
		gcem_banknm.text = "";
		
	}
		
		ln_Query();	

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
		//alert("��ȸ�� ����Ÿ�� �����ϴ�.");
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
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //���� 
		gcem_vend_id.Format = "000-00-00000";            //���� 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";     //�ֹ� 
		gcem_vend_id.Format = "000000-0000000";        //�ֹ�
	}
	
</script>

<script language=JavaScript for=gclx_status_0 event=OnSelChange()>

	ln_Query();
	
</script>


<script language="javascript" for="gcgd_pyo" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

        //��û�͸� ��ü ���� �ǰ� ��.
        if(gcds_data.namevalue(1,"STATUS")!="R"){
        	
        	alert("���ο�û �Ǹ� ��ü ���� �����մϴ�.");
        	
        	return false;
        	
        }
	
        
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

<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
  <tr> 

    <td width="1000" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:15px;">
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif"	style="cursor:hand" onclick="ln_Apply()" >
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sendbak.gif"	style="cursor:hand" onclick="ln_SendBack()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  
  <tr><td>&nbsp;</td></tr>
    
	<tr>
	 <td>
		<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;" border=0>

		<tr> 

			<td class="tab15" width="80px;" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td width="400px" class="tab24" align="left">
			
			<comment id="__NSID__">
				<object  id=gcem_vendnm 	classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:165px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="�ŷ�ó�� �˻��մϴ�" style="position:relative;left:5px;top:0px;cursor:hand;" onclick="ln_Find2()">
			
			<comment id="__NSID__">			
				<object  id=gcem_vendcd 		classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:10px;width:80px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit			value="true">
				<param name=PromptChar			value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="60px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab14" class="tab24" align="left">
				<comment id="__NSID__">
				<object  id=gcem_banknm 	classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:-20px;width:70px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
				</object></comment><script>__ws__(__NSID__);</script>				
				<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:-20px;top:0px;cursor:hand;" onclick="ln_Find_Bank()">						
				<comment id="__NSID__">			
				<object  id=gcem_bankcd 		classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:-20px;width:70px" onkeydown="if(event.keyCode==13) ln_Query();">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit			value="true">
				<param name=PromptChar			value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td> 	 
			<td class="tab14" width="60px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab14" >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:100px;">
						<param name=CBData			        value="N^���,R^���ο�û,Y^����,B^�ݼ�">
						<param name=CBDataColumns	 		value="CODE,NAME">
						<param name=SearchColumn	     	value=NAME>
						<param name=Sort			        value=false>
						<param name=ListExprFormat       	value="NAME">								
						<param name=BindColumn		     	value="CODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
			</td> 				
		</tr>
		<tr> 
		<td class="tab17" width="100px;" bgcolor="#eeeeee" align="center">��ȣ</td>
		<td width="400px" class="tab11" >
			<comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:200px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format		value="1^����ڹ�ȣ,2^�ֹι�ȣ">
			</object></comment><script>__ws__(__NSID__);</script>

			<comment id="__NSID__">
				<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:0px">		
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
		<td class="tab11" width="80px;" bgcolor="#eeeeee" align="center">���¹�ȣ</td>
		<td class="tab11"><nobr> &nbsp;
				<nobr>
				<input id="txt_acctno"   type="text"   class="txtbox"  style= "position:relative;left:-20px;width:200px;height:20px;">						
				</nobr>
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
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:1000px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:1000px;HEIGHT:400px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  	VALUE="0">
						 <PARAM NAME="Indwidth"			VALUE="0">
						 <PARAM NAME="Fillarea"		    VALUE="true">
						 <PARAM NAME="ColSizing"		VALUE="true">
						 <param name="sortview"         value=left>
						 <param name="Editable"     	value='true'>
						 <param name=UsingOneClick  	value="1">
					     <PARAM NAME="Format"			VALUE="  
					        <FC>ID=CHK 	         Name='����'             Width=28      	HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,		    width=85,	  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
							<FC>ID=VEND_NM,	     Name=�ŷ�ó��,			width=160,	  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
							<FC>ID=SEQ,	     	 Name=����,			    width=50,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=110,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = true mask ='XXX-XX-XXXXX'</FC>
							<C> ID=BANK_CD,		 Name=�ڵ�,				width=60,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true show = false </C>
							<C> ID=BANK_NM,		 Name=��������,	        width=100,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = true </C>
							<C> ID=ACCT_NO,	 	 Name=���¹�ȣ,	        width=110,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	  edit=none  sort = true show = true </C>
							<C> ID=ACCT_AUTH,	 Name=������,	        	width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = true </C>
							<C> ID=FILE, 		 Name=����÷��,			width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,     edit=none  sort = true show = false </C>
						    <C> ID=REASON,       Name=�뵵,	        	width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = false </C>
						    <C> ID=GUBUN,        Name=����,	        	width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = false EditStyle=Combo, Data='1:���뿹��,2:��ȭ���뿹��'</C>
						    <C> ID=STATUS,       Name=����,	        	width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = true EditStyle=Combo, Data='N:���,R:���ο�û,Y:����,B:�ݼ�'</C>
						    <C> ID=REJECT_REASON,Name=�ݼۻ���,	        width=150,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	  edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
					 <fieldset style="position:relative;left:0px;width:1002px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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

  <table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
    <tr height='10px'>
          <td  ><b><font size="2" color="blue">[�ݼۻ��� ���]</font></b></td>
    </tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"    class="tab15"  bgcolor="#eeeeee" align=center>�ŷ�ó</td>
		<td width="350px"  class="tab14"  >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:50px;height:20px;" readOnly >
			<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:180px;height:20px;" readOnly>&nbsp;&nbsp;
			<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:3px;width:90px;height:20px;">
				<param name=Text              	value="">
				<param name=Alignment	    	value=1>
				<param name=Border	        	value=True>
				<param name=Format	        	value="000-00-00000">
				<param name=PromptChar			value="_">
				<param name=BackColor     		value="#CCCCCC">
				<param name=InheritColor    	value=false>
				<param name=ReadOnly      		value=true> 
			</object>
            </comment><script>__ws__(__NSID__);</script></nobr>
		</td>
		<td width="80px"    class="tab14"  bgcolor="#eeeeee" align=center>��������</td>
		<td width="310px"  class="tab14" >&nbsp;
			<comment id="__NSID__">
			<input id="txt_bank_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:100px;height:20px;" readOnly >
			<input id="txt_acct_no" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="50" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr> 
		<td width="80px"    class="tab17"  bgcolor="#eeeeee" align=center>�ݼۻ���</td>
		<td width="350px"  class="tab11" colspan=3 >
			<comment id="__NSID__">
			<input id="txt_reject_reason" type="text" class="txtbox"  style= "position:relative;left:10px;top:0px;width:800px;height:20px;" maxlength="50" >
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>	
</table>
    
<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_data">
<PARAM NAME="BindInfo" VALUE="
	<C>Col=VEND_CD		  Ctrl=txt_vend_cd		    Param=value</C>
	<C>Col=VEND_NM		  Ctrl=txt_vend_nm			Param=value</C>
	<C>Col=VEND_ID		  Ctrl=gcem_vend_id			Param=Text</C>
	<C>Col=BANK_NM		  Ctrl=txt_bank_nm		    Param=value</C>
	<C>Col=ACCT_NO		  Ctrl=txt_acct_no			Param=value</C>	
	<C>Col=REJECT_REASON  Ctrl=txt_reject_reason  	Param=value</C>
	
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ��ü��������  
+ ���α׷� ID	: a010056.jsp
+ �� �� �� ��	: ��ü��������   
+ �� �� �� ��	: 
+ �� �� �� ��	: 
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
+ �� �� �� ��  :  
+ ��   ��  ��  :  
+ �� �� �� ��  : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: a010056_s1, a010056_t1
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
    gclx_status_0.bindcolval ="N"   
    gcra_usegb_0.codevalue="1";
 
  
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
	
	
	gcds_data_md.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010055_s1?v_str1="+gs_userid
																		    +"&v_str2="+gcem_vend_nm_0.text
																		    +"&v_str3="+gcem_vend_id_0.text              	
																		    +"&v_str4="+gcra_usegb_0.codevalue   
																		    +"&v_str5="+gclx_status_0.bindcolval;
    //prompt('',gcds_data_md.DataID);																		    
	gcds_data_md.Reset();
	
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Apply(){

	if(!ln_Chk_Status()){
		return;
	}else if (gcds_data_md.IsUpdated) {
		if (confirm("��ü ����� ���� �Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010056_t1";
		gctr_pyo.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
		//prompt('',gcds_data_md.text);
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
	for(var i =1; i<=gcds_data_md.countrow;i++){
		if(gcds_data_md.namevalue(i,"CHK")=="T"){
			if(gcds_data_md.namevalue(i,"STATUS")!="R"){
				alert("���� ��� ���� �ƴմϴ�.");
				return false;
			}else{
				gcds_data_md.namevalue(i,"STATUS")="Y"; 
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


<%
/******************************************************************************
	Description : üũ  
******************************************************************************/
%>
function ln_Chk(){

/*
   // �ŷ�ó �ڵ� �� ������ üũ 
      for (var i =1; i<=gcds_data_md.countrow;i++){
		if(gcds_data_md.namevalue(i,"VEND_CD")==""){
			alert( i + "���� �ŷ�ó �ڵ带 Ȯ�� �ϼ���");
			return false;
		}
    }
    */
       
	return true;

}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_usegb_format(strusegb){
	if(strusegb=="1"){ //
		gcem_vend_id.Format = "000-00-00000";        //���� 
	}else if(strusegb=="2"){
		gcem_vend_id.Format = "000000-0000000";  //���� 
	}
}




</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data_md classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	<PARAM NAME="KeyValue" VALUE="a010056_t1(I:USER=gcds_data_md)">
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

<script language=JavaScript event="OnLoadError()" for=gcds_data_md>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data_md" event="OnLoadStarted()">
   	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
    document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for="gcds_data_md" event="onloadCompleted(row,colid)" >//�� ��ȸ �Ǽ�
    var icnt=0;

   	if(gcds_data_md.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
		ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_data_md.RealCount(1,row) + " ��";
	}else {
	  	ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_data_md.RealCount(1,row) + " ��";
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
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";     //�ֹ� 
	}
</script>

<script language="javascript" for="gcgd_pyo" event="OnClick(row,colid)">

	if((row==0) && (colid=="CHK")){

        //��û�͸� ��ü ���� �ǰ� ��.
        if(gcds_data_md.namevalue(1,"STATUS")!="R"){
        	alert("���ο�û �Ǹ� ��ü ���� �����մϴ�.");
        	return false;
        }
	
		if(gcds_data_md.namevalue(1,"CHK")=="T"){
		  	for(i=1;i<=gcds_data_md.countrow;i++){
       		 	gcds_data_md.namevalue(i,"CHK")="F";
		 	}
		}else{
			for(i=1;i<=gcds_data_md.countrow;i++){
       		 	gcds_data_md.namevalue(i,"CHK")="T";
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
   
    <td width="878" align="right"  style="padding-top:4px;">
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif"	style="cursor:hand" onclick="ln_Apply()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:878px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px"   class="tab15" align=center  bgcolor="#eeeeee"  rowspan=2 >�˻�����</td>
			<td width="100px;" class="tab18" bgcolor="#eeeeee" align="center">�ŷ�ó��</td>
			<td width="300px"  class="tab18" align="left" ><comment id="__NSID__">
				<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:165px" >
				<param name=Text		    value="">
				<param name=Alignment	    value=0>
				<param name=Border		    value=true>
				<param name=GeneralEdit		value="true">
				<param name=PromptChar		value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="100px;" bgcolor="#eeeeee" align="center">����</td>
			<td class="tab14" width="300px"  align="left" >&nbsp;
			<comment id="__NSID__">
				<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;top:2px;left:0px;font-size:12px;">
						<param name=CBData			     value="N^���,R^���ο�û,Y^�Ϸ�">
						<param name=CBDataColumns	     value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			     value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
				</object>
			
			</comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		<tr> 
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">��ȣ����</td>
		<td class="tab11" width="160px" ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
				<param name=Cols	value="2">
				<param name=Format	value="1^����ڹ�ȣ,2^�ֹι�ȣ">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab11" width="100px;" bgcolor="#eeeeee" align="center">��ȣ</td>
		<td class="tab11"  Style="height:20px;"><nobr>&nbsp;<comment id="__NSID__">
			<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="height:20px;position:relative;left:0px;top:3px">		
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
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:876px;HEIGHT:520px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"			VALUE="gcds_data_md">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="false">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="sortview"     value=left>
						 <param name="Editable"     value='true'>
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"		VALUE="  
					        <FC>ID=CHK,  	     Name=����,		        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  editstyle=checkbox  </FC>    
						    <FC>ID=VEND_CD,	     Name=�ŷ�ó�ڵ�,		    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true </FC>
							<FC>ID=VEND_ID,	     Name=����ڹ�ȣ,		    width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = true  </FC>
							<FC>ID=SEQ,	         Name=����,		        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none, sort = false </FC>
							<G> Name=��������,	 HeadBgColor=#B9D4DC, 
							<C> ID=A_VEND_NM,	 Name=�ŷ�ó��,			width=120,	HeadBgColor=#B9D4DC, BgColor={IF(B_VEND_NM=A_VEND_NM,'FFFFFF','#FFCC66')},     align=left,   edit=none  sort = true</C>
							<C> ID=A_VD_DIRECT,	 Name=��ǥ��,			    width=60,	HeadBgColor=#B9D4DC, BgColor={IF(B_VD_DIRECT=A_VD_DIRECT,'FFFFFF','#FFCC66')}, align=left,	 edit=none  sort = true show = true </C>
							<C> ID=A_POST_NO1,	 Name=����,	            width=50,	HeadBgColor=#B9D4DC, BgColor={IF(B_POST_NO1=A_POST_NO1,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = false show = true </C>
							<C> ID=A_POST_NO2,	 Name=��ȣ,	            width=50,	HeadBgColor=#B9D4DC, BgColor={IF(B_POST_NO2=A_POST_NO2,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = false show = true </C>
							<C> ID=A_ADDRESS1,	 Name=�ּ�,	            width=140,	HeadBgColor=#B9D4DC, BgColor={IF(B_ADDRESS1=A_ADDRESS1,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = true show = true </C>
							<C> ID=A_ADDRESS2,	 Name=���ּ�,	        width=140,	HeadBgColor=#B9D4DC, BgColor={IF(B_ADDRESS2=A_ADDRESS2,'FFFFFF','#FFCC66')},   align=left,	 edit=none  sort = true show = true  </C>
							<C> ID=A_COCOMYN,	 Name=��ü����,	        width=70,	HeadBgColor=#B9D4DC, BgColor={IF(B_COCOMYN=A_COCOMYN,'FFFFFF','#FFCC66')},     align=left,	 edit=none  sort = true show = true  EditStyle=Combo, Data='N:�Ϲݾ�ü,T:���̰�����ü,M:�鼼��ü'</C>
							</G>
							<C> ID=STATUS		 Name=����,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:���,R:���ο�û,Y:�Ϸ�,B:�ݼ�', show = true </C>
			                <C> ID=B_VEND_NM,	 Name=�ŷ�ó��,			width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  show = false </C>
							<C> ID=B_VD_DIRECT,	 Name=��ǥ��,			    width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
							<C> ID=B_POST_NO1,	 Name=����,	            width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
							<C> ID=B_POST_NO2,	 Name=��ȣ,	            width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
							<C> ID=B_ADDRESS1,	 Name=�ּ�,	            width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
							<C> ID=B_ADDRESS2,	 Name=���ּ�,	        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  show = false </C>
							<C> ID=WRID,    	 Name=�ۼ���,	            width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
							<C> ID=WRDT,    	 Name=�ۼ�����,	        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
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

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




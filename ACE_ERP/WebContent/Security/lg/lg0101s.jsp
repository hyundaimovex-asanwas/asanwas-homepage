<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: ��������>��������>��ϰ���>��������ó��
* ���α׷� ID	: lg0101S.jsp
* �� �� �� ��	: ��������ó��
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2016.6.8
-----------------------------------------------------------------------------
* �� �� �� �� : 
* ��   ��  �� :
* �� �� �� �� : 
-----------------------------------------------------------------------------
* �� �� �� ��	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
  String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>��������ó��</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
    fnInit();
    
	gcem_staxdatfr.text = gcurdate;
	
	gcem_staxdatto.text = gcurdate;
	
	fnSelect();
    
}

/******************************************************************************
	Description : �ʱ�ȭ 
****************************************************************************/
function fnInit(){
		

    
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function fnSelect() {

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
														+ ",v_staxdatfr=" + gcem_staxdatfr.text					//��������
														+ ",v_staxdatto=" + gcem_staxdatto.text					//��������														
														+ ",v_access_gb=" + cmbACCESS_GB.value				//�ش�ý���														
														+ ",v_act_gbn=" + cmbACT_GBN.value						//�������
	 													;
	 
	 //alert(param);
	 
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lg0101S",  "JSP(O:DS_DEFAULT=ds_default)",  param);

    tr_post(tr1);

}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   		Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	if(ds_default.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>



 </script>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
	
		<td width="80px;" class="tab25"  bgcolor="#eeeeee" align=center>�Ⱓ</td> 
		<td class="tab24" >&nbsp;
					<comment id="__NSID__">
					<object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					
					&nbsp;~
					
					<comment id="__NSID__">
					<object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	
	
		<td width="150px"   class="tab24" bgcolor="#eeeeee" align=center>�ش�ý���</td>
		<td width="200px" class="tab24"  >&nbsp;
                     <select id=cmbACCESS_GB style="WIDTH:100" >             
                        <option value="">��ü</option>                
                        <option value="HR">�λ�</option>
                        <option value="ZACE">�Ǽ�</option>
                        <option value="SALES">����</option>                  
                    </select>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>�������</td>  
	    <td width="120px" class="tab24">&nbsp;
                     <select id=cmbACT_GBN style="WIDTH:100" >
                        <option value="">��ü</option>                
                        <option value="S">��ȸ</option>
                        <option value="I">�Է�</option>
                        <option value="U">����</option>
                        <option value="D">����</option>
                        <option value="P">�μ�</option>                        
                    </select>
		</td>

	</tr>
</table>

<BR>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:1000px; height:500px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_default">
					<param name="IndWidth"		 		value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 		value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="30">
					<param name="Format"	 	 		value=" 
					<FC> Name='No'		  			ID={currow} 	  			HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=center	</FC>
                    <FC> Name='����'  	          	ID=ACCESS_GB	        HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center   sort=true value={decode(ACCESS_GB, 'HR','�λ�','ZACE','�Ǽ�','SALES','����')}</FC>
					<FC> Name='���α׷�ID'      ID=PROG_NM	          	HeadAlign=Center HeadBgColor=#B9D4DC Width=130 	align=center   sort=true</FC>                    
					<FC> Name='���� ����'         ID=ACT_GBN	          	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center   sort=true value={decode(ACT_GBN, 'S','��ȸ','I','�Է�','U','����','D','����','P','�μ�')}</FC>                    
					<FG> Name='������'  HeadBgColor=#B9D4DC
					<FC> Name='�ҼӺμ�'  	    ID=DPT_NM          		HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	align=center   sort=true </FC>
					<FC> Name='����'  	        	ID=JOB_NM          		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center   sort=true </FC>					
					<FC> Name='����'  	        	ID=ACCESS_NM          	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center   sort=true </FC>
					</FG>
					<C> Name='�����Ͻ�'  	      	ID=ACCESS_TIME         HeadAlign=Center HeadBgColor=#B9D4DC Width=200 	align=center    sort=true </C>
					<C> Name='IP'	      				ID=IPADDRESS 	          	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center    sort=true </C>

					">
			</object></comment><script>__ws__(__NSID__);</script>
			
			<fieldset style="position:relative;left:0px;width:1002px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
			</fieldset>
			
		</td>
	</tr>
</table> 
</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* �� �� �� ��	: �ڿ�>�ڿ�����>��������>�̻���� ��ȸ
* ���α׷� ID	: lc080.jsp
* �� �� �� ��	: �̻���� ��ȸ
* ��  ��   �� : �� �� ��
* �� �� �� �� : 2017.8.10
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
<%@ page import="Ehr.common.util.DateUtil" %>
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
<title>�̻����</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
****************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	
	gcem_yyyymmdd.text = gcurdate.substring(0,7) + "01";
	gcem_yyyymmdd2.text = gcurdate;
	
    fnInit();
    
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

	 	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";

    	ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Lc080",  "JSP(O:DS_DEFAULT=ds_default)",  param);
    
    	tr_post(tr1);

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" 				VALUE="false">
    <Param Name="UseChangeInfo"   			Value="True">
    <Param Name="ViewDeletedRow"  		Value="False">
</object>



</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    		value="toinb_dataid4">
    <param name="ServerIP"   			value="">
    <param name="Action"     			value="">
    <param name="KeyValue"   			value="">
    <param name="Parameters" 			value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnClick(row,colid)>



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
					<object  id=gcem_yyyymmdd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
					
					&nbsp;~
					
					<comment id="__NSID__">
					<object  id=gcem_yyyymmdd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      		value=true>
							<param name=Format	      		value="YYYY/MM/DD">
							<param name=PromptChar	  	value="_">
							<param name=Enable				value="true">
					</object>
					</comment><script>__ws__(__NSID__);</script> 
		</td>	

	</tr>
</table>

<br>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:1000px; height:510px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 		value="ds_default">
					<param name="IndWidth"		 	value='0'>
					<param name="BorderStyle"  		value="0">
					<param name="Fillarea"		 		value="true">
					<param name="Sortview"		 		value="left">
					<param name="ColSizing"	 		value="true">
					<param name="Editable"		 		value="False"> 
					<param name=TitleHeight      		value="30">
                    <param name="SuppressOption"   value="1">						
					<param name="Format"	 	 		value=" 
 					<C> Name='����'		  			ID=HEAD_NM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 		align=center	  </C>
 					<C> Name='��'			  			ID=TEAM_NM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 		align=center	  </C>
 					<C> Name='����'		  			ID=JOB_NM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 		align=center	  </C> 					 										
 					<C> Name='���'		  			ID=ENO_NO  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 		align=center	  </C>
 					<C> Name='����'		  			ID=ENO_NM  		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 		align=center	  </C> 					
                    <C> Name='�̻�� ����'        	ID=START_YMD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=150 		align=center mask ='XXXX-XX-XX' </C> 					
                    <C> Name='�̻�� ����'        	ID=END_YMD 		HeadAlign=Center HeadBgColor=#B9D4DC Width=150 		align=center mask ='XXXX-XX-XX' </C>                    
                 
					">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>

</table> 

</body> 
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ������Ʈ�� ��ȸ �˾�
+ ���α׷� ID	: bud015.jsp
+ �� �� �� ��	: ��ȸ
+ �� �� �� ��	: �� �� ��
------------------------------------------------------------------------------>

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<title>������Ʈ ��ȸ</title>
<jsp:include page="/Pms/common/include/head.jsp"/>  



<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var parentGubun="";
	
	
	
	
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gcgd_disp"), "comn");	//�׸��� ���
	
		fnInit();
		
	}


	
	<%//�ʱ��۾� %>
	function fnInit() {
		
	    		v_job ="I";
	    		
	}
	
	
	
	<%//��ȸ�۾� %>
	function ln_Query(){
		
			v_job="S";
			
		    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
												+ ",v_project=" + project_nm.value	//project�� , �˻�����
												;
		
		    
		
		    ln_TRSetting(tr1, 
				        "<%=dirPath%><%=HDConstant.PATH_BUD%>Bud015",
				        "JSP(O:DS_DEFAULT=ds_default)", //ȭ�� ���. o ->output
				        param);

		    tr_post(tr1);
		    
	}



	function ln_Close(e){
		
		if (e=="A") {
			
			var row = ds_default.rowposition;
			
			window.returnValue = ds_default.namevalue(row,"COST_CD") + ";" 
								+ ds_default.namevalue(row,"PLJ_NM");
			
			//alert(window.returnValue);
			
			window.close();
			
		} else {
			window.close();
			
		}
		
	}
</script>





<!-- classid �����. -->
<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
		    <param name="KeyName"    value="toinb_dataid4"/>
		    <param name="ServerIP"   value=""/>
		    <param name="Action"     value=""/>
		    <param name="KeyValue"   value=""/>
		    <param name="Parameters" value=""/>
</object>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">

</script>


<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	
	document.all.LowerFrame.style.visibility="hidden";
	
	if(ds_default.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">

	ln_Close('A');
	
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:1 solid #708090">

	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">Project</td>
		<td width="110px"><input type="text" class="txt11" id="project_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="<%=dirPath%>/Common/img/btn/com_b_find.gif" alt="Project�� �˻��մϴ�" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<OBJECT classid=<%=HDConstant.MxGrid_CLSID_S%> id=gcgd_disp style="width:360;height:250px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    	<PARAM NAME="DataID"				VALUE="ds_default">
			  	<PARAM NAME="BorderStyle" 			VALUE="0">
			  	<PARAM NAME="Indwidth"				VALUE="0">
				<PARAM NAME="Fillarea"				VALUE="true">
				<param name="sortview"    	 		value=left>
			  	<PARAM NAME="Format"				VALUE="  
						<C>ID=COST_CD,		Name=Code,			width=120,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
						<C>ID=PLJ_NM,		Name=Project,		width=220,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, 	sort = true</C>
						
				">
	    </OBJECT>
		</td>
	</tr>
	
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:360;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	
	<tr><td height="4px"></td></tr>
	
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="<%=dirPath%>/Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="<%=dirPath%>/Common/img/btn/com_b_close.gif" 	style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



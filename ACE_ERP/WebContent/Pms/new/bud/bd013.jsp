<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<title>Item</title>
<jsp:include page="/Pms/common/include/head.jsp"/>  
<style type="text/css"></style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

var parentGubun="";


/******************************************************************************
	Description : 조회
******************************************************************************/
function fnOnLoad(tree_idx){
		
	fnInit_tree(tree_idx);	//트리초기화 호출
	
	cfStyleGrid(getObjectFirst("gcgd_disp"), "comn");	//그리드 출력

	fnInit();
	
}


<%//초기작업 %>
function fnInit() {
	
    	v_job ="I";
    
}



<%//조회작업 %>
function ln_Query(e){
	
		v_job="S";
		
	    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
										+ ",v_item=" + item_nm.value						//검색조건
										;
	
	    ln_TRSetting(tr1, 
	        "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd013",
	        "JSP(O:DS_PCODE_SERCH=ds_pCode_serch)", //화면 출력. o ->output
	        param);
	    
	    //prompt(this, param);
	    //prompt(this, ds_cul);
	    
	    tr_post(tr1);
    
}


/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(e){
		
	if (e=="A") {
		
		var row = ds_pCode_serch.rowposition;
		
		window.returnValue = ds_pCode_serch.namevalue(row,"CD_ITEM") + ";" 
							+ ds_pCode_serch.namevalue(row,"DS_KSITEM");
		
		//alert(window.returnValue);
		
		window.close();
		
	} else {
		
		window.close();
		
	}
	
}
</script>


<script language="javascript" for="tr1" event="OnSuccess()">

</script>


<!-- classid 쓰면됨. -->
<object id=ds_pCode_serch classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
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
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>



<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_pCode_serch" event="OnLoadStarted()">

	
</script>


<script language="javascript" for="ds_pCode_serch" event="onloadCompleted(row,colid)">


</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">

	ln_Close('A');
	
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >


<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:380px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">Item</td>
		<td width="110px"><input type="text" class="txt11" id="item_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="<%=dirPath%>/Common/img/btn/com_b_find.gif" alt="Item Search" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>


<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<OBJECT classid=<%=HDConstant.MxGrid_CLSID_S%> id=gcgd_disp style="width:380;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    		<PARAM NAME="DataID"				VALUE="ds_pCode_serch">
			  		<PARAM NAME="BorderStyle" 			VALUE="0">
			  		<PARAM NAME="Indwidth"				VALUE="0">
					<PARAM NAME="Fillarea"				VALUE="true">
					<param name="sortview"     			value=left>
			  		<PARAM NAME="Format"				VALUE="  
					<C>ID=CD_ITEM,			Name=code,			width=150,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=DS_KSITEM,		Name=item,			width=190,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, 	sort = true</C>
					
				">
	    </OBJECT>
		</td>
	</tr>
	

	
	<tr><td height="4px"></td></tr>
	
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="<%=dirPath%>/Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="<%=dirPath%>/Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<%-- <iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> --%>


</body>
</html>




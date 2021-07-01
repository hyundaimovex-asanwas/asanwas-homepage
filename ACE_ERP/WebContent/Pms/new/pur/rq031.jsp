<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	project /contents / 구매의뢰서 번호    조회 팝업
+ 프로그램 ID	: rq031.jsp
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 김도연
------------------------------------------------------------------------------>

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<title>프로젝트 조회</title>

<jsp:include page="/Pms/common/include/head.jsp"/>  

<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var parentGubun="";
	


	
	<%//초기작업 %>
	function fnInit() {
		
	    	
	    	ln_Query("1");
	    
	}
	
	
	<%//조회작업 %>
	function ln_Query(e){
		
			v_job="S";
			
		    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
										+ ",v_project="  + txt_project.value		//project명 , 검색조건
										+ ",v_contents=" + txt_request.value	//contents , 검색조건
										;
	
		    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq031",
			        "JSP(O:DS_DEFAULT=ds_default)", 
			        param);
		
		    
		    tr_post(tr1);
		    
		    
	}



/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(e){
		
	if (e=="A") {
		
		var row = ds_default.rowposition;
		//값 보냄
		
		window.returnValue = ds_default.namevalue(row,"NO_MA_REQUEST") + ";" //0.no_ma_request
								+ ds_default.namevalue(row,"COST_CD") + ";"  //1.project_code
								+ ds_default.namevalue(row,"PLJ_NM") + ";"   //2.project_name
								+ ds_default.namevalue(row,"DS_MA_REQUEST"); //3.contents
		

		window.close();
		
	} else {
		
		window.close();
		
	}
	
}

</script>




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
	ft_cnt1.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>


<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	
	window.status="조회가 완료 되었습니다.";
	
	document.all.LowerFrame.style.visibility="hidden";
	
	if(ds_default.countrow <=0)
			alert("조회된 데이타가 없습니다.");
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
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="fnInit();">

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:460px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">Project</td>
		<td width="110px">
		<input type="text" class="txt11" id="txt_project" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		
		<td class="tab12" width="80px;" bgcolor="#eeeeee">Contents</td>
		<td width="110px">
		<input type="text" class="txt11" id="txt_request" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		
		
		<td><img src="<%=dirPath%>/Common/img/btn/com_b_find.gif" alt="검색합니다" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>


<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<OBJECT classid=<%=HDConstant.MxGrid_CLSID_S%> id=gcgd_disp style="width:460;height:300px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    		<PARAM NAME="DataID"			VALUE="ds_default">
			  		<PARAM NAME="BorderStyle" 		VALUE="0">
			  		<PARAM NAME="Indwidth"			VALUE="0">
					<PARAM NAME="Fillarea"			VALUE="true">
					<param name="sortview"     		value=left>
			  		<PARAM NAME="Format"			VALUE="  
					<C>ID=NO_MA_REQUEST,		Name=구매의뢰서 번호,		width=100,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true mask='XXXXXXXX-XXXX'</C>
					<C>ID=PLJ_NM,				Name=프로젝트,				width=150,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=COST_CD,				Name=ProjectCode,			width=190,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true show=false</C>
					<C>ID=DS_MA_REQUEST,		Name=Contents,				width=190,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					
				">
	    </OBJECT>
		</td>
	</tr>
	
	
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:460;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	
	
	<tr><td height="4px"></td></tr>
	
	
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="<%=dirPath%>/Common/img/btn/com_b_select.gif" 	style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="<%=dirPath%>/Common/img/btn/com_b_close.gif" 		style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>



</body>
</html>







<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	회계관리/기준정보관리
+ 프로그램 ID	: A010010.html
+ 기 능 정 의	: 조회권한관리
+ 최 초 이 력	: 정영식
+ 변 경 이 력	:  
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010010_s1 , 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>조회권한관리</title>

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
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcra_useyn.codevalue="Y";

  //모든 부서 조회
	ln_Before();
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Before(){
 /*
	gcds_dept.DataID = "/services/servlet/Account.hcdept_s1?"
  gcds_dept.Reset();

	prompt('',gcds_dept.DataID);
	*/
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1="+gcem_empnm.text
																		+"&v_str2="+fn_trim(gcem_empno.text)
																		+"&v_str="
																		+"&v_str4="+gcra_useyn.codevalue;

  gcds_data.Reset();
}


/******************************************************************************
	Description :저장전 체크
******************************************************************************/
function ln_Chk_Save(){


	return true;
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	
	if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_t1";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data.text);
			gctr_data.post();
		}	
	}
}


/******************************************************************************
	Description : 등록(신규)
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();
    gcds_data.namevalue(gcds_data.rowposition,"USEYN")="Y";
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_data.KeyValue = "Account.A010010_t1(I:USER=gcds_data)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_t1";
		gctr_data.post();
	} else gcds_data.undo(gcds_data.rowposition);
}


/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- <object id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
 -->
 </comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
<PARAM NAME="KeyValue" VALUE="A010010_t1(I:USER=gcds_data)">
</object>
</comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
	//ln_Find_Regno();
  //ln_Query(gcem_regno.text);
</script>

<script language="javascript"  for=gcgd_data event="OnClick(Row,Colid)">
  /*
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data.countrow;i++) {
			if(i != Row) {
				gcds_data.namevalue(i,"CHK") = "F";
			}
		}
	}
	*/
</script>

<script language=JavaScript for=gcgd_data event=OnPopup(row,colid,data)>
	var result="";
	var arrSend	= new Array();
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(colid=="RPGMID"){	
		//arrSend[0]="VAT";
		strURL = "./commdtil_popup_menu.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_data.namevalue(row,"PGMID")  = arrParam[0]; 
			gcds_data.namevalue(row,"PGMNM")  = arrParam[1];
			gcds_data.namevalue(row,"RPGMID")	= arrParam[2];
		} else {
      //키 값이기 때문에 필수항목
		}
	}else if(colid=="EMPNO"){

		arrSend[0]="H050005";
		strURL = "../../Payroll/jsp/H030003_popup.jsp"
		strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_data.namevalue(row,"EMPNMK")= arrParam[0]; //성명
			gcds_data.namevalue(row,"EMPNO") = arrParam[1]; //사번
		} else {
			gcds_data.namevalue(row,"EMPNMK") ="";
			gcds_data.namevalue(row,"EMPNO")="";
		}

  }else if(colid=="PEMPNO1"||colid=="PEMPNO2"||colid=="PEMPNO3"||colid=="PEMPNO4"||colid=="PEMPNO5"){
		//arrSend[0]="H050005";
		strURL = "./empno_popup.jsp"
		strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_data.namevalue(row,colid) = arrParam[1]; //사번
		}else{
	
		}
	}else{ //부서
    arrSend[0]="0002";
    arrSend[1]="";
	  arrSend[2]="A";
		arrSend[3]="";
		//arrParam[4]=gclx_fdcode02.bindcolval;	
		strURL = "./hcdept_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrSend,strPos);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_data.namevalue(row,colid)=arrParam[0]; //부서코드
			//gcds_data.namevalue(row,"EMPNO") = arrParam[1]; //사번
		} else {
			//gcds_data.namevalue(row,"EMPNMK") ="";
			//gcds_data.namevalue(row,"EMPNO")="";
		}
	}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
		alert("Transaction Success!!");
	</script>
	<script language=JavaScript for=gctr_data event=OnFail()>
		alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
	</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010010_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Cancel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"  style="cursor:hand" onclick="ln_Delete()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>성명</nobr></td>
			<td width="150px" class="tab18"><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_empnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:80px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=GeneralEdit   value="true">
				</object>
        </comment><script>__ws__(__NSID__);</script>
			</td>
			<td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>사번</nobr></td>
			<td width="200px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
				<object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:60px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="0000000">
					<param name=BackColor     value="#CCCCCC">
				</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>

      <td width="100px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>사용유무</nobr></td>
			<td width="200px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
				<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="left:-30px;top:0px;height:22;width:120;cursor:hand;" class="txtbox">
						<param name=Cols     value="2">
						<param name=Format   value="Y^사용,N^미사용">
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
						<param name="IndWidth"      value="0">
						<param name="Fillarea"		  VALUE="true">
						<param name="ColSizing"     value="true">
						<param name="editable"      value="true">
						<param name=SortView        value="Left">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='화면'	    ID=RPGMID   HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left   sort=true EditStyle=Popup </FC> 
                        <FC> Name='화면명'    ID=PGMNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left   sort=true edit=none </FC>
						<FC> Name='사번'	    ID=EMPNO	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center sort=true EditStyle=Popup </FC>
						<FC> Name='성명'	    ID=EMPNMK   HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=left   sort=true edit=none </FC>
						<FC> Name='사용'		ID=USEYN  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center sort=true EditStyle=Combo Data='Y:사용,N:미사용' </FC>
						<FC> Name='그룹'		ID=AUTHGR   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left	  sort=true EditStyle=Combo Data='A:회계관리자,B:일반관리자,C:사용자'</FC>
						<C> Name='부서1'		ID=DEPTCD1 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
                        <C> Name='부서2'		ID=DEPTCD2 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서3'		ID=DEPTCD3 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서4'		ID=DEPTCD4 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서5'		ID=DEPTCD5 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서6'		ID=DEPTCD6 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서7'		ID=DEPTCD7 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서8'		ID=DEPTCD8 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서9'		ID=DEPTCD9 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서10'	ID=DEPTCD10	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서11'	ID=DEPTCD11	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서12'	ID=DEPTCD12	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서13'	ID=DEPTCD13	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서14'	ID=DEPTCD14	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서15'	ID=DEPTCD15	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서16'	ID=DEPTCD16	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서17'	ID=DEPTCD17	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서18'	ID=DEPTCD18	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서19'	ID=DEPTCD19	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='부서20'	ID=DEPTCD20	HeadAlign=Center HeadBgColor=#B9D4DC Width=45  align=left	  EditStyle=Popup </C>
						<C> Name='사번1'		ID=PEMPNO1 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=left	  EditStyle=Popup </C>
						<C> Name='사번2'		ID=PEMPNO2 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=left	  EditStyle=Popup </C>
						<C> Name='사번3'		ID=PEMPNO3 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=left	  EditStyle=Popup </C>
						<C> Name='사번4'		ID=PEMPNO4 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=left	  EditStyle=Popup </C>
						<C> Name='사번5'		ID=PEMPNO5 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=left	  EditStyle=Popup </C>				
						<C> Name='화면'	    ID=PGMID    HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left 	  edit=none </C> 
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			</td>
		</tr>
		</table> 
  </td>
	</tr>
	<tr><td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td> </tr>	 
</table>

<!-- <iframe id="eTax_ifrm"  name="eTax_ifrm" style="width:870;height:100px;border:0 solid #708090;" src="../../Account/html/eTax_ifrm.html" frameborder=0 ></iframe>
 --></body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




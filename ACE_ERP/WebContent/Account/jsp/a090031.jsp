<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산대장
+ 프로그램 ID	: A090031.html
+ 기 능 정 의	: 자산대장 조회 화면
+ 작  성   자 : 정 영 식
+ 작 성 일 자 : 2011.06.27
-----------------------------------------------------------------------------
+ 수 정 내 용 : 비고 컬럼 추가
+ 수   정  자 : 이 동 훈
+ 수 정 일 자 : 2019.06.12
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090031_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자산대장</title>

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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//소속코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//자산분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	gclx_fdcode.bindcolval = gs_fdcode;
	gcrd_gubun.codevalue=1;
	gclx_sys_fr.index=0; //상태구분
 }

/******************************************************************************
	Description : 최종상각년월찾기
****************************************************************************/
/**
 function ln_Find_ym(){
	gcds_astym.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s2"
									+ "?v_str1="+gclx_fdcode.BindColVal    //지점
	gcds_astym.Reset();
 }
 **/

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  	//ln_Find_ym();
   	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090031_s1"
									  	+ "?v_str1="+gclx_fdcode.BindColVal             //지점
										+ "&v_str2="+gclx_asdivcod.BindColVal           //자산분류
										+ "&v_str3="+gcem_jasan.text                    //자산명코드									
										+ "&v_str4="+gcrd_gubun.codevalue               //구분 
										+ "&v_str5="+gclx_sys_fr.bindcolval             //상태  
										+ "&v_str6="+txt_COSTCD.value;                  //원가코드
	//prompt('', gcds_code01.DataID);				
	gcds_code01.Reset();
}


/******************************************************************************
	Description : 자산명 팝업
******************************************************************************/
function ln_Popup3(e){

	if(e=='01'){           //자산명 팝업창
		
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;

		arrParam[0]=gclx_asdivcod.bindcolval;
		
		//strURL = "./Atcode_popup_1.jsp";
    	strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_jasan.value = arrParam[1];  //자산명
			gcem_jasan.text = arrParam[0];  //자산코드
		} else {
			gcem_jasan.text = "";
			txt_jasan.value = "";
		}
		
	}
	
}


/******************************************************************************
	Description : 원가 팝업
	Parameter   : srow - grid의 row, strgb - 01: grid,  02:검색조건
******************************************************************************/
function ln_Popup4(srow,strgb){

  	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="0030";//원가코드
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

  	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

 	if(strgb=="02"){
 		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_COSTCD.value = ln_Trim(arrParam[0]);
				txt_COSTNM.value = ln_Trim(arrParam[1]); 
			}else{
				txt_COSTCD.value = "";	
				txt_COSTNM.value = "";
			}
			
	}
 	
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("자산대장","",2);
}

/******************************************************************************
	Description : 출력 
******************************************************************************/
function ln_Print(){
		
	gcds_report00.ClearAll();
	
	ln_SetDataHeader();
	
  	gcds_report00.Addrow();

  	if(gcds_code01.namevalue(1,"FDCODE")=="02"){
		gcds_report00.namevalue(gcds_report00.rowposition,"FDCODE") = "[서울]";
	}else if(gcds_code01.namevalue(1,"FDCODE")=="03"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"FDCODE") = "[금강산]";
	}else if(gcds_code01.namevalue(1,"FDCODE")=="04"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"FDCODE") = "[개성]";
	}


  	if(gcds_code01.namevalue(1,"AST2ND")=="11"){
		gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "토지";
	}else if(gcds_code01.namevalue(1,"AST2ND")=="12"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "건물";
	}else if(gcds_code01.namevalue(1,"AST2ND")=="13"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "구축물";
	}else if(gcds_code01.namevalue(1,"AST2ND")=="14"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "차량운반구";
	}else if(gcds_code01.namevalue(1,"AST2ND")=="15"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "기계장치";
	}else if(gcds_code01.namevalue(1,"AST2ND")=="16"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "공기구비품";
	}else if(gcds_code01.namevalue(1,"AST2ND")=="17"){
    	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "기타유형자산";
  }

  	gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN")+" "+gcds_report00.namevalue(gcds_report00.rowposition,"FDCODE");
   
	gcds_report00.namevalue(gcds_report00.rowposition,"TITLE") = "자 산 대 장";
	
  	gcds_report00.namevalue(gcds_report00.rowposition,"USEDATE") = gs_date;


	if(gcds_code01.namevalue(1,"AST2ND")=="11"||gcds_code01.namevalue(1,"AST2ND")=="12"||gcds_code01.namevalue(1,"AST2ND")=="13"){
    	gcrp_print3.preview();		//토지/건물/구축물
	}else if(gcds_code01.namevalue(1,"AST2ND")=="14"){
		gcrp_print2.preview();		//차량운반구
	}else if(gcds_code01.namevalue(1,"AST2ND")=="15"||gcds_code01.namevalue(1,"AST2ND")=="16"||gcds_code01.namevalue(1,"AST2ND")=="17"){
		gcrp_print1.preview();			//기계장치/공기구비품/기타유형자산
	}
  
}


/******************************************************************************
	Description : 출력 DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_report00.countrow<1){
		var s_temp = "TITLE:STRING(100),ASTGUBUN:STRING(10),FDCODE:STRING(255),USERID:STRING(10),USRNAME:STRING(10),USEDATE:STRING(10)";
		gcds_report00.SetDataHeader(s_temp);
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!-- 지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 자산분류 -->
<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>

<!-- 상각최종년월찾기 -->
<object  id="gcds_astym" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object>

<!-- Report Head -->
<object  id=gcds_report00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

//	gcgd_disp01.Editable =true;

	if(gcds_code01.countrow<=0)
		alert("조회된 데이타가 없습니다.");
</script>


<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.index=0;
</script>

<!-- 자산분류 (검색)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="전체";
	gclx_asdivcod.index=0;
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>
	/**
	//document.all.LowerFrame.style.visibility="visible";
	
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	if(row<1) return;
	ln_Find_ym();
  var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_astym.namevalue(1,"ASTFYM");     //당기 01월
	arrParam[1] = gcds_astym.namevalue(1,"ASTLYM");     //감가상각 최종년월
	arrParam[2] = gcds_code01.namevalue(row,"RCOSTCD"); //원가코드 
	arrParam[3] = gcds_code01.namevalue(row,"COSTNM");  //원가명 
	arrParam[4] = gcds_code01.namevalue(row,"FDCODE");  //지점 
	arrParam[5] = gcds_code01.namevalue(row,"AST2ND");  //중분류 
	var strURL = "./A090030_popup.jsp";
	var strPos = "dialogWidth:702px;dialogHeight:560px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	***/
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-- 그리드 선택일괄 체크 이벤트 -->

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090031_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_excel.gif"	 style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_print.gif"	  style="cursor:hand" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat		value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> 자산분류</td>  
	  <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat		value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>자산명</td> 
		<td class="tab24" >&nbsp;
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-2px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup3(01)">
			<comment id="__NSID__">
			<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:50px">
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=Format				value="#######">
				<param name=PromptChar			value="_">
				<param name=Enable				value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
	
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >구분</td>
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:100">
					<param name=Cols	  	value="2">
					<param name=Format		value="1^원화,2^외화">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> 상태</td>  
	  <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
				<OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
					<param name=CBData					value="^전체,0^정상,1^매각,2^폐기,8^이체">
					<param name=CBDataColumns			value="Code, Parm">
					<param name=SearchColumn			value="Parm">
					<param name=Sort					value="false">
					<param name=ListExprFormat			value="Parm^0^120">
					<param name=BindColumn				value="Code">
					<param name=XPStyle         		value=true>
				</OBJECT></comment><script>__ws__(__NSID__);</script> 						
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>원가명</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
</table>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>&nbsp;
		</td>
	</tr>
</table>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:1000px; height:500px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="False"> 
					<param name=TitleHeight   	value="30">
					<param name=ViewSummary   	value="1">
					<param name="Format"		value=" 
					<FC> Name='자산\\분류'			ID=AST2NDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	 SumBgColor=#C3D0DB sumtext=''   sort=true </FC>
					<FC> Name='자산\\번호'			ID=ASTNBR		HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=center SumBgColor=#C3D0DB sumtext=''   sort=true  </FC>
					<FC> Name='자산명'				ID=ASTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 SumBgColor=#C3D0DB sumtext='계' sort=true  SumTextAlign=center </FC>
					<C> Name='취득\\일자'			ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center SumBgColor=#C3D0DB sumtext=''   sort=true  MASK='XXXX/XX/XX'</C>
					<C> Name='수량'			    	ID=ASTQTY		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center SumBgColor=#C3D0DB sumtext=''   sort=true  </C>
					<C> Name='취득금액'				ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					<C> Name='전기누계액'	        ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					<C> Name='당기상각액'	        ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					<C> Name='잔존가액'				ID=ASTRMAMT	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 Value={ASTAQAMT-(ABDEPRAMT+ACDEPRAMT)}   SumBgColor=#C3D0DB sumtext={sum(ASTAQAMT-(ABDEPRAMT+ACDEPRAMT))} sort=true  </C>
					<C> Name='보관장소'				ID=USELOC		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='원가명'				ID=COSTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='상태'		    		ID=ASTSTATNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='사용자'		    	ID=ASTUSER	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center SumBgColor=#C3D0DB sumtext=''   sort=true show=false</C>
					<C> Name='사용자'		    	ID=EMPNMK	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center SumBgColor=#C3D0DB sumtext=''   sort=true </C>
					<C> Name='비고'		    		ID=ASTNOTE	    HeadAlign=Center HeadBgColor=#B9D4DC Width=300 	align=left SumBgColor=#C3D0DB sumtext=''   	 sort=true </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:1002px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>
<!-- 기계장치/공기구비품/기타유형자산 -->
<comment id="__NSID__"><OBJECT id=gcrp_print1  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_report00">
	<param name="DetailDataID"      		value="gcds_code01"> 
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag				value=false>
	<param name="SaveToFileShowButton"		value="true">		
<!-- 	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'> -->
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='TITLE', left=29, top=5, right=4051, bottom=169, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=167 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=34 ,top=98 ,right=4080 ,bottom=98 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=34 ,top=164 ,right=4080 ,bottom=164 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='USEDATE', left=3844, top=45, right=4048, bottom=93 ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성일자:' ,left=3672 ,top=45 ,right=3842 ,bottom=93 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순' ,left=34 ,top=106 ,right=106 ,bottom=156 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산명' ,left=307 ,top=106 ,right=1008 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득일자' ,left=1021 ,top=106 ,right=1193 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용연수' ,left=1207 ,top=106 ,right=1347 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득금액' ,left=1352 ,top=106 ,right=1601 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전기누계액' ,left=1609 ,top=106 ,right=1857 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당기상각액' ,left=1865 ,top=106 ,right=2119 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='잔존가액' ,left=2127 ,top=106 ,right=2376 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득구분' ,left=3276 ,top=106 ,right=3434 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산번호' ,left=119 ,top=106 ,right=294 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원가명' ,left=3448 ,top=106 ,right=4048 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='보관장소' ,left=2863 ,top=106 ,right=3262 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용부서' ,left=2389 ,top=106 ,right=2850 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=98 ,right=299 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1013 ,top=98 ,right=1013 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1603 ,top=98 ,right=1603 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=98 ,right=2122 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3440 ,top=101 ,right=3440 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3268 ,top=101 ,right=3268 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2855 ,top=98 ,right=2855 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=98 ,right=1863 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=111 ,top=98 ,right=111 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2381 ,top=101 ,right=2381 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1201 ,top=101 ,right=1201 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=98 ,right=1347 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTGUBUN', left=40, top=40, right=1683, bottom=87, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=56 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='ASTNBR', left=119, top=0, right=294, bottom=48 ,mask='XXX-XXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTNM', left=307, top=0, right=1008, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTAQAMT', left=1355, top=0, right=1603, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ABDEPRAMT', left=1611, top=0, right=1860, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACDEPRAMT', left=1868, top=0, right=2122, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTRMAMT', left=2130, top=0, right=2379, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=2389, top=0, right=2850, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='USELOC', left=2863, top=0, right=3262, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=34 ,top=50 ,right=4080 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=34, top=0, right=106, bottom=45, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTYUSE', left=1212, top=0, right=1339, bottom=48, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASAQSNM', left=3276, top=0, right=3434, bottom=48, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COSTNM', left=3448, top=0, right=4048, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=111 ,top=3 ,right=111 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=299 ,top=3 ,right=299 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1013 ,top=3 ,right=1013 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1201 ,top=3 ,right=1201 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=3 ,right=1863 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=3 ,right=2122 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2381 ,top=3 ,right=2381 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2855 ,top=3 ,right=2855 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3268 ,top=3 ,right=3268 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3440 ,top=3 ,right=3440 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASAQSDAT', left=1019, top=0, right=1201, bottom=48, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1603 ,top=3 ,right=1603 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=0 ,right=1347 ,bottom=45 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=4101 ,bottom=58 ,face='Tahoma' ,size=10 ,penwidth=1
	<S>id='{Sum(ASTRMAMT)}' ,left=2130 ,top=5 ,right=2379 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ACDEPRAMT)}' ,left=1865 ,top=5 ,right=2119 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ABDEPRAMT)}' ,left=1609 ,top=5 ,right=1857 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ASTAQAMT)}' ,left=1352 ,top=5 ,right=1601 ,bottom=50 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<T>id='합    계' ,left=397 ,top=5 ,right=995 ,bottom=50 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1603 ,top=5 ,right=1603 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=5 ,right=1863 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=5 ,right=2122 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2381 ,top=5 ,right=2381 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=5 ,right=1347 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=40 ,top=56 ,right=4085 ,bottom=56 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=40 ,top=0 ,right=4085 ,bottom=0 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2743 ,right=4101 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=40 ,top=5 ,right=4085 ,bottom=5 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<I>id='../../common/img/icon.jpg' ,left=3556 ,top=19 ,right=4048 ,bottom=116</I>
	<T>id='Page   :  #p of #t' ,left=1913 ,top=42 ,right=2220 ,bottom=90 ,align='left' ,face='Arial' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
</B>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	


<!-- 차량운반구 -->
<comment id="__NSID__"><OBJECT id=gcrp_print2  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_report00">
	<param name="DetailDataID"      		value="gcds_code01"> 
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag				value=false>
	<param name="SaveToFileShowButton"		value="true">		
<!-- 	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'> -->
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='TITLE', left=29, top=5, right=4051, bottom=169, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=167 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=34 ,top=98 ,right=4080 ,bottom=98 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=34 ,top=164 ,right=4080 ,bottom=164 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='USEDATE', left=3844, top=45, right=4048, bottom=93 ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성일자:' ,left=3672 ,top=45 ,right=3842 ,bottom=93 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순' ,left=34 ,top=106 ,right=106 ,bottom=156 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산명' ,left=307 ,top=106 ,right=1008 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득일자' ,left=1021 ,top=106 ,right=1193 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용연수' ,left=1207 ,top=106 ,right=1347 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득금액' ,left=1352 ,top=106 ,right=1601 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전기누계액' ,left=1609 ,top=106 ,right=1857 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당기상각액' ,left=1865 ,top=106 ,right=2119 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='잔존가액' ,left=2127 ,top=106 ,right=2376 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득구분' ,left=3276 ,top=106 ,right=3434 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산번호' ,left=119 ,top=106 ,right=294 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='원가명' ,left=3448 ,top=106 ,right=4048 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차대번호' ,left=2863 ,top=106 ,right=3262 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차량번호' ,left=2389 ,top=106 ,right=2850 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=98 ,right=299 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1013 ,top=98 ,right=1013 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1603 ,top=98 ,right=1603 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=98 ,right=2122 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3440 ,top=101 ,right=3440 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3268 ,top=101 ,right=3268 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2855 ,top=98 ,right=2855 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=98 ,right=1863 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=111 ,top=98 ,right=111 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2381 ,top=101 ,right=2381 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1201 ,top=101 ,right=1201 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=98 ,right=1347 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTGUBUN', left=40, top=40, right=1683, bottom=87, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=56 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='ASTNBR', left=119, top=0, right=294, bottom=48 ,mask='XXX-XXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTNM', left=307, top=0, right=1008, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTAQAMT', left=1355, top=0, right=1603, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ABDEPRAMT', left=1611, top=0, right=1860, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACDEPRAMT', left=1868, top=0, right=2122, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTRMAMT', left=2130, top=0, right=2379, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACARNO', left=2389, top=0, right=2850, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACARDRVID', left=2863, top=0, right=3262, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=34 ,top=50 ,right=4080 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=34, top=0, right=106, bottom=45, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTYUSE', left=1212, top=0, right=1339, bottom=48, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASAQSNM', left=3276, top=0, right=3434, bottom=48, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COSTNM', left=3448, top=0, right=4048, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=111 ,top=3 ,right=111 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=299 ,top=3 ,right=299 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1013 ,top=3 ,right=1013 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1201 ,top=3 ,right=1201 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=3 ,right=1863 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=3 ,right=2122 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2381 ,top=3 ,right=2381 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2855 ,top=3 ,right=2855 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3268 ,top=3 ,right=3268 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3440 ,top=3 ,right=3440 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASAQSDAT', left=1019, top=0, right=1201, bottom=48, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1603 ,top=3 ,right=1603 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=0 ,right=1347 ,bottom=45 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=4101 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=1603 ,top=5 ,right=1603 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=5 ,right=1863 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=5 ,right=2122 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2381 ,top=5 ,right=2381 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=5 ,right=1347 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=40 ,top=58 ,right=4085 ,bottom=58 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='합    계' ,left=397 ,top=8 ,right=995 ,bottom=53 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(ASTAQAMT)}' ,left=1352 ,top=8 ,right=1601 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ABDEPRAMT)}' ,left=1609 ,top=8 ,right=1857 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ACDEPRAMT)}' ,left=1865 ,top=8 ,right=2119 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ASTRMAMT)}' ,left=2130 ,top=8 ,right=2379 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=40 ,top=3 ,right=4085 ,bottom=3 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2743 ,right=4101 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=40 ,top=5 ,right=4085 ,bottom=5 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<I>id='../../common/img/icon.jpg' ,left=3556 ,top=19 ,right=4048 ,bottom=116</I>
	<T>id='Page   :  #p of #t' ,left=1913 ,top=42 ,right=2220 ,bottom=90 ,align='left' ,face='Arial' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
</B>


	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

<!-- 토지/건물/구축물 -->
<comment id="__NSID__"><OBJECT id=gcrp_print3  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_report00">
	<param name="DetailDataID"      		value="gcds_code01"> 
	<PARAM NAME="PaperSize"					VALUE="A3">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag				value=false>
	<param name="SaveToFileShowButton"		value="true">		
<!-- 	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'> -->
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=4101 ,bottom=170 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='TITLE', left=29, top=5, right=4051, bottom=169, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=4101 ,bottom=164 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=34 ,top=98 ,right=4080 ,bottom=98 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=34 ,top=164 ,right=4080 ,bottom=164 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='USEDATE', left=3844, top=45, right=4048, bottom=93 ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성일자:' ,left=3672 ,top=45 ,right=3842 ,bottom=93 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='순' ,left=34 ,top=106 ,right=106 ,bottom=156 ,face='Arial' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산명' ,left=307 ,top=106 ,right=1008 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득일자' ,left=1021 ,top=106 ,right=1193 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용연수' ,left=1207 ,top=106 ,right=1347 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득금액' ,left=1352 ,top=106 ,right=1601 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전기누계액' ,left=1609 ,top=106 ,right=1857 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당기상각액' ,left=1865 ,top=106 ,right=2119 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산번호' ,left=119 ,top=106 ,right=294 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=299 ,top=98 ,right=299 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1013 ,top=98 ,right=1013 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1603 ,top=98 ,right=1603 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=98 ,right=2122 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3297 ,top=101 ,right=3297 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=98 ,right=1863 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=111 ,top=98 ,right=111 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2394 ,top=101 ,right=2394 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1201 ,top=101 ,right=1201 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=98 ,right=1347 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTGUBUN', left=40, top=40, right=1683, bottom=87, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='잔존가액' ,left=2405 ,top=106 ,right=2654 ,bottom=156 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='손상차손누계액' ,left=2127 ,top=103 ,right=2387 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='면적(㎡)' ,left=2672 ,top=103 ,right=2971 ,bottom=153 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='면적(평)' ,left=2992 ,top=106 ,right=3291 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2979 ,top=98 ,right=2979 ,bottom=161 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='원가명' ,left=3307 ,top=106 ,right=4048 ,bottom=156 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2659 ,top=101 ,right=2659 ,bottom=164 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=4101 ,bottom=55 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='ASTNBR', left=119, top=0, right=294, bottom=48 ,mask='XXX-XXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTNM', left=307, top=0, right=1008, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTAQAMT', left=1355, top=0, right=1603, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ABDEPRAMT', left=1611, top=0, right=1860, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACDEPRAMT', left=1868, top=0, right=2122, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=34 ,top=50 ,right=4080 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=34, top=0, right=106, bottom=45, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTYUSE', left=1212, top=0, right=1339, bottom=48, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=111 ,top=3 ,right=111 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=299 ,top=3 ,right=299 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1013 ,top=3 ,right=1013 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1201 ,top=3 ,right=1201 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=3 ,right=1863 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=3 ,right=2122 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASAQSDAT', left=1019, top=0, right=1201, bottom=48, align='left' ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1603 ,top=3 ,right=1603 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=0 ,right=1347 ,bottom=45 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTRMAMT', left=2402, top=0, right=2651, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REDUAMT', left=2127, top=0, right=2387, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2659 ,top=3 ,right=2659 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTSIZE', left=2670, top=0, right=2969, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2979 ,top=3 ,right=2979 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=3297 ,top=3 ,right=3297 ,bottom=48 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='COSTNM', left=3307, top=0, right=4048, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2394 ,top=11 ,right=2394 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTPYUNG', left=2992, top=0, right=3291, bottom=48, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=4101 ,bottom=66 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=1603 ,top=5 ,right=1603 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1863 ,top=5 ,right=1863 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=5 ,right=2122 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1347 ,top=5 ,right=1347 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=40 ,top=58 ,right=4085 ,bottom=58 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='합    계' ,left=397 ,top=8 ,right=995 ,bottom=53 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(ASTAQAMT)}' ,left=1352 ,top=8 ,right=1601 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ABDEPRAMT)}' ,left=1609 ,top=8 ,right=1857 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ACDEPRAMT)}' ,left=1865 ,top=8 ,right=2119 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=40 ,top=3 ,right=4085 ,bottom=3 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<S>id='{Sum(ASTRMAMT)}' ,left=2402 ,top=11 ,right=2651 ,bottom=56 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=2659 ,top=5 ,right=2659 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2394 ,top=5 ,right=2394 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<S>id='{Sum(REDUAMT)}' ,left=2127 ,top=8 ,right=2387 ,bottom=53 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
</B>
<B>id=Footer ,left=0 ,top=2743 ,right=4101 ,bottom=2870 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=40 ,top=5 ,right=4085 ,bottom=5 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<I>id='../../common/img/icon.jpg' ,left=3556 ,top=19 ,right=4048 ,bottom=116</I>
	<T>id='Page   :  #p of #t' ,left=1913 ,top=42 ,right=2220 ,bottom=90 ,align='left' ,face='Arial' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
</B>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
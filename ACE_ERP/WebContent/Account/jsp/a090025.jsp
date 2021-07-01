<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산관리 - 이체 및 이동처리		
+ 프로그램 ID	: A090025.html
+ 기 능 정 의	: 현재 자산을 이체 및 이동 처리하는 화면이다.
+ 작   성  자 : 정영식
+ 작 성 일 자 : 2011.04.11
-----------------------------------------------------------------------------
+ 수 정 내 용 : 저장시 체크 로직 수정 ( 체크 안된건은 모두 undo 처리 )
+ 수   정  자 :  이동훈
+ 수 정 일 자 : 2012.06.19
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090025_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>이체 및 이동처리</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//소속코드[검색]
	gcds_fdcode.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//중분류[검색]
	gcds_asdivcod.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
  
 }

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	var str1 = gclx_fdcode.BindColVal;                //지점
	var str2 = txt_COSTNM.value;                      //원가명
	var str3 = txt_COSTCD.value;                      //원가코드
	var str4 = gclx_asdivcod.BindColVal;              //중분류
	var str5 = gclx_asdivcod_2.BindColVal;            //소분류	
	var str6 = gcem_jasan.text;                       //자산코드
    var str7 = txt_jasan.value;                       //자산명
	
	gcds_code01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_s1"
									   + "?v_str1="+str1
										 + "&v_str2="+str2
									   + "&v_str3="+str3
										 + "&v_str4="+str4 
										 + "&v_str5="+str5
									   + "&v_str6="+str6
										 + "&v_str7="+str7;
										
	//prompt('',gcds_code01.DataID);
	gcds_code01.Reset();
}

/******************************************************************************
	Description : 자산명 팝업
******************************************************************************/
function ln_Popup4(e){

	if(e=='01'){           //자산명 팝업창
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;


		arrParam[0]=gclx_asdivcod.bindcolval;
    arrParam[1]=gclx_asdivcod_2.bindcolval;
		
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
	Description : 부서 팝업
	Parameter   : 01-사용부서,  02-관리부서
******************************************************************************/
function ln_Popup(e,srow){

  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if(gcds_code01.namevalue(gcds_code01.rowposition,"AFDCODE")==""){
		alert("지점부터 입력하십시요.");
		return;
	}
	
	arrParam[0] = gcds_code01.namevalue(gcds_code01.rowposition,"AFDCODE");

	strURL = "./hcdept_popup4.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

  if(e=='01'){  
		if(arrResult != null) {
			arrParam = arrResult.split(";");       
  		gcds_code01.namevalue(srow,"AUSEDPT") = ln_Trim(arrParam[0]);
			gcds_code01.namevalue(srow,"AUSEDPTNM") = ln_Trim(arrParam[1])
		} else {
			gcds_code01.namevalue(srow,"AUSEDPT") = "";
			gcds_code01.namevalue(srow,"AUSEDPTNM") = "";
		}
  }else if(e=='02'){
		if(arrResult != null) {
			arrParam = arrResult.split(";");       
  		gcds_code01.namevalue(srow,"AMNGDPT") = ln_Trim(arrParam[0]);
			gcds_code01.namevalue(srow,"AMNGDPTNM") = ln_Trim(arrParam[1]); 
		} else {
			gcds_code01.namevalue(srow,"AMNGDPT") = "";
			gcds_code01.namevalue(srow,"AMNGDPTNM") = "";
		}
	}
}

/******************************************************************************
	Description : 원가 팝업
	Parameter   : srow - grid의 row, strgb - 01: grid,  02:검색조건
******************************************************************************/
function ln_Popup2(srow,strgb){

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

  if(strgb=="01"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_code01.namevalue(srow,"ACOSTCD") = ln_Trim(arrParam[0]);
			gcds_code01.namevalue(srow,"ACOSTNM") = ln_Trim(arrParam[1]); 
		}else{
			gcds_code01.namevalue(srow,"ACOSTCD") = "";	
			gcds_code01.namevalue(srow,"ACOSTNM") = "";
		}
	}else if(strgb=="02"){
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
	Description : 사용자팝업
	Parameter   : 
******************************************************************************/
function ln_Popup3(srow){
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup2.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_code01.namevalue(srow,"AUSER") = ln_Trim(arrParam[1]);
		gcds_code01.namevalue(srow,"AUSERNM") = ln_Trim(arrParam[0]); 
	}else{
		gcds_code01.namevalue(srow,"AUSER") = "";	
		gcds_code01.namevalue(srow,"AUSERNM") = "";
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
	Description : 저장 
******************************************************************************/
function ln_Save(){

   if(!ln_Chk_Save()) return; 

	if(confirm("자산을 이체 및 이동 처리하시겠습니까?")){
			gctr_code01.KeyValue   =  "Account.a090025_t1(I:USER=gcds_code01)";
			gctr_code01.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_t1?";
			gctr_code01.Parameters =  "v_str1="+gusrid;
			//prompt('',gcds_code01.text);
			gctr_code01.post();
	}
}

/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
function ln_Chk_Save(){
  var str_chk="";

  
  ////////////////////////////////////////////////////////////////////////////
  // 이동 이체시 이전월의 감가상각 마감이 되어야 적용가능함. 
  ////////////////////////////////////////////////////////////////////////////
	//월 마감을 했을 경우 상각처리도 못 함...
	//월마감 체크
    gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astMove_chk_s1"
									+ "?v_str1="+gclx_fdcode.BindColVal+"&v_str2=1";
	gcds_chk.Reset(); 


  /////////////////////////////////////////////////////////////////////////////////


  //체크가 없는 경우 확인 
	STEP1:
	for(i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")=="T"){
        str_chk="1";
				break STEP1;
		}
	}

	if(str_chk!="1"){
		alert("선택에 체크된 항목이 존재하지 않습니다.");
		return false;
	}

	//필수항목 체크 
   for(j=1;j<=gcds_code01.countrow;j++){
		if(gcds_code01.namevalue(j,"CHK")=="T"){
            if(gcds_code01.namevalue(j,"ASTGUBUN")==""){
				alert("구분은 필수항목입니다.");
				gcgd_disp01.focus();
				return false;
			}

           if(gcds_code01.namevalue(j,"MOVDATE")==""){
				alert("이체/이동일자는 필수항목입니다.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AFDCODE")==""){
				alert("이체 및 이동 후 지점은 필수항목입니다.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AUSEDPTNM")==""){
				alert("이체 및 이동 후 사용부서는 필수항목입니다.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AMNGDPTNM")==""){
				alert("이체 및 이동 후 관리부서는 필수항목입니다.");
				return false;
			}

			if(gcds_code01.namevalue(j,"ACOSTNM")==""){
				alert("이체 및 이동 후 원가는 필수항목입니다.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AUSERNM")==""){
				alert("이체 및 이동 후 사용자는 필수항목입니다.");
				return false;
			}
			
			
			//마감일자와 이동/이체일자 체크 
			//2012.04.06.금 JYS 
			//alert("cyymmdd"+gcds_chk.namevalue(1,"CYYMMDD").substring(0,6));
			//alert("MOVDATE"+gcds_code01.namevalue(j,"MOVDATE").substring(0,6));
			
			if ( gcds_chk.namevalue(1,"CYYMMDD").substring(0,6) !=gcds_code01.namevalue(j,"MOVDATE").substring(0,6)){
				alert("상각 작업 후 이동/이체 하십시요.");
				return false;
			}
			

			//이체일 경우 지점이 동일하면 오류
           if(gcds_code01.namevalue(j,"ASTGUBUN")=="8"){
				if(gcds_code01.namevalue(j,"FDCODE")==gcds_code01.namevalue(j,"AFDCODE")){
					alert("이체의 경우 동일 지점이 될 수 없습니다.");
					return false;
				}
				
				
		  
			  //이체일자는 최종 상각년월보다 커야 합니다.
			  //(예..2011.05월 감가상각을 했으면 2011.05월은 자산 이체 못함. 2011.06월 이체 해야함. )
			  if(gcds_code01.namevalue(j,"ASTYMD")!=""){
			  
					if(gcds_code01.namevalue(j,"ASTYMD")>=gcds_code01.namevalue(j,"MOVDATE")){
						alert("이체월은 최종상각월보다 커야합니다.");
						return false;
					}
			  }
			  
			}
			

           //이동일 경우 지점이 다르면 하면 오류
           if(gcds_code01.namevalue(j,"ASTGUBUN")=="9"){
				if(gcds_code01.namevalue(j,"FDCODE")!=gcds_code01.namevalue(j,"AFDCODE")){
					alert("이동의 경우 동일 지점만 가능합니다.");
					return false;
				}
				
			   
				//이체일자는 최종 상각년월보다 커야 합니다.
			    //(예..2011.05월 감가상각을 했으면 2011.05월은 자산 이체 못함. 2011.06월 이체 해야함. )
				if(gcds_code01.namevalue(j,"ASTYMD")!=""){
					if(gcds_code01.namevalue(j,"ASTYMD")>=gcds_code01.namevalue(j,"MOVDATE")){
						alert("이동월은 최종상각월보다 커야합니다.");
						return false;
					}
				}
			   
			}
		}else{
			if(gcds_code01.SysStatus(j)==3){
				gcds_code01.Undo(j);
			}
		}
	}//for

	return true;
}

/******************************************************************************
	Description : 자산소분류 
******************************************************************************/
function ln_Ast3rd(){
	//자산소분류[검색]
	if(gclx_asdivcod.BindColVal=='14'){
		gcds_asdivcod_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
		gcds_asdivcod_2.Reset();
	}else if(gclx_asdivcod.BindColVal=='16'){
		gcds_asdivcod_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
		gcds_asdivcod_2.Reset();
	}else{	
		gcds_asdivcod_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
		gcds_asdivcod_2.Reset();
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

<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- 자산중분류 -->
<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>

<!-- 자산소분류 -->
<object  id="gcds_asdivcod_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>


<!--상각체크-->
<object  id="gcds_chk" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090008_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

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

<!-- 자산소분류 (검색)-->
<script language="javascript" for="gcds_asdivcod_2" event="onloadCompleted(row,colid)">
	gcds_asdivcod_2.InsertRow(1);
	gcds_asdivcod_2.NameValue(1,"CDCODE")="";
	gcds_asdivcod_2.NameValue(1,"CDNAM")="";
	gclx_asdivcod_2.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	var str="namevalue("+row+",'MOVDATE')";
	if(row>0){
		if(colid=="MOVDATE"){
			__GetCallCalendar('gcds_code01',str);
		}

		if(colid=="AUSEDPTNM"){ // 사용부서
			ln_Popup('01',row);
		}

		if(colid=="AMNGDPTNM"){ // 관리부서
			ln_Popup('02',row);
		}

		if(colid=="ACOSTNM"){   // 원가코드
			ln_Popup2(row,'01');
		}
		
    if(colid=="AUSERNM"){   // 사용자
			ln_Popup3(row);
		}
	}
</script>

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
	ln_Ast3rd();
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>  
	if(row<1) return;
  if(colid=="CHK"||colid=="ASTGUBUN"||colid=="MOVDATE"||colid=="AFDCODE"||
	   colid=="AUSEDPTNM"||colid=="AMNGDPTNM"||colid=="ACOSTNM"||colid=="AUSERNM") return; 

	var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_code01.NameValue(row,"FDCODE"); //지점
	arrParam[1] = gcds_code01.NameValue(row,"ASTNBR"); //자산번호
	arrParam[2] = gcds_code01.NameValue(row,"ASTNM");  //자산명
  //alert("FDCODE::"+arrParam[0]+"::ASTNBR::"+arrParam[1]+"::ASTNM::"+arrParam[2]);
	var strURL = "./a090025_popup.jsp";
	var strPos = "dialogWidth:662px;dialogHeight:450px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
 
  //전체선택 
	if(row==0&&colid=="CHK"){
    if(gcds_code01.namevalue(1,"CHK")=="T"){
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="T";
			}
    }
	}

</script>


<!-- <script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>

	//이동일경우 동일 지점.
   alert("Occur OnExit Event :\r" + "<ROW :" + row +">"+ "<Colid :" + colid + ">" + "<Before Data :" + olddata + ">" );
	if(colid=="ASTGUBUN"&&gcds_code01.namevalue(row,"ASTGUBUN")=="9"){
			gcds_code01.namevalue(row,"AFDCODE")=gcds_code01.namevalue(row,"FDCODE");
	}

</script> -->

<script language=JavaScript for=gcds_code01 event=onColumnChanged(row,colid)>
  
	if (colid == "ASTGUBUN" && gcds_code01.namevalue(row,"ASTGUBUN")=="9" ) { //이동
		gcds_code01.namevalue(row,"AFDCODE")=gcds_code01.namevalue(row,"FDCODE");
	}else if (colid == "ASTGUBUN" && gcds_code01.namevalue(row,"ASTGUBUN")=="8"){ //이체
		if(gcds_code01.namevalue(row,"FDCODE")==gcds_code01.namevalue(row,"AFDCODE")){
			gcds_code01.namevalue(row,"AFDCODE")="";
		}
	}

</script>
 



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>
</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090025_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_save.gif"	  style="cursor:hand" onClick="ln_Save()">
      <img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">     
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> 원가명</td>  
	  <td class="tab24"  colspan =4 >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:0px; width:220px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:4px;cursor:hand"	 onclick="ln_Popup2('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:5px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
 <tr> 
		<td width="80px"  class="tab27" bgcolor="#eeeeee" align=center>중분류</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE, CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center>소분류</td>  
	  <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod_2">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>자산명</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;left:-2px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-4px;cursor:hand"	 onclick="ln_Popup4(01)">
			<comment id="__NSID__">
			<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:50px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="#######">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
</table>
<table><tr><td height="1px;"> </td></tr></table>
<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:355px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name="Format"		value=" 
					<FC>Name='선택'	           ID=CHK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	EditStyle=CheckBox  </FC> 
					<C> Name='자산\\번호'			   ID=ASTNBR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  edit=none   sort=true </C>
					<C> Name='자산명'			     ID=ASTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  edit=none  </C>
					<C> Name='취득일자'		     ID=ASAQSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=67  	align=center	edit=none  Mask='XXXX/XX/XX' </C>
					<C> Name='취득금액'		     ID=ASTAQAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	  edit=none  sort=true</C>
					<C> Name='구분' 			     ID=ASTGUBUN	HeadAlign=Center HeadBgColor=#B9D4DC Width=35  	align=center  EditStyle=Combo Data='8:이체,9:이동'</C>
					<C> Name='이체/이동\\일자' ID=MOVDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=75  	align=center  EditStyle=Popup Mask='XXXX/XX/XX'  sort=true</C>
					<G> Name='이체 및 이동 전'              HeadAlign=Center HeadBgColor=#B9D4DC	
					<C> Name='지점'			    	 ID=FDCODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45 	align=left	  edit=none  EditStyle=Combo Data='02:서울,03:금강산,04:개성' </C>
					<C> Name='사용부서'				 ID=BUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	  edit=none   </C>
					<C> Name='관리부서'			   ID=BMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    edit=none   </C>
					<C> Name='원가'			       ID=BCOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    edit=none   </C>
					<C> Name='사용자'		       ID=BUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    edit=none   sort=true</C>
					</G>
					<G> Name='이체 및 이동 후'	            HeadAlign=Center HeadBgColor=#B9D4DC
					<C> Name='지점'				     ID=AFDCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left	  EditStyle=Combo Data='02:서울,03:금강산,04:개성' </C>
					<C> Name='사용부서'				 ID=AUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left	  EditStyle=Popup </C>
					<C> Name='관리부서'			   ID=AMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    EditStyle=Popup </C>
					<C> Name='원가'			       ID=ACOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    EditStyle=Popup </C>
					<C> Name='사용자' 		     ID=AUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    EditStyle=Popup  sort=true</C>
    			</G>
					<C> Name='최종\\상각월' 	 ID=ASTYMD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=left    EditStyle=Popup Mask='XXXX/XX'  edit=none</C>

					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
 </tr>
  <tr>
		<td colspan=2><BR>
		  <font size="2" color="red"> *</font> <font size="2" color="blue"><b> [이체]</b></font> 처리시에는 반드시 <font size="2" color="blue"><b>[전표 작성]</b></font>을 하셔야 합니다. <br> 
		     매월 감가 상각 작업전 까지 필히 이체 이동 작업을 완료하여 주시기 바랍니다. 
		     문의사항 : 회계팀 이정식 DR ( ☎ 3805 ) 에게 연락 바랍니다.            
        </td>
  </tr>
</table>

<!--------BIND------->
<comment id="__NSID__">
  <object  id=gcbn_astmst classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code01>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=ASTNBR     Ctrl=gcem_ASTNBR      Param=text </C>
		<C>Col=CDNAM      Ctrl=gcem_CDNAM       Param=text </C>
		<C>Col=ASAQSDAT   Ctrl=gcem_ASAQSDAT    Param=text </C>
		<C>Col=ASTYUSE    Ctrl=gcem_ASTYUSE     Param=text </C>
		<C>Col=ASTAQAMT   Ctrl=gcem_ASTAQAMT    Param=text </C>
		<C>Col=ABDEPRAMT  Ctrl=gcem_ABDEPRAMT   Param=text </C>
		<C>Col=ACDEPRAMT  Ctrl=gcem_ACDEPRAMT   Param=text </C>
    <C>Col=ASTRMAMT   Ctrl=gcem_ASTRMAMT    Param=text </C>
    <C>Col=ASTAMT     Ctrl=gcem_ASTAMT      Param=text </C>
	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
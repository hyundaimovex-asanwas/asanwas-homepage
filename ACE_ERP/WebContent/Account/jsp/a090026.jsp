<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산관리- 이체 및 이동 조회
+ 프로그램 ID	: A090026.html
+ 기 능 정 의	: 현재 자산을 이체 및 이동 history를 조회하는 화면이다.
+ 작   성  자 : 정영식
+ 작 성 일 자 : 2011.05.02
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090026_s1,A090026_s2, A090026_s3
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>이체 및 이동 조회</title>
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
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//소속코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//중분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_aststat.bindcolval= 9; 

	gcem_movdt_fr.text = gs_date2 + "01";	    //이동/이체일자 from
	gcem_movdt_to.text = gs_date ; 

 }

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  if(gclx_aststat.BindColVal.bindcolval==""){
		alert("상태값이 존재하지 않습니다.");
		return;
	}
	
	var str1 = gclx_fdcode.BindColVal;                //지점
	var str2 = txt_COSTNM.value;                      //원가명 
	var str3 = txt_COSTCD.value;                      //원가코드 ( 이동/이체 후 ) 
	var str4 = gclx_asdivcod.BindColVal;              //중분류
	var str5 = gclx_asdivcod_2.BindColVal;            //소분류	
	var str6 = gcem_jasan.text;                       //자산코드
    var str7 = txt_jasan.value;                       //자산명
	var str8 = gclx_aststat.BindColVal;               //상태
    var str9  = txt_BBCOSTNM.value;                   //원가명 
	var str10 = txt_BBCOSTCD.value;                   //원가코드 ( 이동/이체 전 ) 
	var str11 = gcem_movdt_fr.text;                   //이동일자 FR
	var str12 = gcem_movdt_to.text;                   //이동일자 TO
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s1"
									   + "?v_str1="+str1
										 + "&v_str2="+str2
									   + "&v_str3="+str3
										 + "&v_str4="+str4 
										 + "&v_str5="+str5
									   + "&v_str6="+str6
										 + "&v_str7="+str7
										 + "&v_str8="+str8
										 + "&v_str9="+str9
									   + "&v_str10="+str10
										 + "&v_str11="+str11
										 + "&v_str12="+str12;
	//prompt('',gcds_code01.DataID);
	gcds_code01.Reset();
	gcds_code02.ClearAll();
}

/******************************************************************************
	Description : 상세조회
	Parameter   : 자산번호  
******************************************************************************/
function ln_Sub_Query(strAstnbr){

  if(strAstnbr==""){
		alert("자산번호는가 존재하지 않습니다.");
		return;
	}

	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s2"
									   + "?v_str1="+strAstnbr;		
	//prompt('',gcds_code02.DataID);
	gcds_code02.Reset();

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

 if(strgb=="01"){         // 이체 이동 전 
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_BBCOSTCD.value = ln_Trim(arrParam[0]);
			txt_BBCOSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_BBCOSTCD.value = "";	
			txt_BBCOSTNM.value = "";
		}
	}else if(strgb=="02"){  //이체 이동 후 
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
	Description : 출력 
******************************************************************************/
function ln_Print(){
  var strAstnbr ="";
	var strTempAstnbr="";   // 이체시 처음 건의 자산번호
	var strUfdcode="";      // 이체 부서에 연결된 자산번호
	var chk=0;

  var strFromdpt=""
	var strTodpt=""
	var strAstgubun="";    //이체 이동 구분
	
	gcds_report00.ClearAll();
	ln_SetDataHeader();
  gcds_report00.Addrow();
 
  for(var i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")=="T"){
		  chk+=1;
			if(chk==1){
			  strTempAstnbr=gcds_code01.namevalue(i,"ASTNBR");
				strUfdcode = gcds_code01.namevalue(i,"UFDCODE");
				strAstnbr = gcds_code01.namevalue(i,"ASTNBR");
				strAstnbr ="'"+strAstnbr+"'";

			}else{
				strAstnbr = strAstnbr+ ",'"+ gcds_code01.namevalue(i,"ASTNBR")+"'";
			}


			//이체 아닌건이 존재하는 경우 
      //if(gcds_code01.namevalue(i,"ASTSTAT")!=8){
			//	alert("상태가 이체가 아닌 건이 존재합니다. 확인하십시요.");
			//	return;
			//}

			//이체건인데, 서로 다른 지점으로 이체 하는 경우 따로 출력해야함.
      if(gcds_code01.namevalue(i,"ASTSTAT")==8&&gcds_code01.namevalue(i,"UFDCODE")!=strUfdcode){
				alert("동일한 지점건만 출력가능합니다.");
				return;
			}

		}
	}

	if(chk==0){
		alert("선택에 체크한 건이 존재하지 않습니다. 확인하십시요.");
		return;
  }

  //ASTMOVINGN 이체 송신 - 수신 지점 부서 찾기
  gcds_report0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s5"
									   + "?v_str1="+strTempAstnbr;		
	//prompt('',gcds_report0.DataID);
	gcds_report0.Reset();


  if(gcds_code01.namevalue(1,"ASTGUBUN")=="9"){
		gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "이동 [";
		gcds_report00.namevalue(gcds_report00.rowposition,"TITLE") = "자산 이동 내역";
	}else{
		gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "이체 [";
		gcds_report00.namevalue(gcds_report00.rowposition,"TITLE") = "자산 이체 내역";
	}

	strAstgubun =gcds_code01.namevalue(1,"ASTGUBUN");
  
	strFromdpt= gcds_report0.namevalue(gcds_report0.rowposition,"FDNAME")+":"+ gcds_report0.namevalue(gcds_report0.rowposition,"BUSEDPTNM");
	strTodpt= gcds_report0.namevalue(gcds_report0.rowposition,"AFDNAME")+":"+ gcds_report0.namevalue(gcds_report0.rowposition,"AUSEDPTNM");

	gcds_report00.namevalue(gcds_report00.rowposition,"FDCODE") = strFromdpt+" → "+strTodpt+" ]";
	gcds_report00.namevalue(gcds_report00.rowposition,"USRNAME") = gusrnm;
  gcds_report00.namevalue(gcds_report00.rowposition,"USEDATE") = gs_date;
	
  gcds_report1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s3"
									    + "?v_str1="+strAstnbr
											+ "&v_str2="+strAstgubun;
	//prompt('',gcds_report1.DataID);
	gcds_report1.Reset();


	gcrp_print.preview();			//미리보기

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

/******************************************************************************
	Description : 저장 
******************************************************************************/
function ln_Save(){

  if(!ln_Chk_Save()) return; 

	if(confirm("자산을 이체 및 이동 처리하시겠습니까?")){
			gctr_code01.KeyValue   =  "Account.a090025_t1(I:USER=gcds_code01)";
			gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_t1?";
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
		}
	}
	return true;
}

/******************************************************************************
	Description : 자산소분류 
******************************************************************************/
function ln_Ast3rd(){
	//자산소분류[검색]
	if(gclx_asdivcod.BindColVal=='14'){
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
		gcds_asdivcod_2.Reset();
	}else if(gclx_asdivcod.BindColVal=='16'){
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
		gcds_asdivcod_2.Reset();
	}else{	
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
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
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_aststat classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_report00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

</script>


<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	ft_cnt02.innerText="데이타 조회중입니다.";
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)"> 
  ft_cnt02.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
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
	//document.all.LowerFrame.style.visibility="hidden";    
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

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
	ln_Ast3rd();
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>  

	if(row<1) return;
  if(colid=="CHK") return; 
	ln_Sub_Query(gcds_code01.namevalue(row,"ASTNBR"));

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
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090026_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_print.gif"	  style="cursor:hand" onClick="ln_Print()">
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

    <td width="80px"   class="tab24"  bgcolor="#eeeeee" align=center>상태</td>  
	  <td class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_aststat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<!-- <param name=CBData					value="^전체,0^정상,1^매각,2^폐기,8^이체,9^이동"> -->
				<param name=CBData					value="8^이체,9^이동">
				<param name=CBDataColumns		value="Code, Parm">
				<param name=SearchColumn		value="Parm">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="Parm^0^120">
				<param name=BindColumn			value="Code">
				<param name=XPStyle         value=true>
			</OBJECT></comment><script>__ws__(__NSID__);</script> 			
		</td>

		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>이체/이동일</td>  
	  <td class="tab24"  >&nbsp;
		
			<comment id="__NSID__">
			<OBJECT id=gcem_movdt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment			value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_movdt_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_movdt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment			value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_movdt_to', 'Text')" style="position:relative;width:20px;left:1px;top:1px;cursor:hand;">		
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
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-1px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4(01)">
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
	 <tr> 
		<td width="80px"  class="tab27" bgcolor="#eeeeee" align=center>원가(전)</td>
		<td width="320px" class="tab28" colspan =3 >&nbsp;
			<input id="txt_BBCOSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','01')">
			<input id=txt_BBCOSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td> 
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>원가(후)</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
</table>
<table><tr><td height="1px;"> </td></tr></table>


<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:221px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name="Format"		value=" 
					<C> Name='선택'			   ID=CHK     	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center   EditStyle=CheckBox </C>
					<C> Name='자산번호'		 ID=ASTNBR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  edit=none Mask='XXX-XXXXX' </C>
					<C> Name='자산명'			 ID=ASTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=left	  edit=none </C>
					<C> Name='취득일자'		 ID=ASAQSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center  edit=none Mask='XXXX/XX/XX' </C>
					<C> Name='취득금액'    ID=ASTAQAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right   edit=none </C>
					<C> Name='사용부서'		 ID=BUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	align=left	  edit=none </C>
					<C> Name='관리부서'		 ID=BMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left    edit=none </C>
					<C> Name='원가'			   ID=BCOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left    edit=none </C>
					<C> Name='사용자'		   ID=BUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none </C>
					<C> Name='상태'		     ID=ASTSTAT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none EditStyle=Combo Data='0:정상,1:매각,2:폐기,8:이체'</C>
					<C> Name='이동'		     ID=ASTGUBUN 	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none EditStyle=Combo Data='9:이동'</C>
					<C> Name='작성자'		   ID=WRNM     	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td><BR></td>
  </tr>
</table>

<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr>
		<td> <font size="2" color="blue"> <b> [이체/이동 상세내역] </b> </font></td>
	</tr>
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:0px;width:858px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code02">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="ColSizing"		value="true">
					<param name=TitleHeight   value="30">
					<param name="Format"		  value=" 
					<C> Name='순번'	    		   ID=CURROW   	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center  Value={CurRow} </C>
					<C> Name='자산번호'			   ID=ASTNBR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center  Mask='XXX-XXXXX' </C>
					<C> Name='자산명'			       ID=ASTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  </C>
					<C> Name='구분' 			       ID=ASTGUBUN	HeadAlign=Center HeadBgColor=#B9D4DC Width=30  	align=left	  EditStyle=Combo Data='0:정상,1:매각,2:폐기,8:이체,9:이동'</C>
					<C> Name='이체/이동\\일자'        ID=MOVDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  	align=center  EditStyle=Popup Mask='XXXX/XX/XX'</C>
					<C> Name='지점'    			   ID=AFDCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45 	align=left	  EditStyle=Combo Data='02:서울,03:금강산,04:개성'</C>
					<C> Name='사용부서'			   ID=AUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  </C>
					<C> Name='관리부서'			   ID=AMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left    </C>
					<C> Name='원가'			       ID=ACOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left    </C>
					<C> Name='사용자' 		       ID=AUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	align=left    </C>
					<C> Name='비고' 		           ID=MOVNOTE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left    </C>
					<C> Name='사용부서'			   ID=BUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	 show=false </C>
					<C> Name='관리부서'			   ID=BMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left   show=false </C>
					<C> Name='원가'			       ID=BCOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left   show=false </C>
					<C> Name='사용자'		           ID=BUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=left   show=false </C>
					
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td><BR></td>
  </tr>
</table>


<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report00">
	<param name="DetailDataID"      value="gcds_report1"> 
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag			value=false>
	<param name="SaveToFileShowButton"value="true">		
<!-- 	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'> -->
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=170 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='TITLE', left=29, top=5, right=2775, bottom=169, face='굴림', size=18, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=236 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2648 ,top=177 ,right=2648 ,bottom=225 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='최종상각월' ,left=2529 ,top=175 ,right=2648 ,bottom=225 ,face='굴림' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이체일' ,left=2654 ,top=175 ,right=2778 ,bottom=225 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ASTGUBUN', left=40, top=56, right=151, bottom=103, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=1326 ,top=114 ,right=1326 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='자산명' ,left=622 ,top=119 ,right=1323 ,bottom=169 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='관리부서' ,left=1331 ,top=175 ,right=1738 ,bottom=225 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수량' ,left=1511 ,top=119 ,right=1582 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득일자' ,left=1331 ,top=119 ,right=1503 ,bottom=169 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=439 ,top=114 ,right=439 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='소분류' ,left=445 ,top=119 ,right=614 ,bottom=169 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='중분류' ,left=257 ,top=119 ,right=439 ,bottom=169 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득' ,left=352 ,top=175 ,right=439 ,bottom=225 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산' ,left=257 ,top=175 ,right=344 ,bottom=225 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='USRNAME', left=2569, top=11, right=2775, bottom=58, face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='USEDATE', left=2572, top=61, right=2775, bottom=108 ,mask='XXXX.XX.XX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='작성일자:' ,left=2402 ,top=61 ,right=2572 ,bottom=108 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='작 성 자 :' ,left=2402 ,top=11 ,right=2572 ,bottom=58 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODE', left=151, top=56, right=2212, bottom=103, align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=2257 ,top=116 ,right=2257 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='사용부서' ,left=1749 ,top=175 ,right=2260 ,bottom=225 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사용자' ,left=2265 ,top=175 ,right=2519 ,bottom=225 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2003 ,top=116 ,right=2003 ,bottom=172 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1585 ,top=114 ,right=1585 ,bottom=169 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1505 ,top=116 ,right=1505 ,bottom=172 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=347 ,top=175 ,right=347 ,bottom=230 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=616 ,top=114 ,right=616 ,bottom=169 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2521 ,top=116 ,right=2521 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1741 ,top=114 ,right=1741 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=251 ,top=116 ,right=251 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=37 ,top=233 ,right=2786 ,bottom=233 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='잔존가액' ,left=2529 ,top=119 ,right=2778 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당기상각액' ,left=2265 ,top=119 ,right=2519 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전기누계액' ,left=2008 ,top=119 ,right=2257 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='취득금액(원화)' ,left=1749 ,top=119 ,right=1998 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내용연수' ,left=1593 ,top=119 ,right=1738 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='최초자산번호' ,left=82 ,top=175 ,right=251 ,bottom=225 ,face='굴림' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자산번호' ,left=82 ,top=119 ,right=251 ,bottom=169 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=114 ,right=2783 ,bottom=114 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='Page : #p of #t' ,left=40 ,top=5 ,right=677 ,bottom=53 ,align='left', MargineX=3</T>
	<T>id='원가명(전==>후)' ,left=445 ,top=175 ,right=1323 ,bottom=225 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=79 ,top=119 ,right=79 ,bottom=235 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=79 ,top=169 ,right=2778 ,bottom=172 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='순' ,left=34 ,top=130 ,right=79 ,bottom=180 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='번' ,left=34 ,top=172 ,right=79 ,bottom=222 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=106 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=37 ,top=108 ,right=2783 ,bottom=106 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=82 ,top=50 ,right=2781 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=251 ,top=0 ,right=251 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=439 ,top=0 ,right=439 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1741 ,top=0 ,right=1741 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2521 ,top=0 ,right=2521 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=347 ,top=53 ,right=347 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=616 ,top=0 ,right=616 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1505 ,top=0 ,right=1505 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1588 ,top=3 ,right=1588 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2003 ,top=3 ,right=2003 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTNBR', left=82, top=0, right=251, bottom=48 ,mask='XXX-XXXXX'</C>
	<C>id='ASTYUSE', left=1593, top=0, right=1738, bottom=48</C>
	<C>id='ABDEPRAMT', left=2006, top=0, right=2254, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACDEPRAMT', left=2260, top=0, right=2514, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_ASTNBR', left=82, top=56, right=251, bottom=103 ,mask='XXX-XXXXX'</C>
	<C>id='ASTRMAMT', left=2529, top=0, right=2778, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BUSERNM', left=2260, top=56, right=2514, bottom=103</C>
	<C>id='BUSEDPTNM', left=1749, top=56, right=2257, bottom=103, align='left'</C>
	<L> left=2257 ,top=0 ,right=2257 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='GODDIVNM', left=257, top=56, right=344, bottom=103, align='left'</C>
	<C>id='ASAQSDIVNM', left=352, top=56, right=439, bottom=103, align='left'</C>
	<C>id='AST2NDNM', left=257, top=0, right=439, bottom=48, align='left'</C>
	<C>id='ASTQTY', left=1511, top=0, right=1582, bottom=48</C>
	<C>id='ASAQSDAT', left=1328, top=0, right=1505, bottom=48, align='left' ,mask='XXXX/XX/XX', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BMNGDPTNM', left=1331, top=56, right=1738, bottom=103, align='left'</C>
	<L> left=1326 ,top=0 ,right=1326 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2678 ,top=74 ,right=2678 ,bottom=87 </L>
	<C>id='LASTYM', left=2527, top=56, right=2635, bottom=103 ,mask='XXXX/XX'</C>
	<C>id='MOVDATE', left=2641, top=56, right=2781, bottom=103 ,mask='XXXX/XX/XX'</C>
	<L> left=2638 ,top=53 ,right=2638 ,bottom=101 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTNM', left=622, top=0, right=1323, bottom=48, align='left', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AST3RDNM', left=445, top=0, right=614, bottom=48, align='left'</C>
	<C>id='BCOSTNM', left=445, top=56, right=1323, bottom=103, align='left'</C>
	<L> left=79 ,top=0 ,right=79 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=32, top=3, right=77, bottom=101, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTAQAMT', left=1749, top=0, right=1998, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1604 ,right=2871 ,bottom=2000 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=34 ,top=58 ,right=2781 ,bottom=238 ,border=true</X>
	<L> left=37 ,top=254 ,right=2783 ,bottom=254 </L>
	<I>id='../../common/img/icon.jpg' ,left=2294 ,top=265 ,right=2786 ,bottom=362</I>
	<T>id='서명' ,left=1278 ,top=159 ,right=1371 ,bottom=209 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소속' ,left=114 ,top=71 ,right=815 ,bottom=122 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=1048 ,top=71 ,right=1386 ,bottom=122 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1394 ,top=58 ,right=1394 ,bottom=238 </L>
	<L> left=818 ,top=58 ,right=818 ,bottom=238 </L>
	<T>id='직위' ,left=2201 ,top=71 ,right=2421 ,bottom=122 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명' ,left=2429 ,top=71 ,right=2768 ,bottom=122 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서명' ,left=2659 ,top=159 ,right=2752 ,bottom=209 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1405 ,top=58 ,right=1405 ,bottom=238 </L>
	<T>id='자' ,left=40 ,top=175 ,right=106 ,bottom=225 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계' ,left=40 ,top=127 ,right=106 ,bottom=177 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=40 ,top=79 ,right=106 ,bottom=130 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자' ,left=1413 ,top=175 ,right=1479 ,bottom=225 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수' ,left=1413 ,top=127 ,right=1479 ,bottom=177 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='인' ,left=1413 ,top=79 ,right=1479 ,bottom=130 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1484 ,top=58 ,right=1484 ,bottom=238 </L>
	<L> left=1045 ,top=58 ,right=1045 ,bottom=238 </L>
	<L> left=108 ,top=58 ,right=108 ,bottom=238 </L>
	<L> left=2196 ,top=58 ,right=2196 ,bottom=238 </L>
	<L> left=2424 ,top=58 ,right=2424 ,bottom=238 </L>
	<L> left=108 ,top=127 ,right=1394 ,bottom=127 </L>
	<L> left=1484 ,top=127 ,right=2778 ,bottom=127 </L>
	<L> left=37 ,top=5 ,right=2783 ,bottom=5 </L>
	<T>id='소속' ,left=1487 ,top=71 ,right=2188 ,bottom=122 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1741 ,top=8 ,right=1741 ,bottom=58 </L>
	<S>id='{Sum(ASTRMAMT)}' ,left=2529 ,top=11 ,right=2778 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ACDEPRAMT)}' ,left=2260 ,top=11 ,right=2514 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ABDEPRAMT)}' ,left=2006 ,top=11 ,right=2254 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ASTAQAMT)}' ,left=1749 ,top=11 ,right=1998 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=2521 ,top=5 ,right=2521 ,bottom=56 </L>
	<L> left=2257 ,top=8 ,right=2257 ,bottom=58 </L>
	<L> left=2000 ,top=8 ,right=2000 ,bottom=56 </L>
	<T>id='합계' ,left=1331 ,top=11 ,right=1738 ,bottom=56 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위' ,left=820 ,top=71 ,right=1040 ,bottom=122 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	: 재무회계관리 - 이체상각등록		
+ 프로그램 ID	: A090008.html
+ 기 능 정 의	: 이체된 자산의 감가상각정보를 등록하는 화면이다.
+ 작   성  자 : 정영식
+ 작 성 일 자 : 
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090008_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>A090008</title>
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
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//자산분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_astdeprst.index=0;

  
 }

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  gcem_ASTYM.text="";
  gcem_ASTDAT.text="";
	
	var str1 = gclx_fdcode.BindColVal;                 //소속
	var str2 = gclx_asdivcod.BindColVal;              //자산분류
	var str3 = gcem_jasan.text;                       //자산코드
  var str4 = txt_jasan.value;                       //자산명
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090028_s1"
									   + "?v_str1="+str1+"&v_str2="+str2
									   + "&v_str3="+str3+"&v_str4="+str4
										 + "&v_str5="+gclx_astdeprst.bindcolval
										 + "&v_str6="+txt_COSTCD_0.value;
	//prompt('',gcds_code01.DataID);
	gcds_code01.Reset();

	txt_COSTNM.value = "";
}

/******************************************************************************
	Description : 최종 월상각년월 찾기
	              해당지점에서 마지막 상각년월을 DISPLAY 해줌.
 ******************************************************************************/
function ln_Find_Astym(){
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090028_s2"
								 	   + "?v_str1="+gclx_fdcode.BindColVal;								   
	gcds_code02.Reset();
  gcem_ASTYM2.text = gcds_code02.namevalue(gcds_code02.rowposition,"ASTYM");
  gcem_ASTDAT.text = gs_date;
	gcem_PREVYM.text = gcds_code02.namevalue(gcds_code02.rowposition,"PREVYM");
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
	Description : 금액계산
******************************************************************************/
function ln_Calculation(){ 
  //잔존가액
	gcem_ASTRMAMT.text=parseInt(gcem_ASTAQAMT.text)-parseInt(gcem_ABDEPRAMT.text)-parseInt(gcem_ACDEPRAMT.text);

  //감가상각액 ( 이체 전 월 감가상각을 누적해서 월 감가상각에 넣음 )  
  gcem_ASTAMT.text=parseInt(gcem_ABDEPRAMT.text)+parseInt(gcem_ACDEPRAMT.text); 

  //외화 적용
	if(gclx_fdcode.bindcolval=="03"){ // 금강산 ) 
		//외화 잔존가액 
		gcem_FORMAMT.text=parseInt(gcem_ASTAQAMTY.text)-parseInt(gcem_FOBDAMT.text)-parseInt(gcem_FOCDAMT.text);
		//외화 감가상각액 ( 이체 전 월 감가상각을 누적해서 월 감가상각에 넣음 )  
		gcem_FOATAMT.text=parseInt(gcem_FOBDAMT.text)+parseInt(gcem_FOCDAMT.text); 
	}
}


/******************************************************************************
	Description : 저장 
******************************************************************************/
function ln_Save(){

  if(!ln_Chk_Save()) return; 

  gcds_code01.namevalue(gcds_code01.rowposition,"DEPRENDDT") = gcem_ASTYM.text+"01";  

	if(gcds_code01.namevalue(gcds_code01.rowposition,"CHK")=="T"){
		if(confirm("감가상각 이체 등록 하시겠습니까?")){
			gctr_code01.KeyValue   =  "Account.a090028_t1(I:USER=gcds_code01)";
			gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090028_t1?";
			gctr_code01.Parameters =  "v_str1="+gcem_ASTYM.text+",v_str2="+gcem_ASTDAT.text+",v_str3="+gcem_PREVYM.text;
			//prompt('',gcds_code01.text);
			gctr_code01.post();
		}
	}
}

/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
function ln_Chk_Save(){

	if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")!=""){
		alert("이미 감가상각 등록 건입니다. 이체상각등록 할 수 없습니다.");
		return false;
	}

	if(gcem_ASTAMT.text==""||gcem_ASTAMT.text==0){
		alert("전기누계액 또는 당기상각액은 반드시 입력되어야 합니다.");
    return false;
	}

	//금액이 공백일 경우 저장 못 함.
  if(gcem_ABDEPRAMT.text==""){
		alert("전기누계액에 숫자를 입력하십시요.");
		return false
	}

	if(gcem_ACDEPRAMT.text==""){
		alert("당기상각액에 숫자를 입력하십시요.");
		return false	
	}

  //금액이 공백일 경우 저장 못 함.
  if(gcem_ASTYM.text==""){
		alert("상각년월을 확인하십시요.");
		return false;
	}

  if(gcem_ASTYM.text==""){
		alert("상각년월을 확인하십시요.");
		return false;
	}

  //이체전상각년월 길이체크
	var strym = gcem_ASTYM.text;
	if(strym.length<6){
		alert("상각년월을 확인하십시요.");
		return false;
	}


  //취득년월보다 이체년월이 크야합니다.	

	if(gcem_ASAQSDAT.text.substring(0,6)>=gcem_ASTYM.text){
		alert("취득월과 이체전 상각월을 확인하십시요.");
		return false;
	}
	

    // 2013.06.17.jys
	//잔존가액은 0 보다 크야한다.
   // if(gcem_ASTRMAMT.text<=0){
   //		alert("잔존가액은 0보다 크야합니다.");
	//	return false;
	//}

	

  //이체전 원가코드 체크
  if(txt_COSTCD.value==""){
		alert("이체전 원가코드는 필수항목입니다.");
		return false;
	}

	//취득년월

  ////////////////////////////////////////////////////////////////////////////
	//외화 체크
	if(gclx_fdcode.bindcolval=="03"){ // 금강산 경우 ) 
			if(gcem_FOATAMT.text==""||gcem_FOATAMT.text==0){  
				alert("외화 전기누계액 또는 외화 당기상각액은 반드시 입력되어야 합니다.");
				return false;
			}

			//금액이 공백일 경우 저장 못 함.
			if(gcem_FOBDAMT.text==""){
				alert("외화 전기누계액에 숫자를 입력하십시요.");
				return false
			}

			if(gcem_FOCDAMT.text==""){
				alert("외화 당기상각액에 숫자를 입력하십시요.");
				return false	
			}

			//잔존가액은 0 보다 크야한다.
		if(gcem_FORMAMT.text<=0){
			alert("외화 잔존가액은 0보다 크야합니다.");
			return false;
		}
	}
  //////////////////////////////////////////////////////////////////////////


	for(i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")!="T"){
				gcds_code01.Undo(i);
		}
	} 


	return true;
}

/******************************************************************************
	Description : 원가 팝업
	Parameter   : srow - , strgb - 01: 입력,  02:검색조건
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

  if(strgb=="00"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD_0.value = ln_Trim(arrParam[0]);
			txt_COSTNM_0.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD_0.value = "";	
			txt_COSTNM_0.value = "";
		}
	}else if(strgb=="01"){
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
	Description : 지점선택에 따른 외화입력란 Lock 설정 ( 금강산 입력가능 ) 
	Parameter   : 
******************************************************************************/
function ln_Amt_Enable(){
	if(gclx_fdcode.bindcolval!="03"){//금강산이 아닐경우 
	  if(gcem_ASTAQAMTY.text==""){
			 gcem_FOBDAMT.text="";
		   gcem_FOCDAMT.text="";
		}else{
			gcem_FOBDAMT.text=0;
			gcem_FOCDAMT.text=0;
			 //외화 잔존가액 
			gcem_FORMAMT.text=parseInt(gcem_ASTAQAMTY.text)-parseInt(gcem_FOBDAMT.text)-parseInt(gcem_FOCDAMT.text);
			//외화 감가상각액 ( 이체 전 월 감가상각을 누적해서 월 감가상각에 넣음 )  
			gcem_FOATAMT.text=parseInt(gcem_FOBDAMT.text)+parseInt(gcem_FOCDAMT.text); 
		}
		gcem_FOBDAMT.ReadOnly="true";
		gcem_FOBDAMT.ReadOnlyBackColor="#ccffcc";
    gcem_FOCDAMT.ReadOnly="true";
		gcem_FOCDAMT.ReadOnlyBackColor="#ccffcc";
	}else{
		gcem_FOBDAMT.ReadOnly="false";
    gcem_FOCDAMT.ReadOnly="false";
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
</comment><script>__ws__(__NSID__);</script>

<!-- 지점 -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!-- 자산분류 -->
<comment id="__NSID__"><object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

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

	if(gcds_code01.countrow<=0)	alert("조회된 데이타가 없습니다.");
  else {
		ln_Calculation();
    ln_Find_Astym();
  }
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

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>
	//document.all.LowerFrame.style.visibility="visible";
  
  return;
  /**
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	if(row<1) return;
	var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_code01.NameValue(row,"ASTNUM");
	arrParam[1] = gcds_code01.NameValue(row,"LASTYM");
	var strURL = "./Asetdep_popup2.jsp";
	var strPos = "dialogWidth:662px;dialogHeight:560px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	**/
</script>

<script language=JavaScript for=gcds_code01 event=onColumnChanged(row,colid)>
	ln_Calculation();
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
  ln_Calculation();

	if(colid=="CHK"){
    if(gcds_code01.namevalue(row,"CHK")=="T"){
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
			gcds_code01.namevalue(row,"CHK")="T";
    }
		
	}

</script>


<script language="javascript" for="gclx_fdcode" event="OnSelChange2()">
  ln_Amt_Enable();
	
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
	alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090008_head.gif">	</td>
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
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> 자산분류</td>  
	  <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
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
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >등록상태</td>
		<td width="180px" class="tab28"  colspan=3 >&nbsp;
			<comment id="__NSID__">
			 <OBJECT id=gclx_astdeprst classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:108px;">
						<param name=CBData					value="1^이체상각미등록,2^이체상각등록">
						<param name=CBDataColumns		value="Code, Parm">
						<param name=SearchColumn		value="Parm">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="Parm^0^110">
						<param name=BindColumn			value="Code">
					</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> 원가명</td>  
	  <td class="tab28"  >&nbsp;
			<input id="txt_COSTNM_0" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','00')">
			<input id=txt_COSTCD_0   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>

		<!-- <td width="80px"  class="tab28" bgcolor="#eeeeee" align=center > 자산분류</td>  
	  <td width="120px" class="tab28" >&nbsp;
		</td>
		<td width="80px;"  class="tab28" bgcolor="#eeeeee" align=center >자산명</td> 
		<td class="tab28" >&nbsp;
		</td> -->

	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:538px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="30">
					<param name="Format"		value=" 
					<FC>Name='선택'	          ID=CHK   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	EditStyle=CheckBox  </FC> 
					<FC>Name='자산번호'			  ID=ASTNBR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center  edit=none  BgColor=#CCFFCC </FC>
					<FC> Name='자산명'			  ID=CDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  edit=none  BgColor=#CCFFCC </FC>
					<C> Name='원가명'				  ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left	  edit=none  BgColor=#CCFFCC </C>
					<C> Name='취득일자'			  ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  edit=none  BgColor=#CCFFCC Mask='XXXX/XX/XX'</C>
					<C> Name='내용\\년수'		  ID=ASTYUSE		HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center  edit=none  BgColor=#CCFFCC </C>
					<C> Name='취득금액'			  ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	  edit=none  BgColor=#CCFFCC </C>
					<C> Name='전기누계액'	    ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	 </C>
					<C> Name='당기상각액'	    ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=77  	align=right	 </C>
					<C> Name='당기누계액\\(전기+당기)' ID=ACDEPRSUM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	 edit=none </C>
					<C> Name='잔존가액'			  ID=ASTRMAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  edit=none </C>
					<C> Name='자산번호'			  ID=ASTNUM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right	show=false</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:540px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>

    <td width="320px">
			<table cellpadding="0" cellspacing="0" border="0" style="width:317px;height:370px;position:relative;left:3px;top:0px;border:1 solid #708090;">
				<tr>
					<td width="70px" height="25px" class="tab28"  bgcolor="#eeeeee" align=center >자산번호</td>
					<td class="tab22" colspan=3  >
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTNBR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
            <param name=Alignment	  	value=0>
						<param name=Border	      value=true>
            <param name=Format			  value="########">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">		
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				<tr>
					<td width="70px" height="25px" class="tab28"  bgcolor="#eeeeee" align=center >자산명</td>
					<td class="tab22" colspan=3>
					 <comment id="__NSID__">
          	<OBJECT id=gcem_CDNAM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:240px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
            <param name=GeneralEdit   value="true">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
        <tr>
					<td width="70px" height="25px" class="tab28"  bgcolor="#eeeeee" align=center >취득일자</td>
					<td width="115px" class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASAQSDAT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td width="49px" height="25px" class="tab27"  bgcolor="#eeeeee" align=center >내용<BR>년수</td>
					<td width="75px" class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTYUSE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
        
				<tr>
					<td height="25px" class="tab28"  bgcolor="#eeeeee" align=center >취득금액</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTAQAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px" class="tab27"  bgcolor="#eeeeee" align=center >외화($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTAQAMTY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=9>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				 
        <tr>
					<td height="25px" class="tab28"  bgcolor="#eeeeee" align=center >전기누계액</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ABDEPRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px" class="tab27"  bgcolor="#eeeeee" align=center >외화($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FOBDAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="0,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				
				<tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >당기상각액</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ACDEPRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px"   class="tab27" bgcolor="#eeeeee"  align=center >외화($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FOCDAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				 <tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >감가상각합</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px"   class="tab27" bgcolor="#eeeeee"  align=center >외화($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FOATAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >잔존가액</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTRMAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px"   class="tab27" bgcolor="#eeeeee"  align=center >외화($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FORMAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					 </td>
				 </tr>
				
        <tr>
					<td height="30px"   class="tab28" bgcolor="#eeeeee"  align=center >이체전<BR>상각년월</td>
					<td class="tab22"  >
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTYM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
            <param name=Format	      value="YYYY/MM">
					  <param name=ReadOnlyBackColor   value="#ccffcc">
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="30px"   class="tab27" bgcolor="#eeeeee"  align=center >최종<BR>상각년월</td>
					<td class="tab22"  >
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTYM2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
            <param name=Format	      value="YYYY/MM">
						<param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
		
         <tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >처리일자</td>
					<td class="tab22" colspan=3>
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTDAT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				<tr>
					<td height="50px"   class="tab28" bgcolor="#eeeeee"  align=center  >이체전<BR>원가코드</td>
					<td class="tab22" colspan=3> 
						<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:1px;width:50px; height:20px;"  class="txtbox"  >
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','01')">
						<input id="txt_COSTNM" type="text"  style= "position:relative;top:-2px;left:1px;width:130px;height:20px;" class="txtbox" >			
					</td>
				</tr>
				<tr>
					<td>
						<td width="70px" style="height:100%;border:0 solid #708090;" colspan=4 >&nbsp;
						<comment id="__NSID__">
							<OBJECT id=gcem_PREVYM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
							<param name=Visible       value="false">
						 </OBJECT>
						 </comment><script>__ws__(__NSID__);</script>
				 </td>
				</tr> 
			</table> 
    </td>
	</tr>
  <tr>
		<td colspan=2><BR>
		              * 등록상태가 이체상각미등록 일경우 이체전 상각년월은 이체 전 최종 감가상각 처리월을 입력합니다.<BR>
									* 등록상태가 이체상각미등록 일경우 전기누계액 또는 당기상각액, 이체전 상각년월을 입력해야합니다.<BR>
		              * 등록상태가 이체상각등록   일경우 상각년월은 최종 감가상각 처리월입니다. <BR>
                  * 처리일자는 현재 일자입니다. <BR>
									* 반드시 선택을 체크하고 저장해야 합니다.
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
		<C>Col=ACOSTCD    Ctrl=txt_COSTCD       Param=value</C>
		<C>Col=ASTAQAMTY  Ctrl=gcem_ASTAQAMTY   Param=text </C>
		<C>Col=FOBDAMT    Ctrl=gcem_FOBDAMT     Param=text </C>
		<C>Col=FOCDAMT    Ctrl=gcem_FOCDAMT     Param=text </C>
    <C>Col=FORMAMT    Ctrl=gcem_FORMAMT     Param=text </C>
    <C>Col=FOATAMT    Ctrl=gcem_FOATAMT     Param=text </C>
	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
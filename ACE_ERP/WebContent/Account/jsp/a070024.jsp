<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 채권가압류조회 
+ 프로그램 ID: a070024.jsp
+ 기 능 정 의	: 채권가압류조회 
+ 작  성   자  : 정 영 식
+ 작 성 일 자 : 2017.03.15
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a070024_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>채권가압류조회</title>

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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;

<%
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	gcra_usegb_0.codevalue ="1";
	//gcem_recdat_fr.text = gs_date2+"01";
	//gcem_recdat_to.text = gs_date;	
 }
 
<%
/******************************************************************************
	Description : 조회
	//검색조건
    //저장전 -   지점, 회계년월, 정산일자
    //저장후 -   지점, 회계년월, 지급일자  
******************************************************************************/
%>
function ln_Query(){ 
 
  	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070024_s1"
								     + "?v_str1=1" 
								 	 + "&v_str2="+txt_vend_nm_0.value   
								 	 + "&v_str3="+txt_vend_cd_0.value     
									 + "&v_str4="+gcem_vend_id_0.text;       
									     
	 //prompt('', gcds_code01.DataID);				
	gcds_code01.Reset();
}


<%
/******************************************************************************
	Description : 엑셀
******************************************************************************/
%>
function ln_Excel(){

}


<%
/******************************************************************************
	Description : 출력  
******************************************************************************/
%>
function ln_Print(){
	  
}


<%
/******************************************************************************
	Description : 거래처 (조회)
******************************************************************************/
%>
function ln_Popup_Vendcd(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0]="";
	arrParam[1]=txt_vend_nm_0.value;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		 arrParam = arrResult.split(";");
		 txt_vend_cd_0.value = arrParam[0];
		 txt_vend_nm_0.value = arrParam[1];
		 ln_usegb_format(arrParam[5],"0");
	} else {
		 txt_vend_cd_0.value = "";
		 txt_vend_nm_0.value = "";
    }
}

<%
/******************************************************************************
Description :
******************************************************************************/
%>
function ln_usegb_format(strVendid,strGB){

	intChk = strVendid.length;
	
	if(strGB=="0"){
		
		if(intChk==10){ //
			gcem_vend_id_0.Format= "000-00-00000";    //법인 
			gcra_usegb_0.codevalue="1";
		}else if(intChk==13){
			gcem_vend_id_0.Format= "000000-0000000";  //개인 
			gcra_usegb_0.codevalue="2";
		}
		
		gcem_vend_id_0.text = strVendid;
		
	}else{
		
		if(intChk==10){ //
			gcem_vend_id.Format= "000-00-00000";    //법인 
		}else if(intChk==13){
			gcem_vend_id.Format= "000000-0000000";  //개인 
		}
		
		gcem_vend_id.text = strVendid;
		
	}
}


<%
/******************************************************************************
	Description : 추가  
******************************************************************************/
%>
function ln_Add(){
	
}

<%
/******************************************************************************
	Description : 출력 DataSet head
******************************************************************************/
%>

function ln_SetDataHeader(){

}



<%
/******************************************************************************
	Description : 체크  
******************************************************************************/
%>
function ln_Chk(){

 
}

<%
/******************************************************************************
	Description : 저장 
******************************************************************************/
%>
function ln_Save(){
}


<%
/******************************************************************************
	Description : 공탁, 해지일 체크 
	수정 : 2017.03.03 채권(가)압류 - 1, 2 일 경우 공탁일자 입력가능  by 오연주
	
******************************************************************************/
%>
function ln_Chk_Credgb(){

}

<%
/******************************************************************************
	Description : 삭제 
******************************************************************************/
%>
function ln_Delete(){


}





</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- 가압류현황 조회  -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"    VALUE="false">
	<param name=SubSumExpr    value="1:VEND_CD">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
     ft_cnt01.innerText="데이타 조회중입니다.";
   	 document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
    var icnt=0;

   	if(gcds_code01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else {
	  	ft_cnt01.innerText = "조회건수 : " + gcds_code01.RealCount(1,row) + " 건";
	}
 
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
</script>
 

<!-----------------------------------------------------------------------------
    	G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcra_usegb_0 event=OnSelChange()>

	if(gcra_usegb_0.codevalue=="1"){ //
		gcem_vend_id_0.Format = "000-00-00000";        //법인 
	}else if(gcra_usegb_0.codevalue=="2"){
		gcem_vend_id_0.Format = "000000-0000000";  //개인 
	}
	
</script>

<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
		T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td width="860px" align="right" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand;position:relative;top:-2px"  onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">

	<tr> 
		<td width="100px;" class="tab25"  bgcolor="#eeeeee" align=center>거래처명(채무자)</td> 
		<td class="tab24" >&nbsp;
			<comment id="__NSID__">
			<input id="txt_vend_nm_0" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:180px;height:20px;" maxlength="36" >
			<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Vendcd();">
			<input id="txt_vend_cd_0" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td class="tab18" width="90px;" bgcolor="#eeeeee" align="center">번호구분</td>
		<td class="tab18" width="160px"  ><comment id="__NSID__">
			<object id=gcra_usegb_0 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:160px;height:20px" >
				<param name=Cols	value="2">
				<param name=Format	value="1^사업자번호,2^주민번호">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td class="tab18" width="60px;" bgcolor="#eeeeee" align="center">번호</td>
		<td class="tab18" width="90px"  Style="height:20px;;"><nobr>&nbsp;<comment id="__NSID__">
			<object  id=gcem_vend_id_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-2px;top:3px">		
				<param name=Text		   value="">
				<param name=Alignment      value=0>
				<param name=Border         value=true>
				<param name=Numeric        value=false>
				<param name=Format         value="000-00-00000">
				<param name=PromptChar     value="">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor   value=false>
				<param name=readOnly       value=false>
		   </object></comment><script>__ws__(__NSID__);</script>
		</td>
		
	</tr>
</table>

<table id="div_disp1"  width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;top:2px;width:858px; height:430px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"     value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	      value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='거래처'	              ID=VEND_CD	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}  show =false</C>
					<C> Name='거래처명(채무자)'      ID=VEND_NM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=150    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='사업자번호'		      ID=VEND_ID	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXX-XX-XXXXX'</C>
					<C> Name='채권자 '			  ID=CREDITOR	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} Value={Decode(curlevel,1,'소  계',CREDITOR)}</C>
					<C> Name='청구금액'             ID=DEMAMT       HeadAlign=Center HeadBgColor=#B9D4DC Width=80     align=right	  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='접수일자'             ID=RECDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX' </C>
					<C> Name='공탁일자'             ID=DEPDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} MASK='XXXX/XX/XX'  </C>
					<C> Name='채권구분'	          ID=CREDGB   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=125    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} EditStyle=Combo  Data='1:채권가압류,2:채권압류 및 추심명령,3:공탁,4:해지'</C>
					<C> Name='비고'	        	  ID=REMARK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=110    align=left    SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>




<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
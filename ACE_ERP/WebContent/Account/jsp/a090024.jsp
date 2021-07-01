<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산변경관리
+ 프로그램 ID	: A090024.html
+ 기 능 정 의	: 자산대장 조회 화면
+ 작  성   자 : 정 영 식
+ 작 성 일 자 : 2011.08.01
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090024_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자산변경관리</title>

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
var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_fdcode= gfdcode;

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
	gclx_sys_fr.index=0; //상태구분
 }

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

  //ln_Find_ym();
   	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090024_s2"
									     + "?v_str1="+gclx_fdcode.BindColVal             //지점
										 + "&v_str2="+gclx_asdivcod.BindColVal           //자산분류
										 + "&v_str3="+gcem_jasan.text                    //자산명코드									
										 + "&v_str4="+gclx_sys_fr.bindcolval             //상태  
										 + "&v_str5="+txt_COSTCD.value;                  //원가코드
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
	gcgd_disp01.GridToExcel("자산변경관리","",2);
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

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../common/img/com_t_bg.gif"  align=left ><img src="../img/a090024_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_b_excel.gif"	 style="cursor:hand;" onclick="ln_Excel()"> 
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
		
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center> 상태</td>  
	  <td width="120px" class="tab28" colspan =3>&nbsp;
			<comment id="__NSID__">
				<OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
					<param name=CBData					value="^전체,1^매각,2^폐기,3^자본적지출"">
					<param name=CBDataColumns		value="Code, Parm">
					<param name=SearchColumn		value="Parm">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="Parm^0^120">
					<param name=BindColumn			value="Code">
					<param name=XPStyle         value=true>
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

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="False"> 
					<param name=TitleHeight   value="30">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<FC>Name='자산번호'			ID=ASTNBR			HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center SumBgColor=#C3D0DB sumtext=''      sort=true  </FC>
					<FC>Name='자산명'			  ID=ASTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left	 SumBgColor=#C3D0DB sumtext=''      sort=true  SumTextAlign=center </FC>
					<FC>Name='원가명'			  ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left	 SumBgColor=#C3D0DB sumtext=''      sort=true  SumTextAlign=center </FC>
					<C> Name='변경일자'			ID=CHGDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	  align=center SumBgColor=#C3D0DB sumtext=''      sort=true  MASK='XXXX/XX/XX'</C>
					<C> Name='변경구분'			ID=CHGTYPE		HeadAlign=Center HeadBgColor=#B9D4DC Width=75 	align=center SumBgColor=#C3D0DB sumtext='계'    sort=true  EditStyle=Combo		Data='0:정상,1:매각,2:폐기,3:자본적지출' </C>
					<C> Name='변경금액1'		ID=CHGAMT  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					<C> Name='변경금액2'	  ID=CHGAMT2  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					<C> Name='변경금액3'	  ID=CHGAMT3  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'  sort=true </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
  <tr>
		<td colspan=2><BR>
		              * 매각          : 변경금액1 - 매각금액,     변경금액2 - 유형자산 처분손실, 변경금액3 - 유형자산 처분이익 <BR>
					  * 폐기          : 변경금액1 - 폐기금액,     변경금액2 - 유형자산 폐기손실, 변경금액3 - 잡수익 <BR>
		              * 자본적지출 : 변경금액1 - 자본적지출금액, 변경금액2 - 취득금액  <BR>
    </td>
  </tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
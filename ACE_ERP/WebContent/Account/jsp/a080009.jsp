<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  예산관리 - 일반관리비현황2
+ 프로그램 ID	:  A080009.jsp
+ 기 능 정 의	:  
+ 작   성  자 :  YS.JEONG
+ 수 정 일 자 :  2014.03.10
-----------------------------------------------------------------------------
+ 수 정 내 용 :	    
+ 수   정  자 :  
+ 수 정 일 자 :  
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>


<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>일반관리비현황</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //년월
var gs_date3 = gcurdate.substring(0,4); //년
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;


/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	ln_Before();
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_frmonth.bindcolval="01";
	gclx_tomonth.bindcolval=gcurdate.substring(5,7);

}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){

  if(fn_trim(gcem_yyyy.text)==""){
		alert("년도를 입력하십시요.");
		return false;
	}

  if(gclx_frmonth.bindcolval==""){
		alert("FROM 월을 선택하십시요.");
		return false;
	}

	 if(gclx_tomonth.bindcolval==""){
		alert("TO 월을 선택하십시요.");
		return false;
	}
	
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080009_s1?v_str1="+gclx_fdcode.bindcolval
																		 +"&v_str2="+gcem_yyyy.text+gclx_frmonth.bindcolval
																		 +"&v_str3="+gcem_yyyy.text+gclx_tomonth.bindcolval
																		 +"&v_str4="+gcem_atkornam.text
																		 +"&v_str5="+gcem_atcode.text;
																		

	//prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									

}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : 저장
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : Dataset Head 설정 
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(p){

}

/******************************************************************************
	Description : 출력 - Header Set
******************************************************************************/
function ln_PrintHeader() {

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

	//gcgd_disp01.ExportFile('구분손익계산서',true)
	gcgd_disp01.GridToExcel("일반관리비현황2","",2);
	//gcgd_disp01.RunExcel("일반관리비현황")
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  
	//지점
	gcem_yyyy.text = gs_date3; //년월
	//gcem_dateto.text = gs_date2;
	
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();


}

/******************************************************************************
	Description : 조회한 데이타의 포맷을 다시 설정함.
	parameter   : gcds_disp01 -> gcds_temp01
******************************************************************************/
function ln_Data_Reset(p){

}

/******************************************************************************
	Description : 팝업
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]='ATUSEYN';
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode.text = arrResult[0];
		gcem_atkornam.text = arrResult[1];
	}else{
        gcem_atcode.value="";
		gcem_atkornam.value="";
	}
}

/******************************************************************************
	Description : 계정초기화
  parameter   : 
******************************************************************************/
function ln_Clear(){
	gcem_atkornam.text="";
  gcem_atcode.text="";
}



/***********************************************************************************************
	Description : 일반관리비현황 팝업
	parameter   : sfdcode-지점코드, sfdcodenm-지점코드명 
	              sfrymd -from회계일자, stoymd - to회계일자
								satcode-계정코드, satcodenm-계정코드명 
**********************************************************************************************/
function ln_Popup2(sfdcode,sfdcodenm,sfrymd,stoymd,satcode,satcodenm,xsatcode){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0] = sfdcode;			
	arrParam[1] = sfdcodenm;
	arrParam[2] = sfrymd;
	arrParam[3] = stoymd;
	arrParam[4] = satcode;	
	arrParam[5] = satcodenm;	
	arrParam[6] = xsatcode;	

	strURL = "./a080009_popup.jsp";
	strPos = "dialogWidth:810px;dialogHeight:450px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!--(총)원가별비용명세서 조회  -->
<comment id="__NSID__">
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_crossTab classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=Logical    value=true>
	<param name=DataID     value=gcds_data01>
	<param name=GroupExpr  value="ATCODE:PRTNAM,BGTDPTNM,AMT">
</object></comment><script>__ws__(__NSID__);</script> 

<!--지점  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
  
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
  
  if(colid=="ATCODE"||colid=="PRTNAM"||colid=="SUM") return;

	//월말일자 
	var endday ="";
	var intyyyy=0;
	var intchk=0;
 	if (gclx_tomonth.bindcolval=="01"||gclx_tomonth.bindcolval=="03"||gclx_tomonth.bindcolval=="05"||gclx_tomonth.bindcolval=="07"
	  ||gclx_tomonth.bindcolval=="08"||gclx_tomonth.bindcolval=="10"||gclx_tomonth.bindcolval=="12"){
		endday ="31";
	}else if(gclx_tomonth.bindcolval=="02") {
        endday ="28";
		intyyyy = gcem_yyyy.text;
        intchk=intyyyy%4;
		if(intchk==0) endday ="29";
    }else{
        endday ="30";
	}
	
	var sfdcode		  = gclx_fdcode.bindcolval;								             //지점코드
    var sfdcodenm     = gclx_fdcode.text;                                                     //지점명
	var sfrymd	      = gcem_yyyy.text+gclx_frmonth.text+"01";	                //검색일자 fr
	var stoymd	      = gcem_yyyy.text+gclx_tomonth.text+endday;            //검색일자 to
	var satcode		  = gcds_crossTab.namevalue(row,"ATCODE");	        //계정코드
	var satcodenm     = gcds_crossTab.namevalue(row,"PRTNAM");	        //계정코드명
	
	//계정코드 찾기 
	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080007_s2?v_str1="+satcode
												                          +"&v_str2="+gcem_yyyy.text+gclx_tomonth.bindcolval
																																															
	//prompt("",gcds_data02.DataID );																							
	gcds_data02.Reset();									
	
	var xsatcode	  = gcds_data02.namevalue(gcds_data02.rowposition,"BATCODE");	        //계정코드

	ln_Popup2(sfdcode,sfdcodenm,sfrymd,stoymd,satcode,satcodenm,xsatcode);	
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a080007_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right">&nbsp;
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>지점코드</td>
				<td class="tab18" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
						<param name=enable			    value="false">

					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>년도</td>
				<td class="tab18" style="height:30px;width:100px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:40px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>월</td>
                <td class="tab18" style="height:30px;width:400px;" >&nbsp;<nobr>
					<comment id="__NSID__">
					<object  id=gclx_frmonth classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69	style="position:relative;left:0px;top:2px;font-size:12px;width:60px;">
					<param name=CBData			   value="01^01월,02^02월,03^03월,04^04월,05^05월,06^06월,07^07월,08^08월,09^09월,10^10월,11^11월,12^12월">
					<param name=CBDataColumns	 value="CODE,NAME">
					<param name=SearchColumn	 value=NAME>
					<param name=Sort			     value=false>
					<param name=ListExprFormat value="NAME">								
					<param name=BindColumn		 value="CODE">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~&nbsp;  
					<comment id="__NSID__">
					<object  id=gclx_tomonth classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69	style="position:relative;left:0px;top:2px;font-size:12px;width:60px;">
					<param name=CBData			   value="01^01월,02^02월,03^03월,04^04월,05^05월,06^06월,07^07월,08^08월,09^09월,10^10월,11^11월,12^12월">
					<param name=CBDataColumns	 value="CODE,NAME">
					<param name=SearchColumn	 value=NAME>
					<param name=Sort			     value=false>
					<param name=ListExprFormat value="NAME">								
					<param name=BindColumn		 value="CODE">
					</object></comment><script>__ws__(__NSID__);</script>  
			</tr>
			
			<tr>
				<td class="tab17" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>계정과목</td>
				<td class="tab19" style="width:120px" colspan=5><nobr>				
					<comment id="__NSID__"><object  id=gcem_atkornam classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:5px;" onkeydown="ln_Onblur('02','fr','gcem_atkornam')";">
			      <param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:0px" align=center onclick="ln_Popup();">
					<comment id="__NSID__"><object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:5px;">
			      <param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					&nbsp;
					<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Clear();">
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>  

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_crossTab">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
                             <param name="Editable"    value="true">
							<param name=ColSizing     value="true">
							<param name=ViewSummary   value="1">
							<PARAM NAME="Format"			VALUE="  
								<F> ID=ATCODE   Title='계정코드' 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show=false</F> 
								<F> ID=PRTNAM   Title='계정과목' 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left sort=false  SumBgColor=#C3D0DB sumtext='합계'</F> 
								<FC>ID=SUM	name='계'	 HeadAlign=Center HeadBgColor=#B9D4DC width=100	Bgcolor='#E3E3FF'	Value={CrossTabSum(AMT)}	Align=Right   SumBgColor=#C3D0DB SumText={sum(CrossTabSum(AMT))}</FC>
								<R>
									<C>ID=AMT_$$    name={(xkeyname_$$)},  value={Number(AMT_$$)} HeadAlign=Center HeadBgColor=#B9D4DC  width=99  SumBgColor=#C3D0DB  sumtext={sum(AMT_$$)}   </C>
								</R>

								">
					</object></comment><script>__ws__(__NSID__);</script> 
					
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">조회건수 :</font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  원가관리 - 원가별비용명세서
+ 프로그램 ID	:  A100004.html
+ 기 능 정 의	:  
+ 작   성  자 :  YS.JEONG
+ 수 정 일 자 :  2006.09.19
-----------------------------------------------------------------------------
+ 수 정 내 용 :	    
+ 수   정  자 :  
+ 수 정 일 자 :  
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>구분손익계산서</title>

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
	
}

/******************************************************************************************
	Description : 조회
******************************************************************************************/
function ln_Query(){
	
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a100005_s1?v_str1="+gclx_fdcode.bindcolval
																									 +"&v_str2="+gcem_datefr.text
																									 +"&v_str3="+gcem_dateto.text
																									 +"&v_str4="+gclx_place.bindcolval
																									 +"&v_str5="+txt_costcd_fr.value
																									 +"&v_str6=";																															
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
gcgd_disp01.GridToExcel("구분손익계산서","",2);
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
  
	//지점
	gcem_datefr.text = gs_date3+"01"; //년월
	gcem_dateto.text = gs_date2;
	
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

  //사업장
	gcds_place.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2159"; 
	//prompt("", gcds_place.DataID);
	gcds_place.Reset();
}

/******************************************************************************
	Description : 조회한 데이타의 포맷을 다시 설정함.
	parameter   : gcds_disp01 -> gcds_temp01
******************************************************************************/
function ln_Data_Reset(p){

}

/******************************************************************************
	Description : 원가팝업
  parameter   : 
******************************************************************************/
function ln_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  arrParam[0]="0030";//원가코드

	if(gclx_place.bindcolval!=""){
		arrParam[1]=gclx_place.bindcolval;//사업장코드
  }else{
    arrParam[1]="";
	}

	if(txt_costnm_fr.value==""){
		 arrParam[2]="";
	}else{
     arrParam[2]=txt_costnm_fr.value;
	}

	if(txt_costcd_fr.value==""){
     arrParam[3]="";
	}else{
     arrParam[3]=txt_costcd_fr.value;
	}

	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_costcd_fr.value =arrResult[0];
		txt_costnm_fr.value = arrResult[1];
	}else{
    txt_costcd_fr.value="";
		txt_costnm_fr.value="";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--(총)원가별비용명세서 조회  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_crossTab classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=Logical    value=true>
	<param name=DataID      value=gcds_data01>
	<param name=GroupExpr   value="ATCODE:PRTNAM,FSREFNM,AMT">
</object></comment><script>__ws__(__NSID__);</script> 

<!--지점  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--사업장  -->
<comment id="__NSID__"><object  id=gcds_place classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
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
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
  
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_place" event="onloadCompleted(row,colid)">
	gcds_place.InsertRow(1);
	gcds_place.NameValue(1,"CDCODE")="";
	gcds_place.NameValue(1,"CDNAM")="전체";
	gclx_place.index=0;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a100005_head.gif"></td>
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
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>기&nbsp;&nbsp;&nbsp;간</td>
				<td class="tab18" style="height:30px;width:520px;" colspan=3>&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					~
					<comment id="__NSID__"><object  id=gcem_dateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				
			</tr>
			
			<tr>
				<td class="tab17" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>사 업 장</td>
				<td class="tab19" style="width:120px"><nobr>
					<comment id="__NSID__"><object  id=gclx_place classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_place">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="CDNAM^0^110">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
        <td class="tab19" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>원&nbsp;&nbsp;&nbsp;가</td>
				<td class="tab19" width="490px" colspan=3>
				  <nobr>
					<input id="txt_costnm_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup();">
					<input id="txt_costcd_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
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
                            <param name="Editable"    value="false">
							<param name=ColSizing  value="true">
							<PARAM NAME="Format"			VALUE="  
								<F> ID=ATCODE   Title='계정코드' 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false show=false</F> 
								<F> ID=PRTNAM   Title='계정과목' 	 HeadAlign=Center   HeadBgColor=#B9D4DC Width=160 align=left sort=false</F> 
								<FC>Id=Sum	name='계'	 HeadAlign=Center HeadBgColor=#B9D4DC width=100	Bgcolor='#E3E3FF'	Value={CrossTabSum(AMT)}	Align=Right </FC>
	                            <R>
									<C>ID=AMT_$$   name={mid(xkeyname_$$,8)},  value={decode(xkeyname_$$, '', 'AA', AMT_$$)} HeadAlign=left HeadBgColor=#B9D4DC  width=200  </C>
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
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_temp01">
	<param name="DetailDataID"			value="gcds_temp01">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=558 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=71 ,top=402 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=556 ,right=1942 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정과목' ,left=82 ,top=415 ,right=553 ,bottom=550 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=402 ,right=71 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=402 ,right=564 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=402 ,right=1249 ,bottom=558 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=402 ,right=1942 ,bottom=556 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURKISU', left=640, top=407, right=1201, bottom=474 ,mask='제 XX(당)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREKISU', left=1323, top=407, right=1881, bottom=474 ,mask='제 XX(전)기', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=564 ,top=479 ,right=1942 ,bottom=479 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='금 액' ,left=640 ,top=492 ,right=1201 ,bottom=540 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금 액' ,left=1328 ,top=492 ,right=1879 ,bottom=540 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='KISU1', left=503, top=191, right=1564, bottom=233, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KISU2', left=503, top=238, right=1564, bottom=280, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='(단위 : 원)' ,left=1722 ,top=349 ,right=1934 ,bottom=394 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=71, top=347, right=566, bottom=392, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='XRTTOT', left=918, top=0, right=1244, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='XLTTOT', left=572, top=0, right=902, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='YLTTOT', left=1259, top=3, right=1588, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRTNAM', left=85, top=5, right=553, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=0 ,right=564 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='YRTTOT', left=1606, top=0, right=1931, bottom=48, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='PRTTIME', left=71, top=11, right=849, bottom=56, align='left' ,mask='출력일자 : XXXX/XX/XX   출력시간 : XX:XX XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='#p / #t' ,left=873 ,top=53 ,right=1140 ,bottom=101 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
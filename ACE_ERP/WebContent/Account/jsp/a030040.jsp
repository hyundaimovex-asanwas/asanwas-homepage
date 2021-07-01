<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 원가데이터 비교 
+ 프로그램 ID	: 
+ 기 능 정 의	: 조회
+ 최 초 이 력	: 정영식
+ 서 블 릿 명	: 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>원가데이터 비교</title>
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


gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}
/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 
	gcem_actyymm.text  = gs_date2;	//회계년월	
	
	gcem_actyymm.text  = "201901";	//회계년월	
	//txt_atcode_fr.value="4332300";
	//gclx_fsrefcd.bindcolval ="0030";
	//gcem_fsrefval_fr.text="190111";
	
	
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset(); //지점코드
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030040_s1?v_str1="+gclx_fdcode.bindcolval
																		 +"&v_str2="+gcem_actyymm.text
																		 +"&v_str3="+txt_atcode_fr.value
																		 +"&v_str4="+gclx_fsrefcd.bindcolval
																		 +"&v_str5="+gcem_fsrefval_fr.text; 
	gcds_data1.Reset(); 
	
	
	
	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030040_s2?v_str1="+gclx_fdcode.bindcolval
																		 +"&v_str2="+gcem_actyymm.text
																		 +"&v_str3="+txt_atcode_fr.value
																		 +"&v_str4="+gclx_fsrefcd.bindcolval
																		 +"&v_str5="+gcem_fsrefval_fr.text; 
	gcds_data2.Reset(); 
	
}

/******************************************************************************
	Description : 엑셀다운로드
******************************************************************************/
function ln_Excel(){ 
	gcgd_data2.GridToExcel("계정별비교","",2);
}



/******************************************************************************
	Description : 결재 전 계정팝업
	parameter   : 
******************************************************************************/
function ln_Popup_Atcode(p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	arrParam[1]=txt_atkornam_fr.value;
	arrParam[2]="";
	
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	
	if(arrResult != null) {
		arrParam = arrResult.split(";");
	
		txt_atcode_fr.value = arrParam[0];
		txt_atkornam_fr.value = arrParam[1];
	
		//계정코드로 관리항목 찾기 2007.05.23 추가(정영식)
		gcds_fsrefcd.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020012_s2?v_str1="+txt_atcode_fr.value+"&v_str2="+txt_atcode_fr.value;
		gcds_fsrefcd.Reset();
	
	}else{
		
		txt_atcode_fr.value = "";
		txt_atkornam_fr.value = "";
	
	}
}


/******************************************************************************
	Description : 관리항목값 찾기
	parameter   : 
******************************************************************************/
function ln_Popup_fsrefval(p){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	if(gclx_fsrefcd.bindcolval=="0020"){
		alert("관리항목 선택 후 찾기 가능합니다.");
		return false;
	}
	
	if(gclx_fsrefcd.bindcolval=="0020"){//부서코드나 거래처
		strURL = "./gczm_vender_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
	}else if(gclx_fsrefcd.bindcolval=="0002"){
		strURL = "./hcdept_popup.jsp";
	  	strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
	}else{
		if(gcds_fsrefcd.namevalue(gcds_fsrefcd.rowposition,"TYPE")=="C"){//필드입력
	    	result = null;
		}else{
			arrParam[0] = gclx_fsrefcd.bindcolval;
			arrParam[1] = "";
			  
			if(gclx_fsrefcd.bindcolval=="0003"){//예산 
			  arrParam[2] = "";
			}  
			strURL = "./commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);
		}
	}
	
	if (result != null) {
	  	arrResult = result.split(";");
		gcem_fsrefval_fr.text = arrResult[0];
		txt_fsrefvalnm_fr.value = arrResult[1];

	} else {
  		gcem_fsrefval_fr.text = "";
	    txt_fsrefvalnm_fr.value = "";
	}
}
     
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드 -->
</object> 

<object  id="gcds_data1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 총합계 -->
</object> 

<object  id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 원가별비교 -->
</object>

<object  id="gcds_fsrefcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 원가별비교 -->
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(rowcount)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="A";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script>


<script language="javascript" for="gcds_data1" event="onloadCompleted(rowcount)">
    alert("rowcount:::"+rowcount);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <!-- <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030030_head.gif"></td> -->
    <td background="../../Common/img/com_t_bg.gif"> <font size="2"><strong> * 원가데이터 비교</strong></font></td>
    <td width="880" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" height="47">&nbsp;
		  <img name="btn_query" src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand;" onclick="ln_Excel()">&nbsp;
		  <img name="btn_query" src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;" onclick="ln_Query()">&nbsp;
	</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td width="70px"  class="tab15" bgcolor="#eeeeee"><nobr>&nbsp;지점코드&nbsp;</nobr></td>
					<td width="300px;" class="tab18"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat		value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="70px"  class="tab18" bgcolor="#eeeeee"><nobr>&nbsp;회계년월&nbsp;</nobr></td>
					<td class="tab18"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_actyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="####/##">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
				</tr>
				<tr> 
					<td width="70px"  class="tab17" bgcolor="#eeeeee"><nobr>&nbsp;계정코드&nbsp;</nobr></td>
					<td width="300px;" class="tab19"><nobr>
						<input id="txt_atkornam_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:170px;height:20px;" maxlength="36" >
						<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('fr');">
						<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >	
						</nobr>
					</td>  
					<td width="70px"  class="tab17" bgcolor="#eeeeee"><nobr>&nbsp;관리항목&nbsp;</nobr></td>
					<td class="tab19"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:3px;font-size:12px;width:150px;">
								<param name=ComboDataID			value="gcds_fsrefcd">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^170">
								<param name=BindColumn			value=CDCODE>
						</object>

						<object  id=gcem_fsrefval_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:95px;height:20px;position:relative;left:5px;top:3px">		
							<param name=Text		 value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="">
							<param name=PromptChar    value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object>&nbsp;
						
						<input id="txt_fsrefvalnm_fr" type="text" class="txtbox"  style= "position:relative;left:3px;top:-5px;width:200px;height:20px;" maxlength="36" >
						
						</nobr>
						</comment><script>__ws__(__NSID__);</script> 
					  
						<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:5px;top:3px" align=center onclick="ln_Popup_fsrefval('fr');">
				
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:5px;top:3px;cursor:hand;">&nbsp;</nobr>
					</td>
				</tr>
				
				
			</table>
		</td>
  </tr>
  <tr><td height=3 colspan="2"></td></tr>
  <tr> 
    <td colspan="2">

		<!--총합계-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">  
			    <td height=15>
					<font size="2" color=""><b>[합계]</b></font>
				</td>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:60;width:1000" >
							<PARAM NAME="DataID"		VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false"> 
							
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
							    <G>Name='전표', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=FDEAMT,	Name='차변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=FCRAMT,	Name='대변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
								<G>Name='계정원장', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	Name='차변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=CRAMT,	Name='대변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
								<G>Name='일집계', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DETOT,	Name='차변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=CRTOT,	Name='대변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>			
								<G>Name='월집계', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=MDETOT,	Name='차변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=MCRTOT,	Name='대변합계',width=125, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr><td height=10></td></tr>
			</table>
       </td>
   </tr>    
   <tr>
       <td colspan="2">
		 <!--계정별 비교-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">
			    <tr>
					<td height=10>
						<font size="2" color=""><b>[계정별 비교]</b></font>
					</td>
				</tr>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data2"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:318;width:1000" >
							<PARAM NAME="DataID"		VALUE="gcds_data2">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="true">
						    <param name="ViewSummary"	value=1> 
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
							    <G>Name='원가', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=FSREFVAL	 Name='원가코드', width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center  SumBgColor=#C3D0DB suppress=4</C>
								<C>ID=COSTNM   Name='원가명',  width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    SumBgColor=#C3D0DB suppress=3 </C>
								</G>
								<G>Name='계정', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=ATCODE	 Name='계정코드',width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center  SumBgColor=#C3D0DB  suppress=2 </C>
								<C>ID=ATKORNAM   Name='계정명',  width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    SumBgColor=#C3D0DB  suppress=1 </C>
								</G>
								<G>Name='차변', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=FDEAMT,	Name='전표',     width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')} SumText =@sum</C>
								<C>ID=DEAMT,	Name='원장',     width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')} SumText =@sum</C>
								<C>ID=DETOT,	Name='일집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')} SumText =@sum</C>
								<C>ID=MDETOT,	Name='월집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')} SumText =@sum</C>
								</G>
								<G>Name='대변', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=FCRAMT,	Name='전표',     width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')} SumText =@sum</C>
								<C>ID=CRAMT,	Name='원장',     width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')} SumText =@sum</C>
               					<C>ID=CRTOT,	Name='일집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')} SumText =@sum</C>
								<C>ID=MCRTOT,	Name='월집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')} SumText =@sum</C>
								</G>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:1000;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt2 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
      </td>
   </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  감가대상처리화면
+ 프로그램 ID	:  asetdep.jsp
+ 기 능 정 의	:  감가대상처리
+ 작   성  자 :  임 형주
+ 작 성 일 자 :  
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 감가상각 프로시저 변경   
+ 수   정  자 :  정영식 
+ 수 정 일 자 :  2009.10.21
-----------------------------------------------------------------------------
+ 서 블 릿 명	: Asetdep_popup_s1,Asetdep_popup_s2
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>감가상각처리(계산)</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_hisdat = gs_date;
var gs_asdspsts = "3";
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){
  
	ln_Before();
}

/******************************************************************************
	Description : 선 조회
******************************************************************************/
function ln_Before() {

	//지점코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//자산분류[검색]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();

	//상각년월기본setting
	//gcem_hisdat_fr.text = gs_date2;
	//gcem_sang_dat.text = gs_date;

	gclx_fdcode.bindcolval = gs_fdcode;
	gcrd_gubun.codevalue=1;
	gcem_sang_dat.style.background="pink";
}

/******************************************************************************
	Description : 조회  
******************************************************************************/
function ln_Query(){ 
	
	if(fn_trim(gcem_sang_dat.text)=="") {
		alert("상각년월 입력하십시오");
		gcem_sang_dat.Focus();
		return;
	}

	var str1 = gclx_fdcode.BindColVal;              //소속
	var str2 = gclx_asdivcod.BindColVal;            //자산분류
	var str3 = gcem_sang_dat.text.substr(0,6);		//상각년월
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>asetdep_popup_s12"
					   + "?v_str1="+str1
					   + "&v_str2="+str2
					   + "&v_str3="+str3
					   + "&v_str4="+gcrd_gubun.codevalue;
	gcds_code01.Reset(); 
}

/******************************************************************************
	Description : 저장 (감가상각처리)
******************************************************************************/
function ln_Save(){
	
	if(!ln_Chk())return;

	if(!ln_Chk2())return; 

	if(!ln_Chk3())return; 
	
	var str1 = gclx_fdcode.BindColVal;             //지점          
	var str2 = gcem_sang_dat.text;                 //감가상각년월  
	var str3 = gcem_sang_dat.text.substring(0,4);	 //감가상각년    
	var str4 = gcem_sang_dat.text.substring(4,6);  //감가상각월    
	var str5 = 'N';												         //성공구분 Y/N  

	if (confirm(str3+"년 "+str4+'월 감가상각 계산을 하시겠습니까?')) {
		gcds_create.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>asetdep_popup_sp"
						   + "?v_str1="+str1+"&v_str2="+str2
						   + "&v_str3="+str3+"&v_str4="+str4
						   + "&v_str5="+str5;
		gcds_create.Reset();
	}
//	var row = gcds_code01.rowposition;
//	if (confirm("전송하시겠습니까?")){	
	
//			window.returnValue =   gcds_code01.namevalue(row,"ASNBR") + ";"  //자산번호
//   									+ gcds_code01.namevalue(row,"ASNAM") + ";"  //자산명
//									+ gcds_code01.namevalue(row,"CURSUMAMT") + ";" //상가누계액
//	} 

}

/******************************************************************************
	Description : 취소 (감가상각취소)
******************************************************************************/
function ln_Cancel(){
	/*
	var str1 = gclx_fdcode.BindColVal;                //소속
	var str2 = gclx_asdivcod.BindColVal;              //자산분류
	var str3 = gcem_sang_dat.text.substr(0,6);;       //상각년월
	var str4 = gcem_sang_dat.text;                    //감가상각처리일
	var str5 = 'N';
	*/
 	if(!ln_Chk())return;

	var str1 = gclx_fdcode.BindColVal;             //지점          
	var str2 = gcem_sang_dat.text;                 //감가상각년월  
	var str3 = gcem_sang_dat.text.substring(0,4);	 //감가상각년    
	var str4 = gcem_sang_dat.text.substring(4,6);  //감가상각월    
	var str5 = 'N';												         //성공구분 Y/N  
	
	if (confirm(str3+"년 "+str4+'월 감가상각 계산을 취소 하시겠습니까?')) {
		gcds_cancel.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>asetdep_popup_sp2"
									     + "?v_str1="+str1+"&v_str2="+str2
									     + "&v_str3="+str3+"&v_str4="+str4
									     + "&v_str5="+str5;	
		gcds_cancel.Reset();
	}
}

/******************************************************************************
	Description : 체크
******************************************************************************/
function ln_Chk(){
  	var strYear="";
	var strMonth="";

  	if(gclx_fdcode.BindColVal==""){
		alert("소속코드를 입력하세요.");
		return false;
	}

	if(fn_trim(gcem_sang_dat.text)=="") {
		alert("상각년월을 입력하세요");
		gcem_sang_dat.focus();
		return false;
	}

	strYear = gcem_sang_dat.text.substring(0,4);
  	strMonth = gcem_sang_dat.text.substring(4,6);

	//월 마감을 했을 경우 상각처리도 못 함...
	//월마감 체크
  	gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astFinish_chk_s1"
									+ "?v_str1="+gclx_fdcode.BindColVal+"&v_str2=1"
									+ "&v_str3="+strYear+"&v_str4="+strMonth;
	gcds_chk.Reset(); 

  	if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		alert(strYear+"년 "+strMonth+"월은 마감되었습니다. 감가상각 계산을 할 수 없습니다.");
		return false;
	}

	return true; 
}


/******************************************************************************
	Description : 해당월 상각처리 할 때 기존에 상각 처리 했는지 체크함.
******************************************************************************/
function ln_Chk2(){
	var str1 = gclx_fdcode.BindColVal;             //지점          
	var str2 = gcem_sang_dat.text;                 //감가상각년월  
	var str3 = gcem_sang_dat.text.substring(0,4);	 //감가상각년    
	var str4 = gcem_sang_dat.text.substring(4,6);  //감가상각월    

	gcds_chk2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>asetdep_popup_chk_s1"
								  + "?v_str1="+str1+"&v_str2="+str2;

	gcds_chk2.Reset();
	
  	if(gcds_chk2.namevalue(gcds_chk2.rowposition,"CNT")>=1){
		alert(str3+"년 "+str4+"월은 감가상각 되었습니다. 상각취소 후 감가상각 계산을 할 수 있습니다.");
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 취득일자와 상각일자를 비교하여 상각일자가 더 작을 경우 체크
******************************************************************************/
function ln_Chk3(){
  var strASAQSYM=""; //취득년월
	var strSANGYM =  gcem_sang_dat.text.substring(0,6); // 상각년월

	for(i=1;i<=gcds_code01.countrow;i++){
		strASAQSYM = gcds_code01.namevalue(i,"ASAQSDAT").substring(0,6);

		if(strASAQSYM >strSANGYM ){
			alert("취득일자와 상각년월을 확인하십시요");
			return false;
		}
	}
	return true;
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 지점 -->
<OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 자산분류 -->
<OBJECT id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<OBJECT id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cancel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<object  id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_chk2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-- 소속분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
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

<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	window.status=" 감가상각 처리중입니다. ";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  감가상각처리를 완료 했습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<script language="javascript" for="gcds_cancel" event="OnLoadStarted()">
	window.status=" 감가상각 취소중입니다. ";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_cancel" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  감가상각취소를 완료 했습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()" >
<table width="860" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif">
			<img src="../img/asetdep0_head.gif">
		</td>
		<td width="325px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_refundp.gif"    style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_refundca.gif"   style="cursor:hand" onclick="ln_Cancel()">
			<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand" onClick="ln_Query()">
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:1px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" class="tab35" align=center >지점</td>
		<td width="150px" class="tab35" style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=Sort				value=false>
				<param name=ListExprFormat		value="FDNAME^0^140">
				<param name=BindColumn			value="FDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px" class="tab35" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;"> 자산분류
		</td>  
	  	<td class="tab35" width="150px" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort				    value=false>
				<param name=ListExprFormat	value="CDNAM^0^140">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>

		<td width="80px"  class="tab24" bgcolor="#eeeeee" align=center >구분</td>
		<td width="150px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:100">
					<param name=Cols	  value="2">
					<param name=Format	value="1^원화,2^외화">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<!--<td class="tab21" style="height:30px;width:100px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">상각년월
    	</td> 
		<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="60px;" >&nbsp;    
			<comment id="__NSID__">
			<object id=gcem_hisdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
			 style="position:relative;top:2px;left:0px;width:50px;height:20px;">
				<param name=Alignment	value=0>
				<param name=Border	    value=true>
				<param name=Format	    value="YYYY/MM">
				<param name=PromptChar	value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>-->
    <td class="tab21" style="height:30px;width:60px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">상각년월</td> 
		<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="120px;" >&nbsp;    
			<comment id="__NSID__">
			<object id=gcem_sang_dat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
			style="position:relative;top:2px;left:0px;width:55px;height:20px;">
				<param name=Alignment	  value=0>
				<param name=Border	    value=true>
				<param name=Format	    value="YYYY/MM">
				<param name=PromptChar	value="_">
				<param name=InheritColor		value=true>
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
	</tr>
</table>
							
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:3px;width:280px;border:0 solid #708090;">
	<tr> 			
		<td style="width:280" ALIGN=LEFT VALIGN=TOP>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:310px; border:1 solid #708090;display:block;" viewastext>
				<param name="DataID"		  value="gcds_code01">
				<param name="IndWidth"		value='0'>
				<param name="BorderStyle"	value="0">
				<param name="Fillarea"		value="true">
				<param name="Sortview"		value="left">
				<param name="ColSizing"		value="true">
				<param name="Editable"		value="False"> 
				<param name=TitleHeight   value="30">
				<param name="Format"		  value=" 
					<C> Name='자산번호'			  ID=ASTNBR  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center </C>
					<C> Name='자산명'			    ID=ASNAM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=left	 </C>
					<C> Name='원가명'			    ID=COSTNM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=133	  align=left	 </C>
					<C> Name='취득일자'			  ID=ASAQSDAT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center	Mask=XXXX-XX-XX</C>
					<C> Name='내용\\년수'		  ID=ASTYUSE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	dec=2</C>
					<C> Name='취득금액'			  ID=ASTAQAMT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 </C>
					<C> Name='전기누계액' 	  ID=ABDEPRAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 </C>
					<C> Name='당기상각액' 	  ID=ACDEPRAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 </C>
					<C> Name='잔존가액'			  ID=ASTRMAMT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 </C>
					<C> Name='최종\\상각년월'	ID=LASTYM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=center	Mask=XXXX-XX</C>
					<C> Name='월상각액'		    ID=ASTAMT		 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=right	 </C>
					">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
==================================================================================================================
-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

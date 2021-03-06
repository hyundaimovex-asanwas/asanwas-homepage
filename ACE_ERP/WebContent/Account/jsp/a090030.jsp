<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!---------------------------------------------------------------------------
+ 시 스 템 명	: 자산현황		
+ 프로그램 ID	: A090030.html
+ 기 능 정 의	: 자산 감가상각 현황 조회 화면
+ 작  성   자 : 정 영 식
+ 작 성 일 자 : 2011.06.22
-----------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: A090030_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>자산현황</title>
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
var gs_userid = gusrid;

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
	gcrd_gubun2.codevalue=1;
	gcgd_disp01.ColumnProp("ASTRMAMT", "Show") = "false";
 }

/******************************************************************************
	Description : 최종상각년월찾기
****************************************************************************/
 function ln_Find_ym(){
	gcds_astym.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s2"
									+ "?v_str1="+gclx_fdcode.BindColVal    //지점
	gcds_astym.Reset();
 }

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){


    if (fn_trim(gcem_yymm.text)==""){

	    if(gcrd_gubun2.codevalue==1){
			gcgd_disp01.ColumnProp("ASTRMAMT", "Show") = "false";
		}else{
	        gcgd_disp01.ColumnProp("ASTRMAMT", "Show") = "true";
		} 
	
	    ln_Find_ym();
	   	
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s1"
										  + "?v_str1="+gclx_fdcode.BindColVal             //지점
											+ "&v_str2="+gclx_asdivcod.BindColVal           //자산분류
											+ "&v_str3="+gcrd_gubun.codevalue               //구분 
											+ "&v_str4="+txt_COSTCD.value                   //원가코드 
											+ "&v_str5="+gcds_astym.namevalue(1,"ASTFYM")   //감가상각 최종년도+01월
											+ "&v_str6="+gcds_astym.namevalue(1,"ASTLYM")  //감가상각 최종년월 
	                                        + "&v_str7="+gcrd_gubun2.codevalue;             //원가구분
											
	   // prompt('1', gcds_code01.DataID);				
		gcds_code01.Reset();
	}else{
		
	     alert(gcem_yymm.text.substring(0,4)+"년 "+gcem_yymm.text.substring(4,6)+"월의  저장된 자산현황을 조회합니다.");
	
		//기준년월에 값이 존재하면 기존에 저장한 현황 값을 조회한다 .
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_s4"
									    + "?v_str1="+gclx_fdcode.BindColVal             //지점
										+ "&v_str2="+gclx_asdivcod.BindColVal         //자산분류
										+ "&v_str3="+txt_COSTCD.value                     //원가코드 
                                        + "&v_str4="+gcem_yymm.text;                      //기준년월
											
	    // prompt('2', gcds_code01.DataID);				
		gcds_code01.Reset();
		
	}
	
}


/******************************************************************************
	Description : 당월 감가 상각 마감건에 한하여 자산현황 저장함. ( 잔액미포함 건 ,) 
	
******************************************************************************/
function ln_Save(){

     if(ln_Trim(gcem_toyymm.text)==""){
     	alert("년월을 입력하셔야합니다.");
     	return;
     }
     
    //alert("::"+gcem_toyymm.text+"::");
     

	//감가상각 마감 체크 
	
	
	ln_SetDataHeader();  //데이터셋 생성 
	
	ln_DataCopy();          //데이터 복사 
	
	
	//저장 ( 저장 시점에 기존재 체크하여 존재하면 저장안함. - 저장할 때 년월 입력해야함 . )  
	
	 if (confirm("저장하시겠습니까 ?")) {
		
		gctr_code01.KeyValue = "Account.a090030_t2(I:USER=gcds_astmmccht)";
		gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090030_t2";
	    gctr_code01.Parameters="v_str1="+gcem_toyymm.text+",v_str2="+gs_userid;		
	    //prompt('gcds_astmmccht',gcds_astmmccht.text);
		gctr_code01.post();
	}
}


/******************************************************************************
	Description : 출력 DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_astmmccht.countrow<1){			
		var s_temp = "FDCODE:STRING(2),RCOSTCD:STRING(6),COSTCD:STRING(6),COSTNM:STRING(60),ATCODE:STRING(7),"
                          + "AST2ND:STRING(2),AST2NDNM:STRING(60),ASTAQAMT:DECIMAL(13.0),ABDEPRAMT:DECIMAL(13.0),"
                          + "ACDEPRAMT:DECIMAL(13.0),ACDEPRSUM:DECIMAL(13.0),ASTRMAMT:DECIMAL(13.0),REDUAMT:DECIMAL(13.0)";
		gcds_astmmccht.SetDataHeader(s_temp);
	}
}



/******************************************************************************
	Description : 데이터 복사 
******************************************************************************/
function ln_DataCopy(){
	gcds_astmmccht.ImportData(gcds_code01.ExportData(1,gcds_code01.CountRow,false));
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
	gcgd_disp01.GridToExcel("자산현황","",2);
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel_2(){
	gcgd_crosstab.GridToExcel("감가상각 총괄표","",2);
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+COSTNM+AST2NDNM">
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

<!-- 총괄표 Closs tab -->
<object classid=CLSID:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 id=gcds_crosstab>
		<param name=Logical		value=true>
		<param name=DataID		value=gcds_code01> 
		<param name=GroupExpr	value="COSTNM,AST2NDNM,ABDEPRAMT:REDUAMT:ACDEPRAMT:ACDEPRSUM">
</object>

<!-- 월별원가별 집계 -->
<object  id=gcds_astmmccht  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_code01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
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

	if(gcds_code01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}

	if(gcrd_gubun2.codevalue==1){
		gcgd_crosstab.DataID="gcds_crosstab";
	}else{
	  gcgd_crosstab.DataID="";
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
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	if(row<1) return;
	ln_Find_ym();
  var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_astym.namevalue(1,"ASTFYM");     //당기 01월
	arrParam[1] = gcds_astym.namevalue(1,"ASTLYM");     //감가상각 최종년월
	
	if(gcrd_gubun2.codevalue==1){       //원가별
		arrParam[2] = gcds_code01.namevalue(row,"COSTCD"); //원가코드 
	}else if(gcrd_gubun2.codevalue==2){ //최종원가기준
    arrParam[2] = gcds_code01.namevalue(row,"RCOSTCD"); //원가코드 
	}
	arrParam[3] = gcds_code01.namevalue(row,"COSTNM");  //원가명 
	arrParam[4] = gcds_code01.namevalue(row,"FDCODE");  //지점 
	arrParam[5] = gcds_code01.namevalue(row,"AST2ND");  //중분류 
  arrParam[6] = gcrd_gubun2.codevalue;                 //원가구분 

	var strURL = "./a090030_popup.jsp";
	var strPos = "dialogWidth:702px;dialogHeight:560px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
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
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090030_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		    <img src="../../Common/img/btn/com_b_excel.gif"	    style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
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
		<td width="70px"  class="tab24"  bgcolor="#eeeeee" align=center> 자산분류</td>  
	    <td width="180px" class="tab24">&nbsp;
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
		<td width="70px;" class="tab24"  bgcolor="#eeeeee" align=center>원가명</td> 
		<td class="tab24" >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
	
	<tr> 
		<td width="70px"  class="tab27"  bgcolor="#eeeeee" align=center >구분</td>
		<td class="tab28"  >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:100">
					<param name=Cols	  value="2">
					<param name=Format	value="1^원화,2^외화">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="70px"  class="tab28"  bgcolor="#eeeeee" align=center >원가구분</td>
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun2 classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
					<param name=Cols	  value="2">
					<param name=Format	value="1^원가별,2^최종원가">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="70px"  class="tab28"  bgcolor="#eeeeee" align=center >기준년월</td>
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object  id=gcem_yymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;">		
				<param name=Text					value="">
				<param name=Alignment      value=0>
				<param name=Border          value=true>
				<param name=Format           value="YYYY/MM">
				<param name=PromptChar    value="_">
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_yymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
		</td> 
	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:250px; border:1 solid #708090;display:block;" viewastext>
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
					<C> Name='자산분류'			  ID=AST2NDNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	 SumBgColor=#C3D0DB sumtext=''</C>
					<C> Name='원가명'				  ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=240	align=left	 SumBgColor=#C3D0DB sumtext=''</C>
					<C> Name='취득금액'			  ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='전기누계액'	    ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='손상차손'	    ID=REDUAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='당기상각액'	    ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='누계액\\(전기+손상+당기)'  ID=ACDEPRSUM	HeadAlign=Center HeadBgColor=#B9D4DC  Width=100  	 align=right	   SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='잔존가액'			  ID=ASTRMAMT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=right	 SumBgColor=#C3D0DB sumtext='@sum'</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>		
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
<BR>
<b>[ 감가상각 총괄표 ]</b>  

    <comment id="__NSID__">
		<object  id=gcem_toyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:500px;top:3px">		
		<param name=Text					value="">
		<param name=Alignment     value=0>
		<param name=Border        value=true>
		<param name=Format        value="YYYY/MM">
		<param name=PromptChar    value="_">
		<param name=BackColor     value="#CCCCCC">
		<param name=InheritColor  value=false>
		</object>
	</comment><script>__ws__(__NSID__);</script> 
	<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_toyymm', 'Text')" style="position:relative;width:20px;left:502px;cursor:hand;">  


     <img src="../../Common/img/btn/com_b_save.gif"	   style="cursor:hand;position:relative;left:500px;" onclick="ln_Save()"> &nbsp;&nbsp; 
     <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;position:relative;left:500px;" onclick="ln_Excel_2()"> 
	 <img src="../../Common/img/btn/com_b_print.gif"      style="cursor:hand;position:relative;left:500px;" onclick="rp_cross.preview()">
   <br>
	 <object classid=CLSID:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_crosstab  height=300 width=858 style="position:relative;left:4px;"  >
		<param name=DataID	      value="gcds_crosstab">
		<param name="IndWidth"		value='0'>
		<param name=viewsummary		value=2>
		<param name=ColSizing     value="true">
		<param name=Format	value='
			<C>ID=COSTNM	name="구분"		width=150	HeadColor=#FF0000	 SumText="합계" </C>
			<G>name="합계"     Headbgcolor="#DBE2B5",
			<C>name="전기"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(ABDEPRAMT)} SumText={sum(CrossTabSum(ABDEPRAMT))} SumBgColor="orange"</C>
			<C>name="손상"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(REDUAMT)}   SumText={sum(CrossTabSum(REDUAMT))}   SumBgColor="orange"</C>
			<C>name="당기"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(ACDEPRAMT)} SumText={sum(CrossTabSum(ACDEPRAMT))} SumBgColor="orange"</C>
			<C>name="누계"     width=90  Align=Right bgcolor="#FEFFE8",  Headbgcolor="#DBE2B5", Headcolor="#000000",  Value={CrossTabSum(ACDEPRSUM)} SumText={sum(CrossTabSum(ACDEPRSUM))} SumBgColor="orange"</C>
			</G>
			<R>
				<G>name=$xkeyname_$$	Color=#0000FF
					<C>ID=ABDEPRAMT_$$	name="전기"	width=90	HeadColor=#990000 SumText={sum(ABDEPRAMT_$$)} SumBgColor="orange"</C>
					<C>ID=REDUAMT_$$	  name="손상"	width=90	HeadColor=#990000 SumText={sum(REDUAMT_$$)} SumBgColor="orange"</C>
					<C>ID=ACDEPRAMT_$$	name="당기"	width=90	HeadColor=#990000 SumText={sum(ACDEPRAMT_$$)} SumBgColor="orange"</C>
					<C>ID=ACDEPRSUM_$$	name="누계"	width=90	HeadColor=#990000 SumText={sum(ACDEPRSUM_$$)} SumBgColor="orange"</C>
				</G>
			</R>
			'>
	</object> 
   <br>
<!--Report Componet-->
<object id="rp_cross" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
 	<param name="MasterDataID"		value="gcds_crosstab">
 	<param name="DetailDataID"		value="gcds_crosstab">
 	<param name="PaperSize"			  value="A4">
 	<param name="Landscape"			  value=true>
 	<param name="Format"			    value="

<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=101 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='유형자산 감가상각 총괄표' ,left=8 ,top=13 ,right=2828 ,bottom=101 ,face='Tahoma' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=212 ,face='Arial' ,size=10 ,penwidth=1
	<O> left=545 ,right=923
		<C>id='{sum(ABDEPRAMT_$$)}', left=545, top=167, right=664, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{sum(ACDEPRAMT_$$)}', left=672, top=167, right=791, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='{sum(ACDEPRSUM_$$)}', left=796, top=167, right=915, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=545 ,top=164 ,right=921 ,bottom=164 </L>
		<L> left=667 ,top=114 ,right=667 ,bottom=212 </L>
		<T>id='누계' ,left=796 ,top=119 ,right=915 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='당기' ,left=672 ,top=119 ,right=791 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='전기' ,left=545 ,top=119 ,right=664 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=791 ,top=114 ,right=791 ,bottom=212 </L>
		<L> left=545 ,top=114 ,right=921 ,bottom=114 </L>
		<C>id='xkeyname_$$', left=545, top=66, right=915, bottom=111, face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=545 ,top=61 ,right=921 ,bottom=61 </L>
		<L> left=921 ,top=61 ,right=921 ,bottom=212 </L>
		<L> left=545 ,top=212 ,right=921 ,bottom=212 </L>
	</O>
	<L> left=8 ,top=212 ,right=537 ,bottom=212 </L>
	<T>id='합계' ,left=8 ,top=167 ,right=127 ,bottom=212 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<L> left=8 ,top=164 ,right=537 ,bottom=164 </L>
	<T>id='누계' ,left=405 ,top=119 ,right=534 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>
	<T>id='당기' ,left=267 ,top=119 ,right=397 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#FF0000 ,backcolor=#FFFFFF</T>
	<T>id='전기' ,left=130 ,top=119 ,right=259 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<T>id='구분' ,left=8 ,top=66 ,right=127 ,bottom=164 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=114 ,right=537 ,bottom=114 </L>
	<T>id='합계' ,left=130 ,top=66 ,right=534 ,bottom=111 ,face='Arial' ,size=6 ,bold=false ,underline=false ,italic=false ,forecolor=#0000FF ,backcolor=#FFFFFF</T>
	<L> left=3 ,top=61 ,right=537 ,bottom=61 </L>
	<L> left=127 ,top=61 ,right=127 ,bottom=212 </L>
	<L> left=3 ,top=61 ,right=3 ,bottom=212 </L>
	<L> left=262 ,top=114 ,right=262 ,bottom=212 </L>
	<C>id='{sum(CrossTabSum(ACDEPRSUM))}', left=405, top=167, right=534, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
	<L> left=400 ,top=114 ,right=400 ,bottom=212 </L>
	<L> left=537 ,top=61 ,right=537 ,bottom=212 </L>
	<C>id='{sum(CrossTabSum(ABDEPRAMT))}', left=130, top=167, right=259, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
	<C>id='{sum(CrossTabSum(ACDEPRAMT))}', left=267, top=167, right=397, bottom=212, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<O> left=545 ,right=923
		<C>id='ABDEPRAMT_$$', left=545, top=3, right=664, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACDEPRAMT_$$', left=672, top=3, right=791, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ACDEPRSUM_$$', left=796, top=3, right=915, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=667 ,top=0 ,right=667 ,bottom=50 </L>
		<L> left=791 ,top=0 ,right=791 ,bottom=50 </L>
		<L> left=921 ,top=0 ,right=921 ,bottom=50 </L>
		<L> left=545 ,top=50 ,right=921 ,bottom=50 </L>
	</O>
	<C>id='COSTNM', left=8, top=3, right=127, bottom=48, align='left', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<C>id='{CrossTabSum(ABDEPRAMT)}', left=130, top=3, right=259, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#0000FF, backcolor=#FFFFFF</C>
	<C>id='{CrossTabSum(ACDEPRAMT)}', left=267, top=3, right=397, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>
	<C>id='{CrossTabSum(ACDEPRSUM)}', left=405, top=3, right=534, bottom=48, align='right', face='Arial', size=6, bold=false, underline=false, italic=false, forecolor=#FF0000, backcolor=#FFFFFF</C>
	<L> left=3 ,top=0 ,right=3 ,bottom=50 </L>
	<L> left=537 ,top=0 ,right=537 ,bottom=50 </L>
	<L> left=262 ,top=0 ,right=262 ,bottom=50 </L>
	<L> left=127 ,top=0 ,right=127 ,bottom=50 </L>
	<L> left=400 ,top=0 ,right=400 ,bottom=50 </L>
	<L> left=3 ,top=50 ,right=537 ,bottom=50 </L>
</B>


	">
</object>


</body>
</html>
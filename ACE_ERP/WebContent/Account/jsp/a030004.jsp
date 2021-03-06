<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 결산관리 - 현금출납장
+ 프로그램 ID	: A030004
+ 기 능 정 의	: 조회, 출력
+ 최 초 이 력	: 구자헌
+ 서 블 릿 명	: a030004_s1
------------------------------------------------------------------------------
+ 수 정 내 용  :	 개선사항 수정 및 출력물 수정  
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2006.10
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>현금출납장</title>
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
//get_cookdata();

var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+"01";
var gs_date2 = gcurdate.substring(0,4); //년도
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
}

/******************************************************************************
	Description : 조회 
******************************************************************************/
function ln_Query(){
	var str1 = gclx_sfdcode.BindColVal;	//지점코드
//	var str2 = gs_date2; //년도
	var str3 = shiftTime(gcem_staxdatfr.text, 0, 0, -1); //기간 from 하루 전
	var str4 = gcem_staxdatfr.text //기간 from
	var str5 = gcem_staxdatto.text //기간 to
  var str2 = str4.substring(0,4); //년도

  //상대계정
	gcds_data9.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030004_s2" + "?v_str1=" + str1 + "&v_str2=" + str2 + "&v_str3=" + str3 + "&v_str4=" + str4 + "&v_str5=" + str5;
	//prompt('',gcds_data9.DataID)
	gcds_data9.Reset();

  //현금출납장
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030004_s1" + "?v_str1=" + str1 + "&v_str2=" + str2 + "&v_str3=" + str3 + "&v_str4=" + str4 + "&v_str5=" + str5;
	gcds_data1.Reset();
  //prompt('',gcds_data1.DataID)

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
  
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
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
	var str1 = gclx_sfdcode.BindColVal;	//지점코드
	var str2 = gs_date2; //년도
	var str3 = shiftTime(gcem_staxdatfr.text, 0, 0, -1); //기간 from 하루 전
	var str4 = gcem_staxdatfr.text //기간 from
	var str5 = gcem_staxdatto.text //기간 to
	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030004_s1" + "?v_str1=" + str1 + "&v_str2=" + str2 + "&v_str3=" + str3 + "&v_str4=" + str4 + "&v_str5=" + str5;
	gcds_print1.Reset();
}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

	//gcgd_data1.runexcel("현금출납장");
  gcgd_data1.GridToExcel("현금출납장","",2);

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 
	gcem_staxdatfr.text	= gs_date1;	    //계산서기간 from
	gcem_staxdatto.text	= gs_date;		//계산서기간 to

	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); //지점코드
}

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1월=0,12월=11
    var day   = time.substr(6,2);
    return new Date(year,month,day);
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    return ("" + year + month + day);
}

/**
 * 주어진 Time 과 y년 m월 d일 차이나는 Time을 리턴
 *
 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 으로부터 100일 전 Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m,d) { //moveTime(time,y,m,d)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y년을 더함
    date.setMonth(date.getMonth() + m);       //m월을 더함
    date.setDate(date.getDate() + d);         //d일을 더함

    return toTimeString(date);
}

/***********************************************************************************************
	Description : 누계 구하기....
	parameter   : 
**********************************************************************************************/
function ln_Sum1(){
	var strmdetot = 0; //입금누계
	var strmcrtot = 0; //출금누계
	var strmslpval = 0; //잔액누계
	var stractdat =""; //회계일자
	var stratcode =""; //계정코드
	var sum = gcds_data1.namevalue(1,"SLPVAL");//첫째이월만 이월값으로초기화
	var sum1 = gcds_data1.namevalue(1,"SLPVAL");

	gcgd_data1.redraw = "false";

  strmdetot += gcds_data1.namevalue(1,"DETOT");
	strmcrtot += gcds_data1.namevalue(1,"CRTOT");
	strmslpval += gcds_data1.namevalue(1, "SLPVAL");


	for(i=1;i<=gcds_data1.countrow;i++){
		stractdat = gcds_data1.namevalue(i,"ACTDAT"); 
		stratcode = gcds_data1.namevalue(i,"ATCODE");
		gcds_data2.ImportData(gcds_data1.ExportData(i,1,false));
		if(stratcode=="9999999"){  //if 일계
			gcds_data2.addrow(); //누계
			strmdetot += gcds_data1.namevalue(i,"DETOT");
			strmcrtot += gcds_data1.namevalue(i,"CRTOT");
			strmslpval += gcds_data1.namevalue(i, "SLPVAL");
			gcds_data2.namevalue(gcds_data2.rowposition,"DETOT") = strmdetot;
			gcds_data2.namevalue(gcds_data2.rowposition,"CRTOT") = strmcrtot;
			gcds_data2.namevalue(gcds_data2.rowposition,"SLPVAL") = strmslpval;
			gcds_data2.namevalue(gcds_data2.rowposition,"ACTDAT") = stractdat;
			gcds_data2.namevalue(gcds_data2.rowposition,"ATCODE") = "9999998";
			gcds_data2.namevalue(gcds_data2.rowposition,"ATDECR") = "";
			gcds_data2.namevalue(gcds_data2.rowposition,"SSNBR") = "";
			gcds_data2.namevalue(gcds_data2.rowposition,"REMARK") = "";
			gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM") = "";
		}
	}//for

	for(i=1;i<=gcds_data2.countrow;i++){
	  
		if (gcds_data2.namevalue(i,"ACTDAT").substr(6,2)=="00"){
			gcds_data2.namevalue(i,"ACTDAT")="전기이월"
		}else if (gcds_data2.namevalue(i,"ATCODE")=="9999999"){
			gcds_data2.namevalue(i,"ACTDAT")="일계"
			sum1 = sum1 + gcds_data2.namevalue(i,"DETOT") - gcds_data2.namevalue(i,"CRTOT");
			gcds_data2.namevalue(i,"SLPVAL") = sum1;
		}else if (gcds_data2.namevalue(i,"ATCODE")=="9999998"){
			gcds_data2.namevalue(i,"ACTDAT")="누계"
		}else{
			tempdt = gcds_data2.namevalue(i,"ACTDAT")
			tempdt = tempdt.substring(0,4)+"-"+tempdt.substring(4,6)+"-"+tempdt.substring(6,8);
			gcds_data2.namevalue(i,"ACTDAT") = tempdt;
			sum = sum + gcds_data2.namevalue(i,"DETOT") - gcds_data2.namevalue(i,"CRTOT");
			gcds_data2.namevalue(i,"SLPVAL") = sum;

			//상대계정 넣기
			for(k=1;k<=gcds_data9.countrow;k++){
				if(gcds_data2.namevalue(i,"FDCODE")==gcds_data9.namevalue(k,"FDCODE")&&gcds_data2.namevalue(i,"FSNBR")==gcds_data9.namevalue(k,"FSDATNBR")){
					gcds_data2.namevalue(i,"ATCODE")=gcds_data9.namevalue(k,"ATCODE");
					gcds_data2.namevalue(i,"ATKORNAM")=gcds_data9.namevalue(k,"ATKORNAM");
					//2010.05.26 마지막건을 가져오는것 대신 처음건을 가져옴. 
					break;
				}
			}
		}
	}

	//gcds_data2.SortExpr = "+ACTDAT +ATCODE";
	//gcds_data2.Sort();
	//gcgd_data1.DataID = "gcds_data2";
  gcgd_data1.redraw = "true";
}


/***********************************************************************************************
	Description : 누계 구하기....
	parameter   : 
**********************************************************************************************/
function ln_Sum2(){
	for(i=1;i<=gcds_data2.countrow;i++){
	gcds_print2.ImportData(gcds_data2.ExportData(i,1,false));

	//[이순미:코드추가 START]---------------------------------------------------------------------
	gcds_print2.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
	gcds_print2.namevalue(1,"CURDT")		= gcem_staxdatfr.text + gcem_staxdatto.text;
	gcds_print2.namevalue(1,"CURDT2")		= gs_date;
	//[이순미:코드추가 END]-----------------------------------------------------------------------
  //prompt("",gcds_print2.text);
	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
  parameter   
******************************************************************************/
function ln_SetDataHeader1(){
	if (gcds_data2.countrow<1){
    
	  var s_temp = "ATDECR:STRING,ACTDAT:STRING,ATCODE:STRING,ATKORNAM:STRING,FSNBR:STRING,REMARK:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVAL:DECIMAL,SSNBR:STRING,FDCODE,STRING";
		gcds_data2.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Report
  parameter
	          
******************************************************************************/
function ln_SetDataHeader2(){
	if (gcds_print2.countrow<1){
 
	  var s_temp = "ATDECR:STRING,ACTDAT:STRING,ATCODE:STRING,ATKORNAM:STRING,FSNBR:STRING,REMARK:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVAL:DECIMAL,SSNBR:STRING"
						 + "FDCODENM:STRING,CURDT:STRING,CURDT2:STRING";
		gcds_print2.SetDataHeader(s_temp);
	}
}

/***********************************************************************************************
	Description : [일별] - 전표 찾기
	parameter   : fcod - 지점코드, fsdt - 전표일자, fnbr - 전표번호
**********************************************************************************************/
function ln_Popup2(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;//지점코드
	arrParam[1] = fsdt;//일자
	arrParam[2] = fnbr;//등록번호

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_sfdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data9" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 상대계정 찾기-->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 누계 추가 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 레포트 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 레포트 누계 추가 -->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_sfdcode" event="OnCloseUp()">
	//txt_fdcode.value = gclx_sfdcode.BindColVal;	
</script>

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	//ft_cnt1.innerText = "조회건수 : " + row + " 건";
	ln_SetDataHeader1();
	gcds_data2.ClearData();
	ln_Sum1();//금액계산
	if (row<1)
		alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	ln_SetDataHeader2();
	gcds_print2.ClearData();
	ln_Sum2();
	//ln_Format();
	gcrp_print.preview(); 
		
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<script language=JavaScript for=gcgd_data1 event=OnDblClick(row,colid)>
	var row = gcds_data2.rowposition;
	var p_fcod = gclx_sfdcode.BindColVal;//지점코드
	//var p_fsdt = gcds_data2.namevalue(row,"ACTDAT").substring(0,4)
	//		+ gcds_data2.namevalue(row,"ACTDAT").substring(5,7)
	//		+ gcds_data2.namevalue(row,"ACTDAT").substring(8,10);
	//var p_fnbr = gcds_data2.namevalue(row,"FSNBR");
	var p_fsdt = gcds_data2.namevalue(row,"FSNBR").substring(0,9);//전표일자(전표번호)
	var p_fnbr = gcds_data2.namevalue(row,"FSNBR").substring(9,15);//전표번호
	if(p_fcod == "")
		alert("지점을 선택하십시오");
	else
		ln_Popup2(p_fcod,p_fsdt,p_fnbr); //전표찾기 Popup
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


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
  <tr> 
        <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030004_head.gif"></td>
    <td width="879" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" HEIGHT=47>	

			 <IMG src="../../Common/img/btn/com_b_print.gif"  style="cursor:hand"  onclick="ln_Print()">
			 <IMG src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand"  onclick="ln_Excel()">	
			 <IMG src="../../Common/img/btn/com_b_query.gif"  style="CURSOR: hand" onclick="ln_Query()" > 
			&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>

<table cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
              <tr> 
<!------지점코드------>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;지점코드&nbsp;</font></nobr></td>				
					<td width="170px;" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
<!-----회계일자------>
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr><font style="position:relative;top:1px;">&nbsp;&nbsp;기&nbsp;간&nbsp;&nbsp;</font></nobr></td>
					<td width="300px" class="tab23"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="YYYY/MM/DD">
							<param name=PromptChar			value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:3px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	            value=true>
							<param name=Format	            value="YYYY/MM/DD">
							<param name=PromptChar	        value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;right:0px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width=100%>&nbsp;</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2">

      <table width="875" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:876" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:875" >
								<param name="DataID" value="gcds_data2">
					      <PARAM NAME="Editable"		VALUE="false">
					      <PARAM NAME="ColSizing"		VALUE="true">
					      <PARAM NAME="SortView"		VALUE="left">
					      <PARAM NAME="BorderStyle"     VALUE="0">
						    <param name="Fillarea"		VALUE="true">
						    <PARAM NAME="IndWidth"		VALUE="0">
						    <PARAM NAME="Format"		    VALUE=" 
									<C>ID=ACTDAT,Name='일자',width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center</C>
									<C>ID=ATCODE,Name='상대계정코드',width=80,HeadBgColor=#B9D4DC,HeadAlign=center,align=center show=false</C>
									<C>ID=ATKORNAM,Name='상대계정',width=130,HeadBgColor=#B9D4DC,HeadAlign=center,align=left</C>
									<C>ID=SSNBR,Name='전표번호',width=115,HeadBgColor=#B9D4DC,HeadAlign=center, align=center mask=XXXXXXXXX-XXXXXX</C>  
									<C>ID=REMARK,Name='적요',width=200, HeadBgColor=#B9D4DC,HeadAlign=center, align=left</C>
									<C>ID=DETOT,Name='입금',width=110,HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>  
									<C>ID=CRTOT,Name='출금',width=110,HeadBgColor=#B9D4DC,HeadAlign=center,align=right</C>
									<C>ID=SLPVAL,Name='잔액',width=110, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
												">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
			</table>

    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print2">
	<param name="DetailDataID"			    value="gcds_print2">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=373 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1119 ,top=34 ,right=1955 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1109 ,top=21 ,right=1945 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=953, top=119, right=2098, bottom=167 ,mask='( 기간 : XXXX년 XX월 XX일  ~  XXXX년 XX월 XX일 )', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='현  금  출  납  장' ,left=1114 ,top=24 ,right=1937 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=241 ,top=283 ,right=2810 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='잔  액' ,left=2447 ,top=291 ,right=2802 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='출  금' ,left=2077 ,top=291 ,right=2434 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='입  금' ,left=1709 ,top=291 ,right=2066 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적  요' ,left=1196 ,top=291 ,right=1696 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='일  자' ,left=246 ,top=291 ,right=442 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1191 ,top=283 ,right=1191 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=283 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2442 ,top=283 ,right=2442 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=283 ,right=2072 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1704 ,top=283 ,right=1704 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=241 ,top=283 ,right=241 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='상대계정' ,left=452 ,top=291 ,right=860 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=447 ,top=283 ,right=447 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='전표번호' ,left=873 ,top=291 ,right=1183 ,bottom=365 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=865 ,top=283 ,right=865 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=180, right=2807, bottom=228, align='right' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2807 ,bottom=280 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계정코드: 1110101 - 현금(원화)' ,left=241 ,top=228 ,right=1087 ,bottom=280 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=241, top=180, right=1087, bottom=228, align='left' ,mask='지      점: XXXXXXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=373 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=51 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<C>id='SLPVAL', left=2447, top=0, right=2802, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2442 ,top=0 ,right=2442 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRTOT', left=2077, top=0, right=2434, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1709, top=0, right=2066, bottom=45, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=50 </L>
	<C>id='REMARK', left=1196, top=0, right=1696, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1191 ,top=0 ,right=1191 ,bottom=50 </L>
	<C>id='SSNBR', left=873, top=0, right=1183, bottom=45 ,mask='XXXXXXXXX-XXXXXX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=865 ,top=0 ,right=865 ,bottom=50 </L>
	<C>id='ATKORNAM', left=452, top=0, right=860, bottom=45, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=447 ,top=0 ,right=447 ,bottom=50 </L>
	<C>id='ACTDAT', left=246, top=0, right=447, bottom=45, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=0 ,right=241 ,bottom=50 </L>
	<L> left=241 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=241 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=241 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

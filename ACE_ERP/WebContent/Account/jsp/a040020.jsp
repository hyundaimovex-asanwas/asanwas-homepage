<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 세금계산서관리-정산표
+ 프로그램 ID	: A040020
+ 기 능 정 의	: 조회,출력 
+ 최 초 이 력	: 하민숙
+ 서 블 릿 명	: a040020_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>정산표</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptnm = gdeptnm;
var gs_deptcd = gdeptcd;
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
 // gcgd_data1.DataID = "gcds_data1";
	ln_Before();	//선조회
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
     gcds_dept.Reset();

     if(gclx_sfdcode.Enable==true)
      gclx_sfdcode.BindColVal = gs_fdcode;			

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query1(){

	var str1 = gclx_sfdcode.BindColVal;		//지점코드
	var str2 = gcem_staxdatto.text;			  //기간

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040020_s1?v_str1="+str1
																													+ "&v_str2="+str2;

	gcds_data1.Reset();

 // ln_Sum();
}


/******************************************************************************
	Description : 합계잔액 Sum 계산
******************************************************************************/
/*
function ln_Sum(){
var dblduval=0;
var dbldetot=0;  
var dblcrtot=0;
var dblcrval=0;
 
//gcgd_data1.DataID = "";
	for (i=1;i<=gcds_data1.Countrow;i++){
		if (gcds_data1.namevalue(i,"ATUSEYN")=="Y"){
		  dblduval+=gcds_data1.namevalue(i,"DEVAL");
			dbldetot+=gcds_data1.namevalue(i,"DETOT")
			dblcrtot+=gcds_data1.namevalue(i,"CRTOT")
			dblcrval+=gcds_data1.namevalue(i,"CRVAL")
    }
	}

 gcgd_data1.ColumnProp('DEVAL','SumText')= gf_setnum(dblduval);
 gcgd_data1.ColumnProp('DEVAL','SumTextAlign') = "right";
 gcgd_data1.ColumnProp('DETOT','SumText')=gf_setnum(dbldetot);
 gcgd_data1.ColumnProp('DETOT','SumTextAlign') = "right";
 gcgd_data1.ColumnProp('CRTOT','SumText')=gf_setnum(dblcrtot);
 gcgd_data1.ColumnProp('CRTOT','SumTextAlign') = "right";
 gcgd_data1.ColumnProp('CRVAL','SumText')=gf_setnum(dblcrval);
 gcgd_data1.ColumnProp('CRVAL','SumTextAlign') = "right";
 
// gcgd_data1.DataID = "gcds_data1";
}*/

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

function ln_Print1(){

	var str1 = gclx_sfdcode.BindColVal;		
	var str2 = gcem_staxdatto.text;			

	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040020_s1"
								  + "?v_str1="+str1+"&v_str2="+str2;
	gcds_print1.Reset();

}



/******************************************************************************
	Description : 출력
******************************************************************************/

function ln_RptFormat1() {

	var ls_for = "";

	var strto = gcem_staxdatto.text;
	var yyyy = gs_date2.substring(0,4);
	var mm = gs_date2.substring(4,6);
	var tyyyy = strto.substring(0,4);
	var tmm   = strto.substring(4,6);
	var fd = gcds_sfdcode.NameValue(gcds_sfdcode.rowposition,"FDNAME");

ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=469 ,face='Arial' ,size=10 ,penwidth=1	<X>left=1025 ,top=34 ,right=1863 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>	<X>left=1016 ,top=22 ,right=1850 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>	<T>id='정  산  표' ,left=1019 ,top=25 ,right=1844 ,bottom=87 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>	<L> left=72 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='지점코드 : "+fd+"' ,left=75 ,top=228 ,right=409 ,bottom=275 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<L> left=2441 ,top=378 ,right=2441 ,bottom=466 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='수정분개' ,left=1519 ,top=294 ,right=1875 ,bottom=369 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<L> left=72 ,top=466 ,right=2813 ,bottom=466 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=594 ,top=287 ,right=594 ,bottom=469 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=72 ,top=284 ,right=72 ,bottom=469 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='차 변' ,left=1344 ,top=384 ,right=1694 ,bottom=459 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<T>id='대 변' ,left=1706 ,top=384 ,right=2066 ,bottom=459 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<T>id='대 변' ,left=2450 ,top=384 ,right=2806 ,bottom=459 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<T>id='차 변' ,left=2081 ,top=384 ,right=2438 ,bottom=459 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<L> left=2072 ,top=375 ,right=2809 ,bottom=375 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='수정후시산표' ,left=2266 ,top=294 ,right=2622 ,bottom=369 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<L> left=2072 ,top=287 ,right=2072 ,bottom=469 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='출력일자 : "+yyyy+"/"+mm+"' ,left=2403 ,top=178 ,right=2806 ,bottom=225 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=275 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='(회계년월 : "+tyyyy+"년 "+tmm+"월)' ,left=1000 ,top=122 ,right=1863 ,bottom=187 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='수정전시산표' ,left=788 ,top=294 ,right=1144 ,bottom=369 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<T>id='계정과목' ,left=81 ,top=337 ,right=588 ,bottom=412 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<L> left=1338 ,top=375 ,right=2075 ,bottom=375 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1697 ,top=375 ,right=1697 ,bottom=462 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2809 ,top=281 ,right=2809 ,bottom=469 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=1334 ,top=284 ,right=1334 ,bottom=469 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='대 변' ,left=972 ,top=384 ,right=1331 ,bottom=459 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>	<L> left=963 ,top=378 ,right=963 ,bottom=466 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=597 ,top=375 ,right=1334 ,bottom=375 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<T>id='차 변' ,left=606 ,top=384 ,right=956 ,bottom=459 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T></B>";
ls_for += "<B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=72 ,top=0 ,right=72 ,bottom=50 </L>	<C>id='CRSUM', left=2447, top=0, right=2803, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>	<C>id='DESUM', left=2078, top=0, right=2434, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=72 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>	<C>id='AFDETOT', left=1341, top=0, right=1694, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<C>id='AFCRTOT', left=1703, top=0, right=2066, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=594 ,top=0 ,right=594 ,bottom=50 </L>	<C>id='ATKORNAM', left=81, top=0, right=584, bottom=44, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>	<L> left=2441 ,top=0 ,right=2441 ,bottom=50 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>	<L> left=1697 ,top=0 ,right=1697 ,bottom=50 </L>	<L> left=963 ,top=0 ,right=963 ,bottom=50 </L>	<L> left=1334 ,top=0 ,right=1334 ,bottom=50 </L>	<C>id='BFDETOT', left=603, top=0, right=956, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>	<C>id='BFCRTOT', left=969, top=0, right=1331, bottom=44, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C></B>";
ls_for += "<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1	<L> left=72 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L></B>";
ls_for += "<B>id=LDFooter ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1	<L> left=72 ,top=0 ,right=72 ,bottom=50 </L>	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>	<L> left=72 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>	<L> left=2441 ,top=0 ,right=2441 ,bottom=50 </L>	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>	<L> left=1697 ,top=0 ,right=1697 ,bottom=50 </L>	<L> left=963 ,top=0 ,right=963 ,bottom=50 </L>	<L> left=594 ,top=0 ,right=594 ,bottom=50 </L>	<L> left=1334 ,top=0 ,right=1334 ,bottom=50 </L>	<T>id='합 계' ,left=81 ,top=0 ,right=588 ,bottom=47 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<S>id='Sum(BFDETOT)' ,left=603 ,top=0 ,right=956 ,bottom=47 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='Sum(CRSUM)' ,left=2450 ,top=0 ,right=2803 ,bottom=47 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='Sum(DESUM)' ,left=2081 ,top=0 ,right=2434 ,bottom=47 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='Sum(AFCRTOT)' ,left=1706 ,top=0 ,right=2066 ,bottom=47 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='Sum(AFDETOT)' ,left=1344 ,top=0 ,right=1694 ,bottom=47 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>	<S>id='Sum(BFCRTOT)' ,left=969 ,top=0 ,right=1328 ,bottom=47 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S></B>";
ls_for += "<B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I></B>";

	gcrp_print1.format = ls_for + gcrp_print1.format;

}



/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 

	//gclx_sfdcode.BindColVal = "01";					//지점코드
	gcem_staxdatto.text		 = gs_date2;				//계산서기간 년 월

	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); //지점코드

}

/******************************************************************************
	Description : 그리드 보이기
******************************************************************************/
function ln_visible_hidden(Obj){
	
}

/***********************************************************************************************
	Description : [일별] - 계정원장 찾기
	parameter   : fcod - 지점코드, atcod - 계정코드, frdt - 검색일자(from), todt - 검색일자(to)
**********************************************************************************************/

function ln_Popup2(fcod,atcod,frdt,todt){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;

	strURL = "./totalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : 총계정원장[일별] 찾기
	parameter   : fcod2 - 지점코드, atcod2 - 계정코드, frdt2 - 검색일자(from), todt2 - 검색일자(to)
**********************************************************************************************/

function ln_Popup3(fcod2,atcod2,frdt2,todt2){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod2;
	arrParam[1] = atcod2;
	arrParam[2] = frdt2;
	arrParam[3] = todt2;

	strURL = "./dtotalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_sfdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gclx_sfdcode" event="OnCloseUp()">

	//txt_fdcode.value = gclx_sfdcode.BindColVal;
	
</script> -->

 <script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
 // ln_Sum(); //합계잔액 Sum 계산
	window.status="조회가 완료 되었습니다.";
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script> 

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	//if (row<1) {
	//	alert("출력하실 정보가 없습니다.");
	//}else{
		ln_RptFormat1();
		gcrp_print1.preview();
	//}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="전체";
	gclx_sfdcode.bindcolval=gs_fdcode;

</script>

<script language=JavaScript for=gcgd_data1 event=OnDblClick(row,colid)>
	var row = gcds_data1.rowposition;
	var p_fcod = gclx_sfdcode.BindColVal;//지점코드
	var p_acod = gcds_data1.namevalue(row,"ATCODE");//계정코드
	var p_frdt = gcem_staxdatto.text + "01";//일자1
	var p_todt = gcem_staxdatto.text + "31";//일자2
	ln_Popup2(p_fcod,p_acod,p_frdt,p_todt);	//계정원장[일별] Popup
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

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td>
			<img src="../img/a040020_head.gif">
		</td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:12px;padding-left:155px">&nbsp;
		  <img name="btn_print" src="../../Common/img/btn/com_b_print.gif"	style="cursor:hand;position:relative;left:0px;top:-5px"	onclick="ln_Print1()"> 
		  <img name="btn_query" src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand;position:relative;left:0px;top:-5px" onclick="ln_Query1()">&nbsp;
	  </td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;지점코드&nbsp;</nobr></td>
					<td width="150px;" class="tab23"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat		value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;회계년월&nbsp;</nobr></td>
					<td width="150px"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
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
          <td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:875" >
							<PARAM NAME="DataID"		 VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false">
							<param name="ViewSummary"	value=1>
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
							  <C>ID=ATCODE, Name='' ,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center SumBgColor=#C3D0DB SHOW=FALSE</C>
							  <C>ID=ATKORNAM, Name='계정과목' ,width=200, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT SumBgColor=#C3D0DB  SumText='합  계'</C>
								<G>Name='수정전시산표',  SumText=@sum, HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=BFDETOT,	Name='차변',  SumText=@sum, width=109, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=BFCRTOT,	Name='대변' , SumText=@sum ,width=109,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>	
								<G>Name='수정분개', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=AFDETOT,	Name='차변', SumText=@sum ,width=109, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=AFCRTOT,	Name='대변' , SumText=@sum, width=109,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
								<G>Name='수정후시산표', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DESUM,	Name='차변',width=109, SumText=@sum,  HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=CRSUM,	Name='대변' ,width=109, SumText=@sum ,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;">조회건수 : </font><font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N 
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_print1">
	<param NAME="DetailDataID"			VALUE="gcds_print1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="NullRecordFlag"		VALUE="true">
	<PARAM NAME="Format" VALUE="

">
</object></comment><script>__ws__(__NSID__);</script> 



</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
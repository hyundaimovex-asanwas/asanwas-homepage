<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/퇴직자급여내역
+ 프로그램 ID	: p040002.HTML
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 권영법
+ 수 정 이 력	: 이순미 - 2005.08.02 - 소스 정리
+ 서 블 릿 명	: p040002_s1, p040002_t1
------------------------------------------------------------------------------>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>퇴직자급여내역</title>

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
var curtid = "88001";  
var key_sabun="";
get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_jigub11.Text=gs_date;
  gcem_jigub12.Text=gs_date;

	gclx_paydiv.index=0;	//지급구분
	gclx_usests.index=0;	//재직구분
}

/******************************************************************************
	Description : 기본조회
******************************************************************************/
function ln_Query(){

  txt_DUYYMMDD.value="";
	var str1 = fn_trim(gcem_jigub11.Text);
	var str2 = fn_trim(gcem_jigub12.Text);
	var str3 = fn_trim(txt_empnm_search.value);
	var str4 = gclx_paydiv.BindColVal;
	var str5 = gclx_usests.BindColVal;

	gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040002_s1?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2
									 + "&v_str3=" + str3
									 + "&v_str4=" + str4
									 + "&v_str5=" + str5;

	gcds_grid_ec01az.Reset(); //그리드
	gcds_grid_ec01az.rowposition=1;
}

/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Insert(){
if(gcds_grid_ec01az.countRow==0)
   {
	var THeader = "EMPNO:String(7),"	
						+"EMPNMK:String(20),"   
						+"NOTWRK:String(2),"   
						+"APPDT:String(6),"	
						+"PAYDIV:String(4),"	
						+"DEPTCD:String(4),"	
						+"DEPTNM:String(50),"	
						+"PAYGRDNM:String(30),"	
						+"GRDDIVNM:String(30),"	
						+"PAYSEQNM:String(30),"	
						+"PAYBNKNM:String(30),"	
						+"PAYNUM:String(25),"	
						+"PAYDT:String(8	),"    
						+"DUYNOT:String(2),"	
						+"P10000:String(9),"	
						+"P11000:String(9),"	
						+"P12000:String(9),"	
						+"P21000:String(9),"	
						+"P22000:String(9),"	
						+"P23001:String(9),"	
						+"P24000:String(9),"	
						+"P25000:String(9),"	
						+"P26000:String(9),"	
						+"P27000:String(9),"	
						+"P28000:String(9),"	
						+"P29000:String(9),"	
						+"P30000:String(9),"	
						+"P31000:String(9),"	
						+"P32000:String(9),"	
						+"P36000:String(9),"	
						+"P37000:String(9),"	
						+"P38000:String(9),"	
						+"PX0010:String(9),"	
						+"PX0020:String(9),"	
						+"PX0030:String(9),"	
						+"PX0040:String(9),"	
						+"S91000:String(9),"	
						+"T11000:String(9),"	
						+"T12000:String(9),"	
						+"B11000:String(9),"	
						+"B12000:String(9),"	
						+"B13000:String(9),"	
						+"B15000:String(9),"	
						+"B14000:String(9),"	
						+"B16000:String(9),"	
						+"BX0010:String(9),"	
						+"BX0020:String(9),"	
						+"BX0030:String(9),"	
						+"BX0040:String(9),"	
						+"S93000:String(9),"	
						+"S94000:String(9),"	
						+"STRTDT:String(8),"	
						+"JOBGRPHNM:String(30)";

	gcds_grid_ec01az.DataID = "";
	gcds_grid_ec01az.SetDataHeader(THeader);
	}
	gcds_grid_ec01az.addRow();
	gcem_APPDT.Text=gs_date2;
	gcem_PAYDT.Text=gs_date2+"25";
	gcem_EMPNO.Focus();
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del(){	
	if(gcds_grid_ec01az.countRow !=0) {
		if (confirm("선택된 틔직자급여사항을 삭제하시겠습니까 ?"))	{
			gcds_grid_ec01az.deleteRow(gcds_grid_ec01az.rowposition); //그리드
		}
	}
}

/******************************************************************************
	Description : 계산
******************************************************************************/
function ln_Calc() {

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save() {
	if (gcds_grid_ec01az.countrow <1) {
		alert("저장하실 정보가 없습니다.");
	} else 	{
		if (gcds_grid_ec01az.IsUpdated )	{
			//if (ln_ValChk())
			//{
				if (confirm("퇴직급여변경사항을 저장하시겠습니까 ?"))
				{
					gctr_data.KeyValue = "Payroll.p040002_t1(I:USER=gcds_grid_ec01az)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040002_t1";
					//gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4)+gcurdate.substring(5,7);
					gctr_data.post();
				}
			//}
		} 
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_GridSelect(row) {

	gcds_grid_ec01az.NameValue(row,"S91000")= //지급합계[24항목]
	gcds_grid_ec01az.NameValue(row,"P10000")+	//기본급여
	gcds_grid_ec01az.NameValue(row,"P11000")+	//직책수당
	gcds_grid_ec01az.NameValue(row,"P12000")+	//시간외수당
	gcds_grid_ec01az.NameValue(row,"P21000")+	//근속수당
	gcds_grid_ec01az.NameValue(row,"P22000")+	//자기계발비
	gcds_grid_ec01az.NameValue(row,"P23000")+	//부양가족수당
	gcds_grid_ec01az.NameValue(row,"P24000")+	//차량유지비
	gcds_grid_ec01az.NameValue(row,"P25000")+	//출납수당
	gcds_grid_ec01az.NameValue(row,"P26000")+	//운전수당
	gcds_grid_ec01az.NameValue(row,"P27000")+	//연장수당
	gcds_grid_ec01az.NameValue(row,"P28000")+	//자격수당
	gcds_grid_ec01az.NameValue(row,"P29000")+	//남북경협수당
	gcds_grid_ec01az.NameValue(row,"P30000")+	//사장단수당
	gcds_grid_ec01az.NameValue(row,"P31000")+	//특수지수당
	gcds_grid_ec01az.NameValue(row,"P32000")+	//지역근무수당
	gcds_grid_ec01az.NameValue(row,"P37000")+	//개인연금보조금
	gcds_grid_ec01az.NameValue(row,"P36000")+	//학비보조금
	gcds_grid_ec01az.NameValue(row,"P38000")+	//임원직책수당
	gcds_grid_ec01az.NameValue(row,"PX0010")+	//휴일수당
	gcds_grid_ec01az.NameValue(row,"PX0020")+	//기타지급1
	gcds_grid_ec01az.NameValue(row,"PX0030")+	//기타지급2
	gcds_grid_ec01az.NameValue(row,"P39000")+	//전월소급
	gcds_grid_ec01az.NameValue(row,"P34000")+ //년차수당
	gcds_grid_ec01az.NameValue(row,"P35000");	//식대보조

	gcds_grid_ec01az.NameValue(row,"S93000")= //공제합계[18항목]
	gcds_grid_ec01az.NameValue(row,"T11000")+	//소득세=갑근세
	gcds_grid_ec01az.NameValue(row,"T12000")+	//주민세
	gcds_grid_ec01az.NameValue(row,"B11000")+	//건강보험료
	gcds_grid_ec01az.NameValue(row,"B12000")+	//국민연금
	gcds_grid_ec01az.NameValue(row,"B13000")+	//고용보험
	gcds_grid_ec01az.NameValue(row,"B15000")+	//개인연금
	gcds_grid_ec01az.NameValue(row,"B14000")+	//여직원회비
	gcds_grid_ec01az.NameValue(row,"B16000")+	//공조회비
	gcds_grid_ec01az.NameValue(row,"B17000")+ //산재보험
	gcds_grid_ec01az.NameValue(row,"BX0010")+	//보증보험
	gcds_grid_ec01az.NameValue(row,"BX0020")+	//기타공제1
	gcds_grid_ec01az.NameValue(row,"BX0030")+	//기타공제2
	gcds_grid_ec01az.NameValue(row,"BX0040")+	//기타공제3
	gcds_grid_ec01az.NameValue(row,"P43000")+	//정산연금
	gcds_grid_ec01az.NameValue(row,"P41000")+	//정산건강
	gcds_grid_ec01az.NameValue(row,"P42000")+ //정산고용
	gcds_grid_ec01az.NameValue(row,"T21000")+ //정산소득
	gcds_grid_ec01az.NameValue(row,"T22000"); //정산주민

	gcds_grid_ec01az.NameValue(row,"S94000")= 
	gcds_grid_ec01az.NameValue(row,"S91000")-
	gcds_grid_ec01az.NameValue(row,"S93000");  //차인지급액

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

	if (gcds_grid_ec01az.countrow<1) {
		alert("출력하실 정보가 없습니다");
	} else {
		gcds_report0.ClearData();
		var ls_temp = "";
        ls_temp="CTITLE:STRING,";
		gcds_report0.SetDataHeader(ls_temp);

		gcds_report0.addrow();

		for (var i=1;i<=gcds_grid_ec01az.countcolumn;i++) {
				var col = gcds_grid_ec01az.ColumnIndex(gcds_grid_ec01az.columnid(i));
				col = gcds_grid_ec01az.ColumnType(col)
				if (col==1) ls_temp += "," + gcds_grid_ec01az.ColumnID(i) + ":STRING";
				else if (col==3) ls_temp += "," + gcds_grid_ec01az.ColumnID(i) + ":DECIMAL";
				else if (col==5) ls_temp += "," + gcds_grid_ec01az.ColumnID(i) + ":URL";
		}

		gcds_report0.namevalue(1,"CTITLE")=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"APPDT")
								   +""+gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"PAYDIV");

		for (var k=1;k<=gcds_grid_ec01az.countcolumn;k++) {
		 gcds_report0.namevalue(1,gcds_grid_ec01az.columnid(k)) = gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,gcds_grid_ec01az.columnid(k));
		}

		//gcrp_print.preview();
	}
}

/******************************************************************************
	Description : 급여기타항목제목 자동생성
******************************************************************************/
function ln_TitelAuto() {
	
	var t_row = gcds_grid_ec01az.rowposition;

	//급여기타항목제목 자동생성
	if(gcds_grid_ec01az.namevalue(t_row,"PR0020") != null) txt_px01.value = gcds_grid_ec01az.namevalue(t_row,"PR0020");
	if(gcds_grid_ec01az.namevalue(t_row,"PR0030") != null) txt_px02.value = gcds_grid_ec01az.namevalue(t_row,"PR0030");
	if(gcds_grid_ec01az.namevalue(t_row,"PR0040") != null) txt_px03.value = gcds_grid_ec01az.namevalue(t_row,"PR0040");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0020") != null) txt_pb01.value = gcds_grid_ec01az.namevalue(t_row,"BR0020");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0030") != null) txt_pb02.value = gcds_grid_ec01az.namevalue(t_row,"BR0030");
	if(gcds_grid_ec01az.namevalue(t_row,"BR0040") != null) txt_pb03.value = gcds_grid_ec01az.namevalue(t_row,"BR0040");

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_select_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속구분 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--소속그리드 기본사항조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 조회 DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	
	if(gcds_grid_ec01az.countrow <=0)
	alert("조회된 데이타가 없습니다.");
	//else ln_GridSelect(row);

	ln_TitelAuto();		//급여기타(공제)항목제목 자동생성

	var row = gcds_grid_ec01az.rowposition;
	if (gcds_grid_ec01az.namevalue(row,"DUYEAR") != null && gcds_grid_ec01az.namevalue(row,"DUYMM") != null && gcds_grid_ec01az.namevalue(row,"DUDAY") !=null) {
	txt_DUYYMMDD.value=gcds_grid_ec01az.namevalue(row,"DUYEAR")
                   + "년 " +gcds_grid_ec01az.namevalue(row,"DUYMM")
                   + "개월 " +gcds_grid_ec01az.namevalue(row,"DUDAY") + "일";
	}
</script>

<script language=JavaScript for=gcds_grid_ec01az event=OnColumnChanged(row,colid)>
	ln_GridSelect(row);
</script>

<script language="javascript" for=gcgd_grid_ec01az	event=OnClick(row,colid)>
	var row = gcds_grid_ec01az.rowposition;
	if (gcds_grid_ec01az.namevalue(row,"DUYEAR") != null && gcds_grid_ec01az.namevalue(row,"DUYMM") != null && gcds_grid_ec01az.namevalue(row,"DUDAY") !=null) {
			txt_DUYYMMDD.value=gcds_grid_ec01az.namevalue(row,"DUYEAR")
                   + "년 " +gcds_grid_ec01az.namevalue(row,"DUYMM")
                   + "개월 " +gcds_grid_ec01az.namevalue(row,"DUDAY") + "일";
	}
</script>

<script language="javascript"  for=gcds_grid_ec01az  event=OnRowPosChanged(row)>
	var strBS=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"BSDAY")+"";
	var strHJ=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"HJDAY")+"";
	var strNS=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"NSDAY")+"";
	if(strBS.length==1) strBS="0"+strBS;
	if(strHJ.length==1) strHJ="0"+strHJ;
	if(strNS.length==1) strNS="0"+strNS;
	gcem_SGUNMU.Text=strBS+","+strHJ+","+strNS;
</script>
 
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
</script>
<script language="javascript" for="gctr_data" event="OnFail()">
	alert("요청하신 작업에 오류가 발생하였습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p040002_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</nobr>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;&nbsp;지급년월&nbsp;&nbsp;&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;"><nobr>
			<table cellpadding=0 cellspacing=0>
				<tr>
					<td><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_jigub11 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:1px; width:50px; height:20px;" class=txtbox	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub11', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr></td><td>~</td><td><nobr>

						<comment id="__NSID__"><object id=gcem_jigub12 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:0px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_jigub12', 'Text')" style="position:relative;width:20px;left:5px;top:-2px;cursor:hand;">&nbsp;
            </nobr>
					</td>
				</tr>
			</table>
	</nobr></td>
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;지급구분&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><object id=gclx_paydiv  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
							style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<!--param name=ComboDataID			value=gcds_select_ec01az-->
							<param name=CBData					value="1^정기급여,2^소급급여,3^퇴직급여,4^휴직급여,5^상여급여">
              <param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;재직구분&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><object id=gclx_usests  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 
							style="position:relative;left:8px;top:2px;font-size:12px;width:80px;height:200px;">
							<!--param name=ComboDataID			value=gcds_select_ec01az-->
							<!-- <param name=CBData					value="1^재직,2^휴직,3^퇴직"> -->
							<param name=CBData					value="3^퇴직">
              <param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>
					<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;&nbsp;&nbsp;성명&nbsp;&nbsp;&nbsp;</nobr></td>
					<td><input id=txt_empnm_search name=txt_empnm_search type=text class="txt21" size=10  onkeydown="if(event.keyCode==13) ln_Query();" >&nbsp;</td>
					<td width="100%" align=RIGHT >&nbsp;</td>
					<td style="padding-top:4px;"></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:300px" valign=top>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_grid_ec01az  style="WIDTH: 310px; HEIGHT: 421px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
              <PARAM NAME="Editable" VALUE="fALSE">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<param name="ColSizing"		VALUE="true">
							<Param Name="SortView"     value="Left">
							<PARAM NAME="Format"			VALUE="  
			          <C> Name='소속' ID=DEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=110 sort=true</C>
								<C> Name='성명' ID=EMPNMK HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center sort=true  </C>
								<C> Name='사번' ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50   align=center sort=true</C> 
								<C> Name='지급년월' ID=APPDT HeadAlign=Center HeadBgColor=#B9D4DC Width=75 align=center sort=true Mask='XXXX/XX' </C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:312;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
			</td><td>&nbsp;</td>
			<td STYLE="PADDING-TOP:0px;" valign=top>
			<table width="3" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
				<table cellpadding=0 cellspacing=0  border=0 style='width:558;height:79px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
					<tr>
						<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee" width=0>&nbsp;성명</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" colspan=2><nobr><input id=txt_EMPNMK name=txt_EMPNMK type=text class="txt21" style="left:5px;height:18px"size=10 disabled>&nbsp;</nobr></td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee" width=0><nobr>&nbsp;주민번호&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_RESINO                
						   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:90px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=enable				value=false>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="000000-0000000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
			        </object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee" width=0><nobr>&nbsp;직위</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;" colspan=2><nobr><input id=txt_GRDDIVNM name=txt_GRDDIVNM type=text class="txt21" style="left:5px;height:18px"size=10 disabled>&nbsp;</nobr></td>
					</tr>		
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" width=0>&nbsp;소속</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" colspan=2><nobr><input id=txt_DEPTNM name=txt_DEPTNM type=text class="txt21" style="left:5px;height:18px"size=20 disabled>&nbsp;</nobr></td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee" width=0>&nbsp;입사일</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_STRTDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:5px;top:2px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=enable				value=false>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="0000/00/00">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee" width=0><nobr>&nbsp;퇴사일</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_ENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:2px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=enable				value=false>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="0000/00/00">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>
					</tr>	
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" width=0><nobr>&nbsp;근무기간&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" colspan=2><nobr>
              <input type=text id=txt_DUYYMMDD name=txt_DUYYMMDD  size=15  class="txt21" style="left:5px;height:18px" disabled >	
						</nobr></td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee" width=0>&nbsp;총소득</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_S92000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=enable				value=false>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:0px;" bgcolor="#eeeeee" width=0><nobr>&nbsp;우편번호</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_CZIPCD classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:48px; height:20px;" class=txtbox	validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=enable				value=false>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="000-000">
								<param name=MaxLength     value=6>
								<param name=PromptChar	  value="">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
					</tr>	
					<!-- <tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" width=0>&nbsp;현주소</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:0px;" colspan=8><nobr><input id=txt_CADDR name=txt_CADDR type=text class="txt21" style="left:5px;height:18px"size=76 disabled>&nbsp;</nobr></td>
					</tr> -->
					<tr>
						<td style="height:5px;border:0 solid #708090;" colspan=9> </td>
					</tr>
				</table>




					<table width="558" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1>
							<nobr>&nbsp;지급항목</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=4></td>
						<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;border-top-width:0px;border-left-width:0px;"  colspan=1><nobr>&nbsp;</nobr></td>
						<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;지급합계</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2 >
							<comment id="__NSID__"><object id=gcem_S91000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=enable				value=false>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;기본급</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P10000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1	validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Readonly	    value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee">&nbsp;직책수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;border-top-width:1px;" bgcolor="#eeeeee">&nbsp;시간외수당</td>
						<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;  " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr>&nbsp;근속수당</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;자기계발비</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;가족부양비</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;차량유지비</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P24000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;출납</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P25000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;운전수당</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P26000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;연장수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P27000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;자격수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P28000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;남북경협수당</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P29000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;사장단수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P30000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;특수지수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P31000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;지역근무수당</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P32000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
					<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;개인연금</td>
					<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
						<comment id="__NSID__"><object id=gcem_P37000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;학자금</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P36000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;임원직책수당</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P38000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;휴일수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_PX0010 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;년차수당</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P34000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;식대</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P35000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr><input id="txt_px01"  type="text" class="txtbox" style="border:1 ;width:85px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타지급1" disabled>&nbsp;</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_PX0020 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_px02"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타지급2" disabled></nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_PX0030 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_px03"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타지급3" disabled></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_PX0040 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;전월소급</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P39000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;본사,현장,해외</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_SGUNMU classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"style="position:relative; left:5px;top:0px; width:70px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="00,  00,  00">
								<param name=MaxLength     value=9>
								<param name=Readonly			value=true>
								<param name=enable				value=false>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;
						</td>
					</tr>
					<tr><td style="height:5px;border:0 solid #708090;" colspan=6></td></tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;공제항목</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:0px;border-right-width:1px;" colspan=2 >&nbsp;</td>
						<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;공제합계</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2 >
							<comment id="__NSID__"><object id=gcem_S93000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=enable				value=false>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" bgcolor="#B9D4DC" colspan=1><nobr>&nbsp;실지급액</nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-bottom-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_S94000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=enable				value=false>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;갑근세</td>
						<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_T11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;주민세</td>
						<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_T12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;" bgcolor="#eeeeee">&nbsp;건강보험</td>
						<td style="border:1 solid #708090;border-left-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;국민연금</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B12000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;고용보험</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;개인연금</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B15000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;여직원회비</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B14000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;공조회비</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B16000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">
							<nobr>&nbsp;산재보험</nobr>
						</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_B17000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;보증보험</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_BX0010 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_pb01"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타공제1" disabled></nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_BX0020 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr><input id="txt_pb02"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타공제2" disabled></nobr></td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_BX0030 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee"><nobr><input id="txt_pb03"  type="text" class="txtbox" style="border:1 ;width:80px; height:15px;position:relative;top:2px;left:5px;background-color:#eeeeee" alt="기타공제3" disabled></nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_BX0040 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;정산연금</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;정산건강</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td style="height:20px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;정산고용</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_P42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="height:20px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"><nobr>&nbsp;정산소득</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_T21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;정산주민</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_T22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:5px;top:0px; width:70px; height:20px; font-family:굴림; font-size:9pt;" class=objclsEme1 validFeatures="ignoreStatus=yes" validExp=""> 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=Readonly	    value=true>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					</table>
						</td>
					</tr>


				</table>

			</td>

        </tr>
      </table>
    </td>
  </tr>
	</table>

<!-- 데이타바인드 정의부분 -->    
<comment id="__NSID__"><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"				VALUE="gcds_grid_ec01az">
	<PARAM NAME="ActiveBind"		VALUE="true">
	<PARAM NAME="BindInfo"			VALUE="
				<C>Col=APPDT		Ctrl=gcem_APPDT		Param=Text</C>	
				<C>Col=EMPNO		Ctrl=txt_empno		Param=value</C>	
				<C>Col=EMPNMK		Ctrl=txt_EMPNMK		Param=value</C> 
				<C>Col=NOTWRK		Ctrl=txt_NOTWRK		Param=value</C> 
				<C>Col=PAYDIV		Ctrl=txt_PAYDIV		Param=value</C>	
				<C>Col=DEPTCD		Ctrl=txt_DEPTCD		Param=value</C>	
				<C>Col=DEPTNM		Ctrl=txt_DEPTNM		Param=value</C>	
				<C>Col=PAYGRDNM		Ctrl=txt_PAYGRDNM		Param=value</C>	
				<C>Col=PAYGRDNM		Ctrl=txt_GRDDIVNM		Param=value</C>	
				<C>Col=PAYSEQNM		Ctrl=txt_PAYSEQNM		Param=value</C>	
				<C>Col=PAYBNKNM		Ctrl=txt_PAYBNKNM		Param=value</C>	
				<C>Col=PAYNUM		Ctrl=txt_PAYNUM		Param=value</C>	
				<C>Col=PAYDT		Ctrl=gcem_PAYDT		Param=Text</C> 
				<C>Col=DUYNOT		Ctrl=txt_DUYNOT		Param=value</C>	
				<C>Col=P10000		Ctrl=gcem_P10000		Param=Text</C>
				<C>Col=P11000		Ctrl=gcem_P11000		Param=Text</C>
				<C>Col=P12000		Ctrl=gcem_P12000		Param=Text</C>
				<C>Col=P21000		Ctrl=gcem_P21000		Param=Text</C>
				<C>Col=P22000		Ctrl=gcem_P22000		Param=Text</C>
				<C>Col=P23000		Ctrl=gcem_P23000		Param=Text</C>
				<C>Col=P24000		Ctrl=gcem_P24000		Param=Text</C>
				<C>Col=P25000		Ctrl=gcem_P25000		Param=Text</C>
				<C>Col=P26000		Ctrl=gcem_P26000		Param=Text</C>
				<C>Col=P27000		Ctrl=gcem_P27000		Param=Text</C>
				<C>Col=P28000		Ctrl=gcem_P28000		Param=Text</C>
				<C>Col=P29000		Ctrl=gcem_P29000		Param=Text</C>
				<C>Col=P30000		Ctrl=gcem_P30000		Param=Text</C>
				<C>Col=P31000		Ctrl=gcem_P31000		Param=Text</C>
				<C>Col=P32000		Ctrl=gcem_P32000		Param=Text</C>
				<C>Col=P36000		Ctrl=gcem_P36000		Param=Text</C>
				<C>Col=P37000		Ctrl=gcem_P37000		Param=Text</C>
				<C>Col=P38000		Ctrl=gcem_P38000		Param=Text</C>
				<C>Col=PX0010		Ctrl=gcem_PX0010		Param=Text</C>
				<C>Col=PX0020		Ctrl=gcem_PX0020		Param=Text</C>
				<C>Col=PX0030		Ctrl=gcem_PX0030		Param=Text</C>
				<C>Col=PX0040		Ctrl=gcem_PX0040		Param=Text</C>
				<C>Col=S91000		Ctrl=gcem_S91000		Param=Text</C>

				<C>Col=T11000		Ctrl=gcem_T11000		Param=Text</C>
				<C>Col=T12000		Ctrl=gcem_T12000		Param=Text</C>
				<C>Col=B11000		Ctrl=gcem_B11000		Param=Text</C>
				<C>Col=B12000		Ctrl=gcem_B12000		Param=Text</C>
				<C>Col=B13000		Ctrl=gcem_B13000		Param=Text</C>
				<C>Col=B15000		Ctrl=gcem_B15000		Param=Text</C>
				<C>Col=B14000		Ctrl=gcem_B14000		Param=Text</C>
				<C>Col=B16000		Ctrl=gcem_B16000		Param=Text</C>
				<C>Col=BX0010		Ctrl=gcem_BX0010		Param=Text</C>
				<C>Col=BX0020		Ctrl=gcem_BX0020		Param=Text</C>
				<C>Col=BX0030		Ctrl=gcem_BX0030		Param=Text</C>
				<C>Col=BX0040		Ctrl=gcem_BX0040		Param=Text</C>

				<C>Col=S93000		Ctrl=gcem_S93000		Param=Text</C>
				<C>Col=S94000		Ctrl=gcem_S94000		Param=Text</C>

				<C>Col=STRTDT		Ctrl=gcem_STRTDT		Param=Text</C>	
				<C>Col=JOBGRPHNM  Ctrl=txt_JOBGRPHNM		Param=value</C>	
				<C>Col=ENDDT		Ctrl=gcem_ENDDT		Param=Text</C>	
				<C>Col=RESINO      Ctrl=gcem_RESINO		Param=Text</C>	
				<C>Col=T21000      Ctrl=gcem_T21000		Param=Text</C>	
				<C>Col=CZIPCD      Ctrl=gcem_CZIPCD		Param=Text</C>	
				<C>Col=CADDR      Ctrl=txt_CADDR		Param=value</C>	
				<C>Col=S92000      Ctrl=gcem_S92000		Param=Text</C>	
				<C>Col=P41000      Ctrl=gcem_P41000		Param=Text</C>	
				<C>Col=P42000      Ctrl=gcem_P42000		Param=Text</C>	
				<C>Col=T22000      Ctrl=gcem_T22000		Param=Text</C>

				<C>Col=P35000			Ctrl=gcem_P35000		Param=Text</C>
				<C>Col=P39000	    Ctrl=gcem_P39000		Param=Text</C>
				<C>Col=P43000			Ctrl=gcem_P43000		Param=Text</C>
				<C>Col=B17000			Ctrl=gcem_B17000		Param=Text</C>
				<C>Col=P34000	    Ctrl=gcem_P34000		Param=Text</C>

				<C>Col=PR0020			Ctrl=txt_px01				Param=value</C>
				<C>Col=PR0030			Ctrl=txt_px02				Param=value</C>
				<C>Col=PR0040			Ctrl=txt_px03				Param=value</C>

				<C>Col=BR0020			Ctrl=txt_pb01				Param=value</C>
				<C>Col=BR0030			Ctrl=txt_pb02				Param=value</C>
				<C>Col=BR0040			Ctrl=txt_pb03				Param=value</C>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-------------------------------------------------------------------------------------------
   ▣ 보고서 정의부분
-------------------------------------------------------------------------------------------->  

<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<!--param name="DetailDataID"	value="gcds_report2"-->
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2775 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='공       제       내       역' ,left=574 ,top=1482 ,right=1426 ,bottom=1537 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='지       급       내      역' ,left=545 ,top=804 ,right=1455 ,bottom=860 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계 좌 번 호 :' ,left=56 ,top=323 ,right=262 ,bottom=378 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소         속 :' ,left=56 ,top=222 ,right=265 ,bottom=278 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사         번 :' ,left=56 ,top=124 ,right=265 ,bottom=180 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2167 ,right=1971 ,bottom=2167 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2082 ,right=1971 ,bottom=2082 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1992 ,right=1971 ,bottom=1992 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1924 ,right=1971 ,bottom=1924 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1553 ,right=1971 ,bottom=1553 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1463 ,right=1971 ,bottom=1463 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1394 ,right=1971 ,bottom=1394 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=876 ,right=1971 ,bottom=876 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=786 ,right=1971 ,bottom=786 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=754 ,right=1971 ,bottom=754 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=669 ,right=1971 ,bottom=669 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=601 ,right=1971 ,bottom=601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=0 ,right=1971 ,bottom=0 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<I>id='../../Common/img/icon.jpg' ,left=1577 ,top=489 ,right=1958 ,bottom=590</I>
	<L> left=29 ,top=0 ,right=29 ,bottom=601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=0 ,right=1971 ,bottom=601 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<C>id='EMPNMK', left=1376, top=124, right=1646, bottom=180, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='성         명 :' ,left=1095 ,top=124 ,right=1347 ,bottom=180 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='EMPNO', left=307, top=124, right=577, bottom=180, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=307, top=222, right=577, bottom=278, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직         위 :' ,left=1095 ,top=225 ,right=1347 ,bottom=280 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYGRDNM', left=1376, top=225, right=1646, bottom=280, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=32 ,top=1167 ,right=1969 ,bottom=1167 </L>
	<L> left=32 ,top=1029 ,right=1969 ,bottom=1029 </L>
	<L> left=32 ,top=958 ,right=1969 ,bottom=958 </L>
	<L> left=32 ,top=1098 ,right=1969 ,bottom=1098 </L>
	<L> left=32 ,top=1236 ,right=1969 ,bottom=1236 </L>
	<L> left=32 ,top=1310 ,right=1969 ,bottom=1310 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=32 ,top=1775 ,right=1969 ,bottom=1775 </L>
	<L> left=32 ,top=1635 ,right=1969 ,bottom=1635 </L>
	<L> left=32 ,top=1707 ,right=1969 ,bottom=1707 </L>
	<L> left=32 ,top=1849 ,right=1969 ,bottom=1849 </L>
	<L> left=32 ,top=2336 ,right=1969 ,bottom=2336 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=32 ,top=2252 ,right=1969 ,bottom=2252 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=669 ,right=29 ,bottom=754 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=669 ,right=1971 ,bottom=754 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='실 수 령 액' ,left=1344 ,top=683 ,right=1519 ,bottom=738 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S93000', left=913, top=683, right=1320, bottom=738, align='right'</C>
	<T>id='공 제 총 액' ,left=701 ,top=683 ,right=889 ,bottom=738 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S91000', left=265, top=683, right=672, bottom=738, align='right'</C>
	<T>id='지 급 총 액' ,left=53 ,top=683 ,right=233 ,bottom=738 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='S94000', left=1537, top=683, right=1945, bottom=738, align='right'</C>
	<L> left=1527 ,top=672 ,right=1527 ,bottom=754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=900 ,top=672 ,right=900 ,bottom=754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=246 ,top=672 ,right=246 ,bottom=754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1331 ,top=672 ,right=1331 ,bottom=754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=685 ,top=672 ,right=685 ,bottom=754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=786 ,right=29 ,bottom=1394 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=786 ,right=1971 ,bottom=1394 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=1463 ,right=1971 ,bottom=1924 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=1463 ,right=29 ,bottom=1924 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='주민세' ,left=58 ,top=1646 ,right=278 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='T12000', left=307, top=1646, right=503, bottom=1701, align='right'</C>
	<C>id='T11000', left=307, top=1572, right=503, bottom=1627, align='right'</C>
	<T>id='갑근세' ,left=58 ,top=1572 ,right=278 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타공제1' ,left=1495 ,top=1572 ,right=1715 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BX0010', left=1749, top=1572, right=1945, bottom=1627, align='right'</C>
	<C>id='BX0040', left=1749, top=1783, right=1945, bottom=1839, align='right'</C>
	<T>id='기타공제4' ,left=1495 ,top=1783 ,right=1715 ,bottom=1839 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BX0030', left=1749, top=1715, right=1945, bottom=1770, align='right'</C>
	<C>id='BX0020', left=1749, top=1646, right=1945, bottom=1701, align='right'</C>
	<T>id='기타공제2' ,left=1495 ,top=1646 ,right=1715 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타공제3' ,left=1495 ,top=1715 ,right=1715 ,bottom=1770 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B14000', left=1267, top=1646, right=1463, bottom=1701, align='right'</C>
	<T>id='여직원회비' ,left=1019 ,top=1646 ,right=1238 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='공조회비' ,left=1019 ,top=1572 ,right=1238 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B16000', left=1267, top=1572, right=1463, bottom=1627, align='right'</C>
	<T>id='고용보험' ,left=534 ,top=1715 ,right=754 ,bottom=1770 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B13000', left=783, top=1715, right=979, bottom=1770, align='right'</C>
	<T>id='개인연금' ,left=534 ,top=1783 ,right=754 ,bottom=1839 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B15000', left=783, top=1783, right=979, bottom=1839, align='right'</C>
	<C>id='B11000', left=783, top=1572, right=979, bottom=1627, align='right'</C>
	<T>id='건강보험' ,left=534 ,top=1572 ,right=754 ,bottom=1627 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='B12000', left=783, top=1646, right=979, bottom=1701, align='right'</C>
	<T>id='국민연금' ,left=534 ,top=1646 ,right=754 ,bottom=1701 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='회    사    대    출' ,left=1548 ,top=2011 ,right=1908 ,bottom=2066 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='당월불입액' ,left=1019 ,top=2101 ,right=1238 ,bottom=2156 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계액' ,left=1257 ,top=2101 ,right=1476 ,bottom=2156 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='누계횟수' ,left=778 ,top=2101 ,right=997 ,bottom=2156 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='금융기관' ,left=294 ,top=2101 ,right=513 ,bottom=2156 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='총불일기간' ,left=534 ,top=2101 ,right=754 ,bottom=2156 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='저축종류' ,left=58 ,top=2101 ,right=278 ,bottom=2156 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P11000', left=307, top=968, right=503, bottom=1024, align='right'</C>
	<C>id='P12000', left=307, top=1037, right=503, bottom=1093, align='right'</C>
	<C>id='P21000', left=307, top=1106, right=503, bottom=1162, align='right'</C>
	<C>id='P22000', left=307, top=1175, right=503, bottom=1230, align='right'</C>
	<C>id='P23000', left=307, top=1244, right=503, bottom=1299, align='right'</C>
	<C>id='P10000', left=307, top=894, right=503, bottom=950, align='right'</C>
	<C>id='P24000', left=307, top=1320, right=503, bottom=1376, align='right'</C>
	<T>id='차랑유지비' ,left=58 ,top=1320 ,right=278 ,bottom=1376 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기본급' ,left=58 ,top=894 ,right=278 ,bottom=950 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='가족부양비' ,left=58 ,top=1244 ,right=278 ,bottom=1299 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자기계발비' ,left=58 ,top=1175 ,right=278 ,bottom=1230 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='근속수당' ,left=58 ,top=1106 ,right=278 ,bottom=1162 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직책수당' ,left=58 ,top=968 ,right=278 ,bottom=1024 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='시간외수당' ,left=58 ,top=1037 ,right=278 ,bottom=1093 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1495 ,top=1320 ,right=1715 ,bottom=1376 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1749, top=1320, right=1945, bottom=1376, align='right'</C>
	<T>id='기타지급1' ,left=1495 ,top=894 ,right=1715 ,bottom=950 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PX0010', left=1749, top=894, right=1945, bottom=950, align='right'</C>
	<C>id='', left=1749, top=1244, right=1945, bottom=1299, align='right'</C>
	<T>id='' ,left=1495 ,top=1244 ,right=1715 ,bottom=1299 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1749, top=1175, right=1945, bottom=1230, align='right'</C>
	<C>id='PX0040', left=1749, top=1106, right=1945, bottom=1162, align='right'</C>
	<C>id='PX0030', left=1749, top=1037, right=1945, bottom=1093, align='right'</C>
	<C>id='PX0020', left=1749, top=968, right=1945, bottom=1024, align='right'</C>
	<T>id='지타지급4' ,left=1495 ,top=1106 ,right=1715 ,bottom=1162 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급3' ,left=1495 ,top=1037 ,right=1715 ,bottom=1093 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기타지급2' ,left=1495 ,top=968 ,right=1715 ,bottom=1024 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1495 ,top=1175 ,right=1715 ,bottom=1230 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P37000', left=783, top=968, right=979, bottom=1024, align='right'</C>
	<T>id='개인연금보조' ,left=534 ,top=968 ,right=754 ,bottom=1024 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='출납수당' ,left=534 ,top=1106 ,right=754 ,bottom=1162 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='운전수당' ,left=534 ,top=1175 ,right=754 ,bottom=1230 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='연장수당' ,left=534 ,top=1244 ,right=754 ,bottom=1299 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P27000', left=783, top=1244, right=979, bottom=1299, align='right'</C>
	<C>id='P26000', left=783, top=1175, right=979, bottom=1230, align='right'</C>
	<C>id='P25000', left=783, top=1106, right=979, bottom=1162, align='right'</C>
	<C>id='P32000', left=783, top=1037, right=979, bottom=1093, align='right'</C>
	<C>id='P28000', left=783, top=1320, right=979, bottom=1376, align='right'</C>
	<T>id='자격수당' ,left=534 ,top=1320 ,right=754 ,bottom=1376 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P29000', left=783, top=894, right=979, bottom=950, align='right'</C>
	<T>id='남북경협수당' ,left=534 ,top=894 ,right=754 ,bottom=950 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=995 ,top=876 ,right=995 ,bottom=1392 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1003 ,top=876 ,right=1003 ,bottom=1392 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1476 ,top=878 ,right=1476 ,bottom=1394 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1730 ,top=878 ,right=1730 ,bottom=1394 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=878 ,right=291 ,bottom=1394 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=878 ,right=516 ,bottom=1394 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=770 ,top=878 ,right=770 ,bottom=1394 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1251 ,top=878 ,right=1251 ,bottom=1394 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=1556 ,right=516 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1251 ,top=1556 ,right=1251 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=770 ,top=1556 ,right=770 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1730 ,top=1556 ,right=1730 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1476 ,top=1556 ,right=1476 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=1556 ,right=291 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1003 ,top=1556 ,right=1003 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=995 ,top=1556 ,right=995 ,bottom=1924 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='저    축    내    역' ,left=619 ,top=2011 ,right=979 ,bottom=2066 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1487 ,top=1992 ,right=1487 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1479 ,top=1995 ,right=1479 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1730 ,top=2082 ,right=1730 ,bottom=2421 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=2085 ,right=291 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1251 ,top=2085 ,right=1251 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1003 ,top=2085 ,right=1003 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=2085 ,right=516 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=770 ,top=2085 ,right=770 ,bottom=2424 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=29 ,top=1992 ,right=29 ,bottom=2424 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=1992 ,right=1971 ,bottom=2424 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2424 ,right=1971 ,bottom=2424 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='누    계     내     역' ,left=328 ,top=2514 ,right=688 ,bottom=2569 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2752 ,right=1971 ,bottom=2752 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2667 ,right=1971 ,bottom=2667 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2582 ,right=1971 ,bottom=2582 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=2495 ,right=1971 ,bottom=2495 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1971 ,top=2495 ,right=1971 ,bottom=2752 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='3669-3682, 3669-3915' ,left=1193 ,top=2598 ,right=1802 ,bottom=2654 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='급여/상여 문의 및 주소 변경' ,left=1193 ,top=2514 ,right=1741 ,bottom=2569 ,align='left' ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주민세누계' ,left=534 ,top=2601 ,right=754 ,bottom=2656 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='갑근세누계' ,left=294 ,top=2601 ,right=513 ,bottom=2656 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='소득누계' ,left=56 ,top=2601 ,right=275 ,bottom=2656 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=29 ,top=2495 ,right=29 ,bottom=2752 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=770 ,top=2588 ,right=770 ,bottom=2754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=516 ,top=2588 ,right=516 ,bottom=2754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=291 ,top=2588 ,right=291 ,bottom=2754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<L> left=1000 ,top=2498 ,right=1000 ,bottom=2754 ,penstyle=solid ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='지역근무수당' ,left=534 ,top=1037 ,right=754 ,bottom=1093 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='전월소급' ,left=1019 ,top=1246 ,right=1238 ,bottom=1302 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P39000', left=1267, top=1246, right=1463, bottom=1302, align='right'</C>
	<C>id='P38000', left=1267, top=1169, right=1463, bottom=1225, align='right'</C>
	<T>id='임원직책수당' ,left=1019 ,top=1169 ,right=1238 ,bottom=1225 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='P36000', left=1267, top=1101, right=1463, bottom=1156, align='right'</C>
	<C>id='P34000', left=1267, top=1032, right=1463, bottom=1087, align='right'</C>
	<C>id='P31000', left=1267, top=963, right=1463, bottom=1019, align='right'</C>
	<C>id='P30000', left=1267, top=894, right=1463, bottom=950, align='right'</C>
	<T>id='연차수당' ,left=1019 ,top=1032 ,right=1238 ,bottom=1087 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='특수지수당' ,left=1019 ,top=963 ,right=1238 ,bottom=1019 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='사장단수당' ,left=1019 ,top=894 ,right=1238 ,bottom=950 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='학비보조금' ,left=1019 ,top=1101 ,right=1238 ,bottom=1156 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='' ,left=1019 ,top=1320 ,right=1238 ,bottom=1376 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1273, top=1320, right=1468, bottom=1376, align='right'</C>
	<C>id='CTITLE', left=497, top=29, right=1503, bottom=116 ,mask='( XXXX 년 XX 월 ) XXXX 명세서', face='Arial', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYBNKNM', left=307, top=323, right=524, bottom=378, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYNUM', left=532, top=323, right=1066, bottom=378, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='급         호 :' ,left=1095 ,top=323 ,right=1347 ,bottom=378 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PAYSEQNM', left=1376, top=323, right=1646, bottom=378, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYDT', left=56, top=455, right=325, bottom=511, align='left' ,mask='XXXX-XX-XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='귀하의 노고에 감사 드립니다.' ,left=479 ,top=423 ,right=1511 ,bottom=511 ,align='left' ,face='궁서' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TT1200', left=558, top=2683, right=754, bottom=2738, align='right'</C>
	<C>id='TS9100', left=77, top=2683, right=273, bottom=2738, align='right'</C>
	<C>id='TT1100', left=307, top=2683, right=503, bottom=2738, align='right'</C>
</B>
	">

</OBJECT></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	




<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인사고과관리 - 피고과자선정 - 피고과자 생성
+ 프로그램 ID	: H060002_popup.HTML
+ 기 능 정 의	: 채용안내정보
+ 변 경 이 력	: 
+ 서 블 릿 명	: h060002_s1,h060002_s11,h060002_s12,h060002_t1,
                h060002_t2
============================================
+ 추가항목	: 고과자 생성시 기생성고과자인 경우 고과지정 테이블도 삭제해야함.
------------------------------------------------------------------------------
+ 수정내용 : 일반고과와 부서장고과 피고과자 구분해서 생성함. 
+ 수정일자 : 2009.11.03
+ 수 정 자 : 정영식
------------------------------------------------------------------------------>
<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>피고과자 생성</title>



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
var gstrcurdate; 
var gs_level;
var gs_treecd;
var gs_yyyymmdd;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function ln_Start(){

  gcem_yymm2.text = gcurdate.substring(0,7); 
  gcem_dt.text = gcurdate; 
	gstrcurdate = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10); 
  gcem_yymmdd.text = gstrcurdate;
  gs_yyyymmdd = gcurdate.substring(0,10);
	
	ln_Luxecombo_load();

	gcrd_gubun.codevalue='1';
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
 
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060002_s11?v_str1="+fn_trim(gcem_yymm2.text)
	                                                      +"&v_str2="+fn_trim(gclx_deptcd.bindcolval)
																												+"&v_str3="+fn_trim(gcem_empnof.text)
																												+"&v_str4="+fn_trim(gcem_empnot.text)		
																												+"&v_str5="+fn_trim(gcem_dt.text)
																												+"&v_str6="+gs_level
																												+"&v_str7="+gs_treecd;
	//prompt("",gcds_data.Dataid);
	gcds_data.Reset();

	if (gcds_data.countrow>0) {
	
		if (confirm( "현재월에 기생성된 피고과자가 존재합니다. 기생성 피고과자를 삭제 후 다시 생성하겠습니까?")) {

			//기생성 피고과자 삭제
      gcds_data.DeleteAll();
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060002_t1";
			//prompt("",gcds_data.text);
			gctr_data.post();
       			
			//피고과자 생성
       ln_Create();
		}

	}else{
		//피고과자 신규생성
		if (confirm("피고과자를 생성 하시겠습니까?")){
			ln_Create();
		}
	}
}


/******************************************************************************
	Description : 인사기본정보에서 피고과자 생성
******************************************************************************/
function ln_Create(){
	
  //2008.11.15.JYS 재택근무로 인한 부서로 임의 막음.
  //소속, 사번FR, 사번TO, 입사일자 ,생성년월
	/*
	gcds_person.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060002_s12?v_str1="+fn_trim(gclx_deptcd.bindcolval)
	                                                         +"&v_str2="+fn_trim(gcem_empnof.text)
																													 +"&v_str3="+fn_trim(gcem_empnot.text)		
																													 +"&v_str4="+fn_trim(gcem_dt.text) 
																													 +"&v_str5="+fn_trim(gcem_yymm2.text)
																													 +"&v_str6="+gs_level
																												   +"&v_str7="+gs_treecd
																													 +"&v_str8="+fn_trim(gcem_yymmdd.text)
																													 +"&v_str9="+gs_yyyymmdd;
	gcds_person.Reset();
  */

	gcds_person.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060002_s22?v_str1="+fn_trim(gclx_deptcd.bindcolval)
	                                                         +"&v_str2="+fn_trim(gcem_empnof.text)
																													 +"&v_str3="+fn_trim(gcem_empnot.text)		
																													 +"&v_str4="+fn_trim(gcem_dt.text) 
																													 +"&v_str5="+fn_trim(gcem_yymm2.text)
																													 +"&v_str6="+gs_level
																												   +"&v_str7="+gs_treecd
																													 +"&v_str8="+fn_trim(gcem_yymmdd.text)
																													 +"&v_str9="+gs_yyyymmdd;
  //prompt('',gcds_person.DataID);
	gcds_person.Reset(); 
	
}


/******************************************************************************
	Description : 피고과자 생성
******************************************************************************/
function ln_Data_Create(row){

 // alert("row::::"+row)

	if (row>0) {
		for (i=1;i<=row;i++) {
			gcds_person.UserStatus(i) = 1;
			gcds_person.namevalue(i , "WRDT") = gstrcurdate;
		}
	
		gctr_person.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060002_t2";
		//prompt("",gcds_person.text);
		gctr_person.post();		
    
		alert( "총 " +row+ " 명의 피고자가 생성 되었습니다"); 
	}

}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

  if(gcrd_gubun.codevalue=="1"){
		//피고과자 기 생성자가 존재할 경우 Grid에 뿌려줌
		ln_Query();
	}else if(gcrd_gubun.codevalue=="2"){
    //부서장관련 피고과자 생성
		ln_Hvemp_Dpt();
	}

	//피고과자가  기 생성자가 존재하지 않을 경우 인사 Master에서 복사함.
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

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : 창닫기
******************************************************************************/
function ln_Close(e){
	window.close();
}

/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//소속
	gcds_deptcd.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";  
	//prompt("gcds_deptcd", gcds_deptcd.DataID);
	gcds_deptcd.Reset();
	//alert(gcds_deptcd.countrow);
    
}

/******************************************************************************
	Description : 부서장관련 고과대상자(피고과자)생성
******************************************************************************/
function ln_Hvemp_Dpt(){
	if (confirm(gcem_yymm2.text+"월 부서장관련 고과 대상자를 생성하시겠습니까?")) {
      gcds_data3.clearAll();
			ln_SetDataHeader();
			gcds_data3.Addrow();
			gcds_data3.namevalue(gcds_data3.rowposition,"EVAYM")=gcem_yymm2.text;
			gcds_data3.namevalue(gcds_data3.rowposition,"WRDT")=gstrcurdate;
  
			//기생성 피고과자 삭제
			gctr_data3.action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060002_t3";
			// prompt("",gcds_data3.text);
			gctr_data3.post();
	}
}


/******************************************************************************
	Description : Head 설정
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "EVAYM:STRING(6),WRDT:STRING(8)";
	gcds_data3.SetDataHeader(s_temp);
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
 <object id=gcds_data classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
 </object>

 <object id=gcds_data3 classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="false">
 </object>
 
 </comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_person classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcds_deptcd classid=clsid:3267ea0d-b5d8-11d2-a4f9-00608cebee49 viewastext>
	<param name="syncload" value="true">
 <!--  <param name="SortExpr" value="+TREECD"> -->
</object></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060002_t1(I:USER=gcds_data)">
</object>

<object id=gctr_data3 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060002_t3(I:USER=gcds_data3)">
</object>

</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
 <object id=gctr_person classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060002_t2(I:USER=gcds_person)">
 </object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	//window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language=JavaScript  for=gcds_person event=OnLoadCompleted(rowcount)>

	ln_Data_Create(rowcount);
</script>



<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
			gcds_deptcd.insertrow(1);
			gcds_deptcd.namevalue(1,"DEPTCD") = "";
			gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
			gclx_deptcd.index = 0;
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<script language=JavaScript for= gcem_yymmdd event=onKillFocus()>
 
  gs_yyyymmdd = gcem_yymmdd.text;
	gs_yyyymmdd = gs_yyyymmdd.substring(0,4) +'-'+ gs_yyyymmdd.substring(4,6) +'-'+gs_yyyymmdd.substring(6,8); 
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data3 event=OnSuccess()>
    alert("생성하였습니다.");
</script>


<script language=JavaScript for=gctr_data3 event=OnFail()>
		alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:560px;height:255px;border:1 solid #708090">
	<tr >
		<td width="560px"  height="30px;" align="right" border=1 colspan="4">
			<img src="../img/h060002_popup_head.gif" style="position:relative;left:-5px;top:2px;">
			<img name="btn_save"		src="../../Common/img/btn/com_b_create.gif" style="cursor:hand;position:relative;right:5px;top:0px;" onclick="ln_Save()">
			<img name="btn_cancel"  src="../../Common/img/btn/com_b_cancle.gif" style="cursor:hand;position:relative;right:5px;top:0px;" onclick="ln_Close()"> 
		</td>
	</tr>
	<tr>
		<td rowspan="8" >
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  
			style="WIDTH:317px; HEIGHT:220px;border:1 solid #777777;display:block;" viewastext>
			<PARAM NAME="DataID"		  VALUE="gcds_data">
			<PARAM NAME="Editable"    VALUE="false">
			<PARAM NAME="BorderStyle" VALUE="0">
			<param name="sortview"    value=left>
			<param name="Fillarea"	  VALUE="true">
			<PARAM NAME="Format"		  VALUE="  
				<C> Name='사  번' ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=67   align=center , sort = true</C> 
				<C> Name='성  명' ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=128   align=reft , sort = true</C> 
				<C> Name='생성고과년월' ID=WRDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=center  mask='XXXX/XX' </C>  
			">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="245px" border=1>
			<tr>
				<td  width="70px"  height ="25px" style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-left-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center>&nbsp;&nbsp;생성구분</td>
				<td  width="160px" style="border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-left-width:0px;border-bottom-width:0px;position:relative;left:-5px;">&nbsp;&nbsp;
				<comment id="__NSID__">
				   <object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:25;width:120">
						<param name=Cols	  value="2">
						<param name=Format	value="1^일반,2^부서장">
					</object>
				 </comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
				</td>
			</tr>

			<tr>
				<td  width="70px"  height ="25px" style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-left-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center>&nbsp;&nbsp;고과년월</td>
				<td  width="170px" style="border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-left-width:0px;border-bottom-width:0px;position:relative;left:-5px;">&nbsp;&nbsp;
				<comment id="__NSID__"><object id=gcem_yymm2                
				   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
					style="position:relative; left:-5px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; " 
					validFeatures="ignoreStatus=yes" validExp=""> 
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr></td>
				</td>
			</tr>
			<tr>
				<td  width="70px"  height="25px" style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-left-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center>&nbsp;고과기준일</td>
				<td  width="170px" style="border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-left-width:0px;border-bottom-width:0px;position:relative;left:-5px;">&nbsp;&nbsp;
				<comment id="__NSID__"><object id=gcem_yymmdd                
				   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
					style="position:relative;left:-5px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt; " > 
					<param name=Alignment	  value=0>
					<param name=Border	      value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr></td>
				</td>
			</tr>
			<tr>
				<td  width="70px"  height  = "25px" style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-left-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center>&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
				<td  width="170px" style="border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-left-width:0px;border-bottom-width:0px">&nbsp;&nbsp;
				<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;top:2px;left:-10px;height:150px; width:125px;">
					<param name=ComboDataID           value=gcds_deptcd>
					<param name=SearchColumn          value="DEPTNM">
					<param name=Sort                  value=false>
					<param name=ListExprFormat        value="DEPTNM^0^138">       
					<param name=BindColumn            value="DEPTCD"> 
				</object></comment><script>__ws__(__NSID__);</script>		
				</td>
			</tr>
			<tr >
				<td width="70px" height  = "25px" style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-left-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center>&nbsp;&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;번</td>
				<td width="170px" style="border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-left-width:0px;border-bottom-width:0px"><nobr>
					<comment id="__NSID__"><object id=gcem_empnof classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:7px;top:3px; width:53px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="0000000">
							<param name=PromptChar	  value="_">
							<param name=Enable				value=true>
				  </object></comment><script>__ws__(__NSID__);</script>
					&nbsp;&nbsp;~
					<comment id="__NSID__"><object id=gcem_empnot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:8px;top:3px; width:53px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="0000000">
							<param name=PromptChar	  value="_">
							<param name=Enable				value=true>
				  </object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
				</td>
			</tr>
			<tr >
				<td width="70px;" height  = "25px;" style="border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-left-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center>&nbsp;&nbsp;입사일자</td>
				<td width="170px" style="border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-left-width:0px;border-bottom-width:1px">
					<comment id="__NSID__"><object id=gcem_dt    classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
						style="position:relative; left:7px;top:3px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value=true>
				  </object></comment><script>__ws__(__NSID__);</script>&nbsp;
				  <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dt', 'Text')" style="position:relative;width:20px;left:1px;top:2px;cursor:hand;">이전
				 </td>
			</tr>
			<tr>
				<td width="70px;" height="67px;" style="border:0 solid #708090;border-right-width:1px;border-top-width:0px;border-left-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" >&nbsp;&nbsp;</td>
				<td width="170px" style="border:0 solid #708090;border-right-width:0px;border-top-width:0px;border-left-width:0px;border-bottom-width:1px">&nbsp;</td>	
			</tr>

			<tr><td height="18px" bgcolor="#eeeeee">조회건수 : <label id="lbl_search"></label></td>
					<td height="18px" bgcolor="#eeeeee"></td><td height="18px" bgcolor="#eeeeee"></td>
			</tr>
		</td>
	</tr>

</table>

</body>
</html>


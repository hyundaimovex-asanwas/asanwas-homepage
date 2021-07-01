<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/퇴직금충당금관리
+ 프로그램 ID	: p040007.HTML
+ 기 능 정 의	: 조회|엑셀|실행
+ 변 경 이 력	: 
+ 수 정 이 력	: 이순미 - 2005.08.03 - 소스 정리
+ 서 블 릿 명	: p040007_s1, p040007_s2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>퇴직금충당금관리</title>


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
get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);
var gs_date3 = gcurdate.substr(5,2);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcem_yyyymm2.Text=gs_date2;

	//소속정보
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?v_str1="; 
	gcds_dept.Reset();

	//직급정보
	//gcds_dept02.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	//gcds_dept02.Reset();

	//직위코드
	gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002"; 
	gcds_paycd1.Reset();
	
	ln_HeadMm();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

	var str1=fn_trim(gcem_yyyymm2.Text);							//기준년월
	var str2=fn_trim(gclx_select_ec02az.BindColVal);	//소속
	var str3=fn_trim(gclx_select_grade4.BindColVal);	//직급
	var str4=fn_trim(txt_kname.value);								//성명

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040007_s1?"
												 + "v_str1=" + str1
												 + "&v_str2=" + str2
												 + "&v_str3=" + str3
												 + "&v_str4=" + str4;
	gcds_data.Reset();
	gcds_data.rowposition=1;

	ln_HeadMm();
}

/*******************************************************************************
  Description : 실행
******************************************************************************/
function ln_Excute() {
	
	var str1=fn_trim(gcem_yyyymm2.Text);	//기준년월
	var str5=gs_date;											//현재일자
	var str6="6";													//고정값 '6'
	var str7="N";													//고정값 'N'
	var str8="SP_P600000";								//프로시져명

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040007_s2?"
												 + "v_str1=" + str1
												 + "&v_str5=" + str5
												 + "&v_str6=" + str6
												 + "&v_str7=" + str7
												 + "&v_str8=" + str8;
	gcds_data.Reset();
	gcds_data.rowposition=1;

}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
/*function ln_Excel(){
	if (gcds_data.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_reresult.RunExcel('퇴직충담금내역');
}
*/
function ln_Excel(){
	//gcgd_data01.RunExcel("계정별잔액장 결재전");
  if (gcds_data.countrow<1) alert("다운로드하실 자료가 없습니다.");
  else gcgd_reresult.GridToExcel("계정별잔액장 결재전","",2);
}



/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_add(){

	gcds_pyo.addrow();
	//ln_format('B');
	//txt_usrid.focus();
	gcds_pyo.namevalue(gcds_pyo.rowposition,"WRID") = gusrid;
	gcds_pyo.namevalue(gcds_pyo.rowposition,"WRDT") = gs_date;

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
  
	if (gcds_data.IsUpdated) {	
		if (confirm("입력하신 사항을 저장하시겠습니까?")){
			gctr_data.KeyValue = "p040007_t1(I:USER=gcds_data)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p040007_t1";
			gctr_data.post();
			ln_Query();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_del(){
	
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_pyo.deleterow(gcds_pyo.rowposition);
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_COMMON%>hdasan_h060001_tr";
		gctr_data.post();
	}
}

/******************************************************************************
	Description : HeaDer 월 -1
******************************************************************************/
function ln_HeadMm(){

	var str1 = fn_trim(gcem_yyyymm2.Text);   //기준월

	if(str1.substr(4,2)=='01') { 
		gcgd_reresult.ColumnProp('BASAMT3', 'Name') = str1.substr(4,2)+"월";
		gcgd_reresult.ColumnProp('BASAMT2', 'Name') = "12"+"월";
		gcgd_reresult.ColumnProp('BASAMT1', 'Name') = "11"+"월";

		gcgd_reresult.ColumnProp('BAEAMT3', 'Name') = str1.substr(4,2)+"월";
		gcgd_reresult.ColumnProp('BAEAMT2', 'Name') = "12"+"월";
		gcgd_reresult.ColumnProp('BAEAMT1', 'Name') = "11"+"월";
	}else if(str1.substr(4,2)=='02') { 
		gcgd_reresult.ColumnProp('BASAMT3', 'Name') = str1.substr(4,2)+"월";
		gcgd_reresult.ColumnProp('BASAMT2', 'Name') = "01"+"월";
		gcgd_reresult.ColumnProp('BASAMT1', 'Name') = "12"+"월";

		gcgd_reresult.ColumnProp('BAEAMT3', 'Name') = str1.substr(4,2)+"월";
		gcgd_reresult.ColumnProp('BAEAMT2', 'Name') = "01"+"월";
		gcgd_reresult.ColumnProp('BAEAMT1', 'Name') = "12"+"월";
	}else	{
		if (str1.length ==2) {
			gcgd_reresult.ColumnProp('BASAMT3', 'Name') = str1.substr(4,2)+"월";
			gcgd_reresult.ColumnProp('BASAMT2', 'Name') = (Number(str1.substr(4,2))-1)+"월";
			gcgd_reresult.ColumnProp('BASAMT1', 'Name') = (Number(str1.substr(4,2))-2)+"월";

			gcgd_reresult.ColumnProp('BAEAMT3', 'Name') = str1.substr(4,2)+"월";
			gcgd_reresult.ColumnProp('BAEAMT2', 'Name') = (Number(str1.substr(4,2))-1)+"월";
			gcgd_reresult.ColumnProp('BAEAMT1', 'Name') = (Number(str1.substr(4,2))-2)+"월";
		}else{
			gcgd_reresult.ColumnProp('BASAMT3', 'Name') = str1.substr(4,2)+"월";
			gcgd_reresult.ColumnProp('BASAMT2', 'Name') = "0"+(Number(str1.substr(4,2))-1)+"월";
			gcgd_reresult.ColumnProp('BASAMT1', 'Name') = "0"+(Number(str1.substr(4,2))-2)+"월";

			gcgd_reresult.ColumnProp('BAEAMT3', 'Name') = str1.substr(4,2)+"월";
			gcgd_reresult.ColumnProp('BAEAMT2', 'Name') = "0"+(Number(str1.substr(4,2))-1)+"월";
			gcgd_reresult.ColumnProp('BAEAMT1', 'Name') = "0"+(Number(str1.substr(4,2))-2)+"월";
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="false">
		<PARAM NAME="SortExpr" VALUE="+EMPNMK">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!--소속-->
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dept02" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
  <PARAM NAME="SYNCLOAD" VALUE="false"><!--직급-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--직위-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p040007_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	//document.all.LowerFrame.style.visibility="visible";
	ft_cnt1.innerText="데이타 조회중입니다.";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
	alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0; //소속구분3
</script>

<script language="javascript" for="gcds_dept02" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_paycd1" event="onloadCompleted(row,colid)">
	gcds_paycd1.InsertRow(1);
	gcds_paycd1.NameValue(1,"MINORCD")="";
	gcds_paycd1.NameValue(1,"MINORNM")="전체";
	gclx_select_grade4.index=0;
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p040007_head.gif"></td>
    <td width="685" align="right"   background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_calc.gif" style="cursor:hand;position:relative;top:2px" onclick="ln_Excute()">
			<img src="../../Common/img/btn/com_b_save.gif"	style="cursor:hand;position:relative;top:2px" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand;position:relative;top:2px" onclick="ln_Excel()" >
			<img src="../../Common/img/btn/com_b_query.gif"	style="cursor:hand;position:relative;top:2px" onclick="ln_Query()">
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
    <table width="877" cellpadding="1" cellspacing="0" border="0">
      <tr> 
				<td colspan=8 align=left>
      <table width="877" cellpadding="1" cellspacing="0" border="0" style='border:1 solid #708090' >
        <tr> 
          <td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
						<nobr>&nbsp;기준년월&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px; padding-top:4px"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_yyyymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"  style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1  validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM">
							<param name=MaxLength     value=6>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
        		</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
						<nobr>&nbsp;소속&nbsp;</nobr></td>
				  <td style="border:0 solid #708090;border-right-width:1px;><nobr>&nbsp;</nobr></td> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px; padding-top:4px"><nobr>
						<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value=gcds_dept>
							<param name=SearchColumn		value="DEPTCD^DEPTNM">
							<param name=Sort            value="false">
							<param name=SortColumn			value="DEPTCD">
							<param name=ListExprFormat	value="DEPTNM^0^130">
							<param name=BindColumn			value="DEPTCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>  
          <td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
						<nobr>&nbsp;직위&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px; padding-top:4px"><nobr>
						<comment id="__NSID__"><object id=gclx_select_grade4  name="gclx_select_grade4" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value=gcds_paycd1>
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>  
          <td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
						<nobr>&nbsp;성명&nbsp;</nobr></td>
					<td style="padding-top:4px"><nobr><INPUT id=txt_kname name=txt_kname style="width:80px;" type=text class="txt21" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 
          <td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>                      
        </tr>
      </table>
         </td>
       </tr>
       <tr>
		 <td ALIGN=left>
  <table width="877" cellpadding="1" cellspacing="0" border="0">
    <tr> 
      <td style="width:877" ALIGN=LEFT VALIGN=TOP>
        <comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_reresult  style="WIDTH: 874px; HEIGHT: 415px;border:1 solid #777777;display:block;" viewastext>
					<PARAM NAME="DataID"          VALUE="gcds_data">
					<PARAM NAME="Editable"				VALUE="true">
					<PARAM NAME="ColSizing"				VALUE="True">
					<PARAM NAME="BorderStyle"			VALUE="0">
          <Param Name="SortView"        value="Left">
					<param name="Fillarea"				VALUE="true">
					<PARAM NAME="Format"          VALUE="  
						 
						<F> Name='성명'				ID=EMPNMK		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=55	align=LEFT	BgColor='#f5f5f5'</F>
						<F> Name='입사일'			ID=STRTDT		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70  align=CENTER  Mask='XXXX/XX/XX' BgColor='#f5f5f5' sort=true </F>
						
						<G> Name='급여(기본/직책/시간외)'	HeadAlign=Center	HeadBgColor=#B9D4DC 
							<C> Name='월'				ID=BASAMT1	HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
							<C> Name='월'				ID=BASAMT2	HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
							<C> Name='월'				ID=BASAMT3	HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
							<C> Name='급여 계'	ID=BASAMT		HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
						</G>
										
						<C> Name='평균급여'		ID=BASAVG		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70 align=RIGHT	</C>
						<C> Name='상여총액'		ID=BUSAMT		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70 align=RIGHT	</C>
						<C> Name='평균상여'		ID=BUSAVG		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70 align=RIGHT	</C>

						<G> Name='수당(근속/자기계발비/차량유지비/남북경협外)'	HeadAlign=Center	HeadBgColor=#B9D4DC 
							<C> Name='월'				ID=BAEAMT1	HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
							<C> Name='월'				ID=BAEAMT2	HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
							<C> Name='월'				ID=BAEAMT3	HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
							<C> Name='수당 계'	ID=BAEAMT		HeadBgColor=#B9D4DC Width=70	align=RIGHT </C>
						</G>

						<C> Name='평균수당' ID=BAEAVG HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70	align=RIGHT	</C>						
						<C> Name='년차수당'	ID=YEAPAY HeadAlign=YEAPAY	HeadBgColor=#B9D4DC Width=70  align=RIGHT	</C>
						<C> Name='평균년차'	ID=YEAAVG	HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70  align=RIGHT	</C>
						<C> Name='평균계'		ID=AVGTOT HeadAlign=AVGTOT	HeadBgColor=#B9D4DC Width=70  align=RIGHT</C>
						
						<C> Name='년수'			ID=DUYEAR HeadAlign=DUYEAR	HeadBgColor=#B9D4DC Width=30  align=RIGHT	</C>
						<C> Name='월수'			ID=DUYMM HeadAlign=DUYMM		HeadBgColor=#B9D4DC Width=30  align=RIGHT	</C>
						
						<C> Name='퇴직금액' ID=PRGAMT HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70  align=RIGHT	</C>

						<C> Name='전기설정'					ID=ENDJAMT	HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70		align=RIGHT	</C>
						<C> Name='감소(퇴사)'				ID=PRGJAMT	HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70		align=RIGHT	</C>
						<C> Name='추가설정액'				ID=PRGADD		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70		align=RIGHT	</C>
						<C> Name='충당금;연말잔액'	ID=PRGTOT		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=85	align=RIGHT	</C>

						<C> Name='사번'				ID=EMPNO		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=55  align=CENTER</C>
						<C> Name='근무지'			ID=DEPTPRNM	HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=125  align=LEFT	</C>
						<C> Name='소속'				ID=DEPTNM		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=125  align=LEFT	</C>
						<C> Name='직위'				ID=PAYGNM		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=80  align=LEFT	</C>
						<C> Name='주민번호'		ID=RESINO		HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=90  align=CENTER	Mask='XXXXXX-XXXXXXX'</C>
						<C> Name='그룹입사일'	ID=GRSTRTDT	HeadAlign=CENTER	HeadBgColor=#B9D4DC Width=70  align=CENTER	Mask='XXXX/XX/XX'</C>  
					">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				
				<fieldset style="width:876;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
					<font id=ft_cnt1 style="position:relative;top:4px;"></font>
				</fieldset>
      </td>       
    </tr>
  </table>
	</td>
		</tr>
			</table>
		<td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
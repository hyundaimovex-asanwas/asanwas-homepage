<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: H020004.HTML
+ 기 능 정 의	: 조회,엑셀
+ 변 경 이 력	: 
+ 서 블 릿 명	: h020004_s1, h020004_s2, hclcode_s1
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>채용면접관리</title>


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
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	var ls_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gcurdate;

	//응시분야
	gcds_before.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h020004_s2?v_str1=" + ls_date;
	gcds_before.Reset();

	//전공
	gcds_pieduc.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1129";
	gcds_pieduc.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h020004_s1"
									 + "?v_str1=" + fn_trim(gcem_fr.text) 
									 + "&v_str2=" + fn_trim(gcem_to.text)
									 + "&v_str3=" + fn_trim(gclx_info.bindcolval);
	gcds_data.Reset();
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
	if (gcds_data.countrow<1) alert("출력하실 정보가 없습니다.");
	else {
		var ls_temp = "";
		for (var i=1;i<=gcds_data.countcolumn;i++) {
			if (i==1) ls_temp += gcds_data.columnid(i) + ":" + gcds_data.ColumnType(i);
			else {
				var col = gcds_data.ColumnIndex(gcds_data.columnid(i));
				col = gcds_data.ColumnType(col)
				if (col==1) ls_temp += "," + gcds_data.ColumnID(i) + ":STRING";
				else if (col==3) ls_temp += "," + gcds_data.ColumnID(i) + ":DECIMAL";
				else if (col==5) ls_temp += "," + gcds_data.ColumnID(i) + ":URL";
			}
		}

		gcds_report.SetDataHeader(ls_temp);

		for (var s=1;s<=gcds_data.countrow;s++){
			if (gcds_data.namevalue(s,"CHK") == "T") {
				gcds_report.addrow();
				for (var k=1;k<=gcds_data.countcolumn;k++) {
					if(gcds_data.columnid(k)=="GROWTH" || gcds_data.columnid(k)=="SCHOOL"
					   || gcds_data.columnid(k)=="CAREER" || gcds_data.columnid(k)=="CAREER" )
						 gcds_report.namevalue(gcds_report.rowposition,gcds_data.columnid(k)) = ln_Multiline_Text(fn_trim(gcds_data.namevalue(s,gcds_data.columnid(k))),139);
					else
						 gcds_report.namevalue(gcds_report.rowposition,gcds_data.columnid(k)) = gcds_data.namevalue(s,gcds_data.columnid(k));

				}
			}
		}

		gcrp_print.preview();
	}
}


/******************************************************************************
	Description : 보고서 멀티라인 자동개행
	-- ln_Multiline_Text(문자열,자동개행할 가로 문자열길이(첫문자가 0임))
******************************************************************************/
function ln_Multiline_Text(str_text,Maxlen)
{      
		var num_s=new Array("0","1","2","3","4","5","6","7","8","9");  //숫자 길이체크 배열
		var str1 =str_text;  //문자열
		var seq_1=0;   //문자-2길이,숫자-1길이 
		var Rseq_1=0;  //실제 substr에서 쓰이는 index
		var Maxseq =Maxlen; //가로문자길이 최대
		var seq_2=1;     //현재 몇배수
		var Tlength=str1.length;
		var Rstr_value="";

		 for(var i=0; i<Tlength; i++)
		 {
			for(var j=0; j < num_s.length; j++)
			{
				if (str1.substr(i,1)==num_s[j])
				{
					seq_1++;
					break;
				}
				if (j==9) seq_1 += 2;
			}
			if(i == (Tlength-1))
			{ 
					if(str1.substring(Rseq_1,Tlength).indexOf(unescape("%0D"))!=-1)
					{
						 Rstr_value+=str1.substring(Rseq_1,Tlength);
					}
					else
					{
						 Rstr_value+=str1.substring(Rseq_1,Tlength)+unescape("%0D%0A");
					}

					break;

			}
            else
			{
				if(seq_1 > (Maxseq*seq_2)  )
				{   
					if(str1.substring(Rseq_1,i).indexOf(unescape("%0D"))!=-1)
					{
						 Rstr_value+=str1.substring(Rseq_1,i);
					}
					else
					{
						 Rstr_value+=str1.substring(Rseq_1,i)+unescape("%0D%0A");
					}

					seq_2++;
					Rseq_1=(i);
				}
			}
		}

        return Rstr_value;
}
/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	if (gcds_data.countrow<1) alert("다운로드 하실 자료가 없습니다");
	else gcgd_disp.runexcel("채용면접관리");	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_before classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_pieduc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_report classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_before" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_pieduc" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onClick(row,colid)">
	if (row<1 && colid == "CHK") {
		if (gcds_data.namevalue(1,"CHK") == "T") for (var i=1; i<=gcds_data.countrow; i++) gcds_data.namevalue(i,"CHK") = "F";
		else for (var i=1; i<=gcds_data.countrow; i++) gcds_data.namevalue(i,"CHK") = "T";
	}
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width=192 background="../../Common/img/com_t_bg.gif"><img src="../img/h020004_head.gif"></td>
    <td align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()"> 
			<!--img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onclick="ln_Print()"--> 
      <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table cellpadding="0" cellspacing="0" border="0" style="width:878px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
        <tr> 
					<td width="100" class="tab12" bgcolor="#eeeeee">검색일자</td>
					<td width="110px;"> &nbsp;
						<comment id="__NSID__">
						<object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
					</td>
					<td align=center>~&nbsp;</td>
					<td class="tab23" style="height:30px;">
						<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
					</td>
					<td width="100" class="tab12" bgcolor="#eeeeee">응시분야</td>
					<td>
 						<comment id="__NSID__"><object id=gclx_info classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 							style="position:relative;left:8px;top:1px;font-size:12px;width:250px;">
								<param name=ComboDataID			value="gcds_before">
								<param name=CBDataColumns		value="INFODIV, DSPNM">
  							<param name=SearchColumn		value=DSPNM>
  							<param name=Sort						value=false>
  							<param name=ListExprFormat	value="DSPNM^0^250">
	 							<param name=BindColumn			value=INFODIV>
 						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;
					</td>
					<td width="100px"></td>
				</tr>
			</table>
		</td>
	</tr>  	
	<tr><td colspan=2 height=3></td></tr>  	
  <tr> 
    <td colspan="2"> 
      <table width="500" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:500">
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="WIDTH: 876px; HEIGHT: 437px;border:1 solid #777777" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="true">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
						  <PARAM NAME="Format"			VALUE="  
								<F> Name='선택'					ID=CHK 			HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=center, BgColor='#f5f5f5', EditStyle=CheckBox, Cursor=hand</F>
								<F> Name='지원자'				ID=NMK 			HeadAlign=Center HeadBgColor=#B9D4DC Width=90  align=center, BgColor='#f5f5f5', Edit=none</F>
								<F> Name='지원일자'			ID=WRDT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, BgColor='#f5f5f5', Mask='XXXX/XX/XX', Edit=none</F>
								<F> Name='주민번호'			ID=RESINO 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, BgColor='#f5f5f5', Mask='XXXXXX-XXXXXXX', Edit=none</F>
								<C> Name='최종학력'			ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Edit=none</C>
								<C> Name='최종학교'			ID=SCHNM 		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left, Edit=none</C>
								<C> Name='학과'					ID=PGCCD 		HeadAlign=Center HeadBgColor=#B9D4DC Width=120 align=left, Editstyle=lookup, Data='gcds_pieduc:minorcd:minornm', Edit=none</C>
								<C> Name='평점'					ID=AVRUNI 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center, Edit=none</C>
								<C> Name='경력'					ID=CARYEAR	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=right, Edit=none</C>
								<C> Name='응시분야'			ID=INFO 		HeadAlign=Center HeadBgColor=#B9D4DC Width=190 align=left, Edit=none</C>
								<C> Name='관련자격증'		ID=LCSTPNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, Edit=none</C>
								<C> Name='출신도'				ID=BIRCNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Edit=none</C>
								<C> Name='종교'					ID=RILINM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Edit=none</C>
								<C> Name='병역구분'			ID=MILIDNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Edit=none</C>
								<C> Name='군별'					ID=MILIKNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Edit=none</C>
								<C> Name='계급'					ID=MILIGNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=87  align=center, Edit=none</C>
								<C> Name='결혼일자'			ID=MRYDT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Mask='XXXX/XX/XX', Edit=none</C>
								<C> Name='보훈대상'			ID=MRTDNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=108 align=center, Edit=none</C>
								<C> Name='영어이해정도' ID=ENGLNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center, Edit=none</C>
								<C> Name='TOEIC'				ID=TOESCR 	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=right, Edit=none</C>
								<C> Name='JPT'					ID=JPTSCR 	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=right, Edit=none</C>
								<C> Name='TOEFL'				ID=TOFSCR 	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=right, Edit=none</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:878px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
  </tr>
</table>

<!------------------------------------------------------------------------
레포트
-------------------------------------------------------------------------->
<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_data">
	<PARAM NAME="DetailDataID"			VALUE="gcds_report">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=Default ,left=0,top=0 ,right=2000 ,bottom=2654 ,face='굴림' ,size=10 ,penwidth=1
	<X>left=3 ,top=339  ,right=1974 ,bottom=852  ,border=true</X>
	<X>left=3 ,top=931  ,right=1974 ,bottom=1445 ,border=true</X>
	<X>left=3 ,top=1524 ,right=1974 ,bottom=2037 ,border=true</X>
	<X>left=3 ,top=2114 ,right=1974 ,bottom=2627 ,border=true</X>
	<X>left=3 ,top=273  ,right=214 ,bottom=340  ,backcolor=#B1B1B1</X>
	<X>left=3 ,top=865  ,right=214 ,bottom=932  ,backcolor=#B1B1B1</X>
	<X>left=3 ,top=1458 ,right=214 ,bottom=1525 ,backcolor=#B1B1B1</X>
	<X>left=3 ,top=2048 ,right=455 ,bottom=2115 ,backcolor=#B1B1B1</X>
	<T>id='자 기 소 개 서' ,left=0 ,top=32 ,right=1974 ,bottom=146 ,face='HY견고딕' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성명 :'	 ,left=3 ,top=183 ,right=214  ,bottom=249  ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='성장배경' ,left=3 ,top=273 ,right=214  ,bottom=339  ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='학창생활' ,left=3 ,top=865 ,right=214  ,bottom=931  ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='경력사항' ,left=3 ,top=1458 ,right=214 ,bottom=1524 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='지원동기 및 입사후포부' ,left=5 ,top=2048 ,right=455 ,bottom=2114 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='RESINO',		left=545, top=183,	right=1154, bottom=249,		align='left' ,mask='주민등록번호 : XXXXXX-XXXXXXX', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NMK',			left=122, top=183,	right=333,	bottom=249,		align='left', face='굴림', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GROWTH',		left=19,	top=355,	right=1934, bottom=841,		align='left', Multiline=true</C>
	<C>id='SCHOOL',		left=21,	top=945,	right=1934, bottom=1431,	align='left', Multiline=true</C>
	<C>id='CAREER',		left=21,	top=1535, right=1934, bottom=2021,	align='left', Multiline=true</C>
	<C>id='AMBITION', left=21,	top=2125, right=1934, bottom=2611,	align='left', Multiline=true</C>
</B>
	">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
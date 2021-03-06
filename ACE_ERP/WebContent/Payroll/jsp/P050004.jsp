<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/학비보조금신청
+ 프로그램 ID	: p050004.HTML
+ 기 능 정 의	: 조회|등록|저장|삭제
+ 변 경 이 력	: 권영법
+ 수 정 이 력	: 이순미 - 2005.08.05 - 소스 정리
+ 서 블 릿 명	: p050004_s1, p050004_s2, p050004_s3, p050004_s4, p050004_t4
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>학비보조금신청</title>


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
var key_sabun="";
var gs_level;
var gs_treecd;

get_cookdata();
gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_yymm_search.Text=gs_date2;          //기준년월

	//소속정보
	gcds_dept.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?v_str1="; 
	gcds_dept.Reset();
}

/******************************************************************************
	Description : 조회 1
******************************************************************************/
function ln_Query(){
	var str1 = fn_trim(gcem_yymm_search.Text);						//기준년월
	var str2 = fn_trim(gclx_select_ec02az.BindColVal);    //소속gcem_yymm_search
	var str3 = fn_trim(txt_empnmk.value);									//성명
	
	if(str1.length != 6)	{
		alert("기준년월 6자리를 입력하세요");
	}else{
		gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050004_s1?"
										 + "v_str1=" + str2
										 + "&v_str2=" + str3
										 + "&v_str3=" + gs_level
								     + "&v_str4=" + gs_treecd;
		gcds_grid_ec01az.Reset(); //그리드
		gcds_grid_ec01az.rowposition=1;
	}
}

/******************************************************************************
	Description : 조회 2
******************************************************************************/
function ln_Query_2(){
	var str1 = fn_trim(gcem_yymm_search.Text);        //기준년월
	if(gcds_grid_ec01az.countrow>0)	{
		if(str1.length != 6)		{
			alert("기준년월 6자리를 입력하세요");
		}else{
			gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050004_s2?"
										 + "v_str1=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"EMPNO");
			gcds_grid_ec02az.Reset(); //그리드
			gcds_grid_ec02az.rowposition=1;
		}
	}
}

/******************************************************************************
	Description : 조회 3
******************************************************************************/
function ln_Query_3(){
	if(gcds_grid_ec02az.countrow > 0)	{
		var str1 = fn_trim(gcem_yymm_search.Text);        //기준년월
		if(str1.length != 6){
			alert("기준년월 6자리를 입력하세요");
		}else{
		gcds_grid_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050004_s3?"
										 + "v_str1=" + str1
										 + "&v_str2=" + gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"EMPNO");
		gcds_grid_ec03az.Reset(); //그리드
		gcds_grid_ec03az.rowposition=1;
		}
	}
}

/******************************************************************************
	Description : 등록
******************************************************************************/
function ln_Insert(){   //건강보험
	if(gcds_grid_ec02az.countrow > 0)	{
		var str1 = fn_trim(gcem_yymm_search.Text);        //기준년월
		if(str1.length != 6)	{
			alert("기준년월 6자리를 입력하세요");
		}else{
      var bchk=0;
			for(i=1;i <= gcds_grid_ec03az.countrow;i++)	{
				if(gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"EMPNO")
				==gcds_grid_ec03az.namevalue(i,"EMPNO") && gcds_grid_ec02az.namevalue(gcds_grid_ec02az.rowposition,"RESINO")
				==gcds_grid_ec03az.namevalue(i,"RESINO") && gs_date
				==gcds_grid_ec03az.namevalue(i,"APPDT"))
				{
					//alert(1);
					bchk=1;
					break;
				}
			}
			
      if(bchk==0)	{
				gcds_grid_ec03az.addRow();
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"EMPNO")
				=gcds_grid_ec01az.namevalue(gcds_grid_ec01az.rowposition,"EMPNO");
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"APPYM")=str1;
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"FAMNM")
				=gcds_grid_ec02az.namevalue(gcds_grid_ec02az.rowposition,"FAMNM");
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"RESINO")
				=gcds_grid_ec02az.namevalue(gcds_grid_ec02az.rowposition,"RESINO");
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"APPDT")=gs_date;
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"REFCDNM")
				=gcds_grid_ec02az.namevalue(gcds_grid_ec02az.rowposition,"REFCDNM"); /*가족관계*/
				gcds_grid_ec03az.namevalue(gcds_grid_ec03az.rowposition,"LSTEDCNM")
				=gcds_grid_ec02az.namevalue(gcds_grid_ec02az.rowposition,"LSTEDCNM"); /*학력사항*/
			}
		}
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Insert_Delete(){   //속아내기
	if(gcds_grid_ec03az.countrow > 0)	{
		for(i=1;i <= gcds_grid_ec03az.countrow;i++)	{
			for(j=1;j <= gcds_grid_ec02az.countrow;j++)	{
				if(gcds_grid_ec03az.namevalue(i,"RESINO")==gcds_grid_ec02az.namevalue(j,"RESINO"))	{
					gcds_grid_ec02az.deleterow(j);
				}
			}
		}
	}
	//document.all.LowerFrame.style.visibility="hidden";
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if (gcds_grid_ec03az.IsUpdated) {
		if (confirm("변경된 정보를 저장하시겠습니까?")) {
			gctr_grade1.KeyValue = "p050004_t1(I:USER=gcds_grid_ec03az)";
			gctr_grade1.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050004_t1";
			gctr_grade1.post();
		}
	}
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Del(){
	if (confirm("선택한 정보를 삭제하시겠습니까?")){
		gcds_grid_ec03az.deleterow(gcds_grid_ec03az.rowposition);
		ln_Save();
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(Obj){
	if(Obj=="gcgd_create")	{
		document.all.gcgd_create.style.display="block";
		document.all.div_create.style.display="block";
		document.all.gcgd_select.style.display="none";
		document.all.div_select.style.display="none";
	}	else	{
    document.all.gcgd_create.style.display="none";
		document.all.div_create.style.display="none";
		document.all.gcgd_select.style.display="block";
		document.all.div_select.style.display="block";
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+TREECD">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec01az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
  <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 인사기본 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec02az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
	<PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 가족사항 -->
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_grid_ec03az" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
  <PARAM NAME="SYNCLOAD" VALUE="false">  <!-- 학비보조금 -->
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_grade1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--공통하위코드 TR-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_dept" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="전체";
	gclx_select_ec02az.index=0;
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	ft_cnt0.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt0.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if(gcds_grid_ec01az.countrow <=0) {
		alert("조회된 데이타가 없습니다.");
	}else	{
		ln_Query_2();
	}
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	ft_cnt2.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	gcds_grid_ec03az.ClearData();
	gcds_grid_ec02az.InsertRow(1);
	gcds_grid_ec02az.NameValue(1,"FAMNM")=gcds_grid_ec01az.NameValue(gcds_grid_ec01az.rowposition,"EMPNMK");
	gcds_grid_ec02az.NameValue(1,"RESINO")=gcds_grid_ec01az.NameValue(gcds_grid_ec01az.rowposition,"RESINO");
	gcds_grid_ec02az.NameValue(1,"REFCDNM")="본인";
	gcds_grid_ec02az.NameValue(1,"LSTEDCNM")
	=gcds_grid_ec01az.NameValue(gcds_grid_ec01az.rowposition,"EDCCDNM")
	 +" " + gcds_grid_ec01az.NameValue(gcds_grid_ec01az.rowposition,"EDCDIVNM");

	if(gcds_grid_ec02az.countrow <=0)	{
	window.status="조회가 완료 되었습니다.";
	//alert("조회된 가족사항 데이타가 없습니다.");
	}	else {ln_Query_3(); }
</script>

<script language="javascript" for="gcds_grid_ec03az" event="OnLoadStarted()">
	ft_cnt2.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec03az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="visible";
	if(gcds_grid_ec03az.countrow >0)	{
		//document.all.LowerFrame.style.visibility="hidden";
		//ln_Insert_Delete();
	}	else	{
		//document.all.LowerFrame.style.visibility="hidden";
		//alert("조회된 학비보조금신청 데이타가 없습니다.");
	}
</script>

<script language=JavaScript for=gcds_grid_ec01az event=OnRowPosChanged(row)>
	if(row > 0)
   ln_Query_2();
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_select_ec02az event=onSelChange()>
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_select_ec02az.ValueOfIndex ("level", gclx_select_ec02az.Index);
	gs_treecd = gclx_select_ec02az.ValueOfIndex ("treecd", gclx_select_ec02az.Index);
	gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_grade1" event="OnSuccess()">
	alert("요청하신 작업을 성공적으로 수행하였습니다.");
	//ln_Query();
</script>

<script language="javascript" for="gctr_grade1" event="OnFail()">
	alert("중복된 데이타 입력으로 에러가 발생했습니다.");
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/p050004_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
          <td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;기준년월&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:1px;">&nbsp;<nobr>
						<comment id="__NSID__"><object id=gcem_yymm_search classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="1"	style="position:relative; left:1px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=1>
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
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;소속&nbsp;</nobr></td>
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>
						<comment id="__NSID__"><object id=gclx_select_ec02az  name="gclx_select_ec02az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:2px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value=gcds_dept>
							<param name=SearchColumn		value="DEPTCD^DEPTNM">
							<param name=Sort            value="false">
							<param name=SortColumn			value="DEPTCD">
							<param name=ListExprFormat	value="DEPTNM^0^130">
							<param name=BindColumn			value="DEPTCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
					</td>  
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee"><nobr>&nbsp;성명&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:0px;" ><nobr>&nbsp;<INPUT TYPE=TEXT id="txt_empnmk" class="txtbox" STYLE="width:60px;position:relative;left:-2px" onkeydown="if(event.keyCode==13) ln_Query();">&nbsp;</nobr></td> 
					<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
				</tr>
			</table>		
		</td>
  </tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  style="WIDTH: 280px; HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_grid_ec01az">
							<PARAM NAME="Editable" VALUE="False">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='소속' ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=114 align=LEFT   sort=true</C> 
								<C> Name='사번' ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=CENTER  sort=true</C> 
								<C> Name='성명' ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=72 align=CENTER sort=true</C> 
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div0 style="width:282px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt0 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
					</td>
					<td width=3></td>
					<td valign=top>
						<table border= "0"  cellpadding=0 cellspacing=0  border=0 style='width:590px;height:210px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
							<tr>
                <td colspan=3 >
			        		<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create style="WIDTH: 590px; HEIGHT:130px;border:1 solid #777777;display:block;" viewastext>
										<PARAM NAME="DataID"			VALUE="gcds_grid_ec02az">
										<PARAM NAME="Editable" VALUE="False">
										<PARAM NAME="BorderStyle" VALUE="0">
										<param name="Fillarea"		VALUE="true">
										<PARAM NAME="Format"			VALUE="  
											<C> Name='성명'			ID=FAMNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center	</C> 
											<C> Name='주민번호'	ID=RESINO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=CENTER	</C> 
											<C> Name='관계'			ID=REFCDNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	</C> 
											<C> Name='최종학력' ID=LSTEDCNM HeadAlign=Center HeadBgColor=#B9D4DC Width=160  align=CENTER	</C> 
											<C> Name='비고'			ID=GODSCR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=165	align=CENTER  </C> 
       							">
                  </OBJECT></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td height=20 width=100><nobr>&nbsp;</nobr></td>
								<td  align="center" width=30 style="padding-top:4px;"> <nobr>&nbsp; &nbsp;</td>
								<td align="right" style="padding-top:4px;"><nobr>&nbsp;
									<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Insert()">
									<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Del()">
									<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">&nbsp;</nobr>
								</td>
	            </tr>
							<tr>
			        <td colspan=3>
			        	<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create style="WIDTH: 590px; HEIGHT:259px;border:1 solid #777777;display:block;" viewastext>
								  <PARAM NAME="DataID"			VALUE="gcds_grid_ec03az">
								  <PARAM NAME="Editable"		VALUE="True">
								  <PARAM NAME="BorderStyle" VALUE="0">
								  <param name="Fillarea"		VALUE="true">
								  <param name="ColSizing"		VALUE="true">
								  <PARAM NAME="Format"			VALUE="  
										<C> Name='성명'			ID=FAMNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  EDIT=NONE</C> 
										<C> Name='주민번호' ID=RESINO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=CENTER	EDIT=NONE </C> 
										<C> Name='신청일'		ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65		align=CENTER  MASK='XXXX/XX/XX' EDIT=NONE </C> 
										<C> Name='신청금액' ID=APPAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT		</C> 
										<C> Name='지급금액' ID=PAYAMT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=RIGHT		</C> 
										<C> Name='지급년월' ID=APPYM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER	MASK='XXXX/XX' </C> 
										<C> Name='신청내역' ID=REQREM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=CENTER	</C> 
										<C> Name='학년'			ID=SCHYEAR  HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center	</C> 
										<C> Name='학교명'		ID=SCHNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=126  align=LEFT		</C> 
       							">
                </OBJECT></comment><script>__ws__(__NSID__);</script>
								<fieldset id=ft_div1 style="width:592px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
									<font id=ft_cnt2 style="position:relative;top:4px;"></font>&nbsp;
								</fieldset>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	
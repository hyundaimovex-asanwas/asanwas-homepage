<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사고과관리 - 평가요소별집계(상향)
+ 프로그램 ID	:   H060047.html
+ 기 능 정 의	:   
+ 변 경 이 력	: 
+ 서 블 릿 명	:   h060047_s1, h060047_s2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>


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
//lfn_init();

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	  gcem_yymm.text = gcurdate.substring(0,7); 
    //strgcem_yyymm= gcem_yymm.text;
		//txt_empnoh.value = gusrid;
	  //txt_empnmh.value = gusrnm;
		//gcra_divcd.CodeValue = '1';
    //gcem_yymm.ENABLE=true;
	//공통코드
	//ln_Luxecombo_load();  
	//gcra_gubun.CodeValue=1

}

/******************************************************************************
	Description : 조회 (피고과자정보)
******************************************************************************/
function ln_Query(){

    if(gcem_yymm.text=="") {
			alert("고과년월은 필수조회 조건입니다.");
		}

    //본사
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060047_s2?v_str1="+gcem_yymm.text;		//고과년월
		//prompt("",gcds_data.DataID);
		gcds_data.Reset(); 
}
/******************************************************************************
	Description : 조회 (평가요소별 집계)
******************************************************************************/
function ln_Query2(strYymm,strEmpno){
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060047_s3?v_str1="+strYymm		  //고과년월
                                                          +"&v_str2="+strEmpno;			//피고과자사번
    //prompt("",gcds_data2.DataID);
		gcds_data2.Reset(); 
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

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_data2.RunExcel('평가요소별 고과점수');
}


/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

}

/******************************************************************************
	Description : Insert Data 저장
	                   저장시   고과자, 피고과자,차수 저장
******************************************************************************/
function ln_Datasave(){

}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){

}


/******************************************************************************
	Description : 보정계산
******************************************************************************/
function ln_Corcal(){

}

/******************************************************************************
	Description : 고과년월 찾기( 현재년월보다 아래로 )
  parameter   :
******************************************************************************/
function ln_Left(){
  //@@@
	gcds_yymm.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060047_s4?v_str1=L&v_str2="+gcem_yymm.text;
	gcds_yymm.Reset();

	if(gcds_yymm.countrow>0&&gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM")!=""){
		gcem_yymm.text = gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM");
	}
}

/******************************************************************************
	Description : 고과년월 찾기 ( 현재년월보다 위로 ) 
  parameter   :
******************************************************************************/
function ln_Right(){
 //@@@
	gcds_yymm.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h060047_s4?v_str1=R&v_str2="+gcem_yymm.text;
	gcds_yymm.Reset();
	if(gcds_yymm.countrow>0&&gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM")!=""){
		gcem_yymm.text = gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM");
	}
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--본사-->
<comment id="__NSID__">
  <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_yymm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
</script>


<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	lbl_search2.innerText = "총 ( " + rowcount + " ) 건";
	window.status = " 조회가 완료 되었습니다.";
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_data event=OnClick(row,colid)>

  if(row>0){
		ln_Query2(gcds_data.namevalue(row,"EVAYM"),gcds_data.namevalue(row,"EMPNO"));
	}

</script>
 

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h060047_head.gif"></td> 
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand"		onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand"		onclick="ln_Query()">&nbsp;
		</td>
  </tr>

	<tr>
		<td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'></td>
				<tr>
						<td width="60"  style="border:0 solid #708090;border-right-width:1px;"     
						bgcolor="#eeeeee"><nobr>&nbsp;고과년월&nbsp;</nobr></td>
						<td  width="50" style="height:30px;border:0 "><nobr>&nbsp
								<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
								style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:굴림; font-size:9pt; "> 
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
						<td style="">
						<img src="../../Common/img/btn/com_btn_left.gif"	 style="cursor:hand;position:relative;top:1px;left:5px" onclick="ln_Left()" >
						<img src="../../Common/img/btn/com_btn_right.gif"  style="cursor:hand;position:relative;top:1px;left:5px" onclick="ln_Right()">
				 </td> 
				</tr>
			</table> 
		</td>
	</tr>

	<tr><td height=3 colspan="2"></td></tr>

	<tr>
		<td colspan=2>
      <table width="876" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:391px;" align=center valign=top>
							<table width="391px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:391px" align=LEFT valign=top  border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data  style="WIDTH: 389px;; HEIGHT: 424px;border:1 solid #777777;z-index:2;" viewastext>
												<param name="DataID"		    value="gcds_data">
												<param name="Editable"      value="false">
												<param name="BorderStyle"   value="0">  
												<param name="Fillarea"		  value="true">
												<param name=ColSelect       value=false>
												<param name=SortView  value="Left">
												<param name=IndWidth        value="0">
												<param name="Format"			  value="  
													<C> Name='고과년월'	ID=EVAYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center mask='XXXX/XX' </C>
													<G> Name='피고과자' HeadAlign=Center HeadBgColor=#B9D4DC Width=200
													<C> Name='사번'	    ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center	 sort=true</C>
													<C> Name='성명'			ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left    sort=true</C>
													<C> Name='소속'			ID=DEPTNMk 	HeadAlign=Center HeadBgColor=#B9D4DC Width=135 align=left		 sort=true</C>
													<C> Name='직위'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left    sort=true</C>
													</G>
											"> 
											</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>

							 <tr>
								<td height="24" border= 1>조회건수 : <label id="lbl_search"></label></td>
							</tr>	
						 </table>
						</td>

            <td style="width:480px;" align=center valign=top rowspan=2>
							<table width="480px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:480px" align=LEFT valign=top   border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH: 479px; HEIGHT: 424px;border:1 solid #777777;z-index:2;border-TOP-width:1px;" viewastext>
												<PARAM NAME="DataID"			VALUE="gcds_data2">
												<PARAM NAME="Editable"    VALUE="false">
												<PARAM NAME="BorderStyle" VALUE="0">
												<param name=ViewSummary	  value=1>
												<param name="Fillarea"		VALUE="true">
												<param name=IndWidth      value="0">
												<PARAM NAME="Format"			VALUE="  
												<C> Name='성명'			ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	Edit=none  sumbgcolor=#89add6</C>   
												<C> Name='구분'     ID=DIVNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	Edit=none  sumbgcolor=#89add6</C> 
												<C> Name='순번'			ID=PRTSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=38		align=center	Edit=none  sumbgcolor=#89add6</C>
												<C> Name='평가요소'	ID=ASKITEM	HeadAlign=Center HeadBgColor=#B9D4DC Width=212  align=left		Edit=none  sumbgcolor=#89add6 SumText='합 계'</C>
												<C> Name='점수'			ID=SCR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=right		Edit=none  sumbgcolor=#89add6 SumText=@sum  </C> 
												<C> Name='평가'			ID=GRADE 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	Edit=none  sumbgcolor=#89add6  </C> 
												">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>
							 <tr>
								<td height="24" border= 1>조회건수 : <label id="lbl_search2"></label></td>
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
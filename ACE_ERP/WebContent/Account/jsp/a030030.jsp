<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 총합계&계정별비교
+ 프로그램 ID	: 
+ 기 능 정 의	: 조회
+ 최 초 이 력	: 정하나
+ 서 블 릿 명	: 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>결산데이터 비교</title>
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


gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}
/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 
	gcem_actyymm.text  = gs_date2;	//회계년월	
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset(); //지점코드
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){ 

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030030_s1?v_str1="+gclx_fdcode.bindcolval
																												 +"&v_str2="+gcem_actyymm.text
																												 +"&v_str3"+gclx_gubun.bindcolval; 
	gcds_data1.Reset(); 

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030030_s2?v_str1="+gclx_fdcode.bindcolval
																												 +"&v_str2="+gcem_actyymm.text
																												 +"&v_str3"+gclx_gubun.bindcolval; 
	//prompt('',gcds_data2.DataID);
	gcds_data2.Reset(); 

}

/******************************************************************************
	Description : 엑셀다운로드
******************************************************************************/
function ln_Excel(){ 
	gcgd_data2.GridToExcel("계정별비교","",2);
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 총합계 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 계정별비교 -->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="A";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
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
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030030_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" height="47">&nbsp;
		  <img name="btn_query" src="../../Common/img/btn/com_b_excel.gif"  style="cursor:hand;" onclick="ln_Excel()">&nbsp;
			<img name="btn_query" src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand;" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;지점코드&nbsp;</nobr></td>
					<td width="150px;" class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat		value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="100px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;회계년월&nbsp;</nobr></td>
					<td width="150px"  class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_actyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="####/##">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>

					<td width="100px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;구분&nbsp;</nobr></td>
					<td width="150px;"   ><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=CBData			    value="A^전체,Y^계정별,N^집계계정">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="CDNAM^0^150">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  	     
					<td width=100%>&nbsp;</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="4">

		<!--총합계-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">  
			  <td height=10>
					<font size="3" color=""><b>[합계]</b></font>
				</td>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:60;width:875" >
							<PARAM NAME="DataID"		VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false"> 
						<!--	<param name="ViewSummary"	value=1> -->
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
								<G>Name='계정원장', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	Name='차변합계',width=145, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=CRAMT,	Name='대변합계' ,width=145,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
								<G>Name='일집계', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DETOT,	Name='차변합계',width=145, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=CRTOT,	Name='대변합계' ,width=145,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>			
								<G>Name='월집계', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=MDETOT,	Name='차변합계',width=148, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
								<C>ID=MCRTOT,	Name='대변합계' ,width=147,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
								</G>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr><td height=10></td></tr>
			</table>



		 <!--계정별 비교-->
			<table width="875" cellpadding="0" cellspacing="0" border="0">
			  <tr>
					<td height=10>
						<font size="3" color=""><b>[계정별 비교]</b></font>
					</td>
				</tr>
				<tr> 
					<td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data2"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:318;width:875" >
							<PARAM NAME="DataID"		VALUE="gcds_data2">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="true">
						<!--	<param name="ViewSummary"	value=1> -->
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
								<G>Name='계정', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=ATCODE	 Name='계정코드',width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center  SumBgColor=#C3D0DB </C>
								<C>ID=ATKORNAM Name='계정명',  width=198, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    SumBgColor=#C3D0DB </C>
								</G>
								<G>Name='차변', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=DEAMT,	Name='계정원장', width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')}</C>
								<C>ID=DETOT,	Name='일집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')}</C>
								<C>ID=MDETOT,	Name='월집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(DEAMT,DETOT,decode(DETOT,MDETOT,decode(MDETOT,DEAMT,'','Orange'),'Orange'),'Orange')}</C>
								</G>
								<G>Name='대변', HeadBgColor=#B9D4DC,HeadAlign=center
								<C>ID=CRAMT,	Name='계정원장', width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')}</C>
                <C>ID=CRTOT,	Name='일집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')}</C>
								<C>ID=MCRTOT,	Name='월집계',   width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB BgColor={decode(CRAMT,CRTOT,decode(CRTOT,MCRTOT,decode(MCRTOT,CRAMT,'','YELLOW'),'YELLOW'),'YELLOW')}</C>
								</G>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt2 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
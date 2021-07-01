
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 결산관리/결산집계상태
+ 프로그램 ID	: 
+ 기 능 정 의	: 결산 시점의 상위집계가 최종 상태인지 확인함.
                결산 후 전표 수정할 경우 상위집계상태가 변경됨.
+ 작  성   자 : 정  영  식
+ 작 성 일 자 : 2010.08.26
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
<title>결산집계상태</title>

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
gs_date2= gcurdate.substring(0,4);
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
	gcem_actyyyy.text  = gs_date2;	//회계년월	
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset(); //지점코드


	gclx_gubun.index=0;
}

/******************************************************************************
	Description : 상위집계상태 조회
******************************************************************************/
function ln_Query(){ 

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040015_s1?v_str1="+gclx_fdcode.bindcolval
																												 +"&v_str2="+gcem_actyyyy.text
																												 +"&v_str3="+gclx_gubun.bindcolval; 
	gcds_data1.Reset(); 

	gcds_data2.clearAll();
}

/******************************************************************************
	Description : 상위집계내역 조회
******************************************************************************/
function ln_Query2(strGubun,strFdcode,strYymm){ 

	gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040015_s2?v_str1="+strFdcode
																												 +"&v_str2="+strYymm
																												 +"&v_str3="+strGubun; 
  //prompt('',gcds_data2.DataID )
	gcds_data2.Reset(); 

}

/******************************************************************************
	Description : 엑셀다운로드
******************************************************************************/
/**
function ln_Excel(){ 
	gcgd_data2.GridToExcel("계정별비교","",2);
}
**/
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 상위집계상태 -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 상위집계내역 -->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
  window.status="조회가 완료 되었습니다.";
	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
  window.status="조회가 완료 되었습니다.";
	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
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


<script language=JavaScript for=gcgd_data1 event=OnClick(row,colid)>
	
	if(row>0){
		ln_Query2(gcds_data1.namevalue(row,"GUBUN"),gcds_data1.namevalue(row,"FDCODE"),gcds_data1.namevalue(row,"ACTYYMM"));
	}

</script>
 


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
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a040015_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" height="47">&nbsp;
		  <!-- <img name="btn_query" src="../../common/img/btn/com_b_excel.gif"  style="cursor:hand;" onclick="ln_Excel()"> -->&nbsp;
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
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="100px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;회계년도&nbsp;</nobr></td>
					<td width="150px"  class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_actyyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:40px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="####">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>

					<td width="100px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;구분&nbsp;</nobr></td>
					<td width="150px;"   ><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=CBData			    value="A^전체,1^일반회계,9^수정분개">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
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
			 <tr>
					<td height=10>
						<font size="2" color="blue"><b>[상위집계상태]</b></font>
					</td>
					<td height=10>&nbsp;
					</td>
					<td height=10>
						<font size="2" color="blue"><b>[상위집계내역]</b></font>
					</td>
			  </tr>
				<tr> 
					<td style="width:470" class="tab25">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:470" >
							<PARAM NAME="DataID"		  VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false"> 
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		  VALUE=" 
								<C>ID=GUBUN,	  Name='구분',    width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=left   sort=true  EditStyle=Combo	Data='1:일반회계,9:수정분개'</C>
								<C>ID=FDCODE,	  Name='지점',    width=55,  HeadBgColor=#B9D4DC,HeadAlign=center, align=left   sort=true  EditStyle=Lookup	Data='gcds_fdcode:FDCODE:FDNAME'</C>
								<C>ID=ACTYYMM,	Name='년월',    width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center sort=true  mask='XXXX/XX' </C>
								<C>ID=UPDT,	    Name='일시',    width=145, HeadBgColor=#B9D4DC,HeadAlign=center, align=center sort=true  </C>
								<C>ID=UPID,	    Name='작업자',  width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center sort=true  show=false</C>
								<C>ID=EMPNMK,	  Name='작업자',  width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center sort=true  </C>
								<C>ID=UPSTS,   	Name='상태',    width=70,  HeadBgColor=#B9D4DC,HeadAlign=center, align=left   sort=true  EditStyle=Combo	Data='1:집계완료,2:취소수정,3:완료수정'</C>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:0px;width:472px;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						
						</fieldset>
					</td>
					<td height=10>&nbsp;
					</td>
					<td style="width:395" class="tab25">
						<comment id="__NSID__"><object  id="gcgd_data2"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:395" >
							<PARAM NAME="DataID"		  VALUE="gcds_data2">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false"> 
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		  VALUE=" 
							  <C>ID=FDCODE,	  Name='지점',    width=55,  HeadBgColor=#B9D4DC,HeadAlign=center, align=left   EditStyle=Lookup	Data='gcds_fdcode:FDCODE:FDNAME' </C>
								<C>ID=ACTYYMM,	Name='년월',    width=60,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center mask='XXXX/XX' </C>
                <C>ID=UPSEQ,	  Name='순번',    width=50,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center  </C>
								<C>ID=UPDT,	    Name='일시',    width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  </C>
								<C>ID=EMPNMK,  	Name='작업자',  width=80,  HeadBgColor=#B9D4DC,HeadAlign=center, align=center  </C>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:0px;width:397px;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>

					</td>
				</tr>
				<tr><td height=10></td></tr>
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
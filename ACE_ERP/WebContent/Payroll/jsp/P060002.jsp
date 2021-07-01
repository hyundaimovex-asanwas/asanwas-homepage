<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	급여/항목별급여현황
+ 프로그램 ID	: P060002
+ 기 능 정 의	: 조회|엑셀
+ 변 경 이 력	: 이순미
+ 서 블 릿 명	: p060002_s1
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>항목별급여현황</title>


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

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_yyyy_mm_1.Text=gs_date2
	gcem_yyyy_mm_2.Text=gs_date2

	//직군코드
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2000"; 
	gcds_data.Reset(); 

  ln_Jikwi();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	var str_Format=""
	 + "<FC> Name='지급항목' ID=PAYCDNM BgColor='#f5f5f5' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 SumBgColor=#C3D0DB SumText='합계' align=left  </FC> "
	 +  " <FC>Id=CrossTabSum Name='계' BgColor='#f5f5f5'  HeadBgColor=#B9D4DC width=100   align=right   Value={CrossTabSum(GUBUNSUM)}  sumBgColor=#C3D0DB      </FC>"
	 +  "  <R> Name=$xkeyname_$$ HeadBgColor=#B9D4DC    "
	 +  "	<C>ID=GUBUNSUM_$$      Name='$xkeyname_$$'       width=80  align=right HeadBgColor=#B9D4DC sumBgColor=#C3D0DB  SumText='@sum' </C> "
	 +  " </R> ";

	gcgd_create.Format=str_Format;

	var str1 = gcem_yyyy_mm_1.Text;  //지급구분
	var str2 = gcem_yyyy_mm_2.Text;  //급여항목구분
	var str3 = gclx_select_ec01az.BindColVal;
	gcds_data03.ClearData();

	gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p060002_s1?v_str1="+str1
													 +"&v_str2="+str2
													 +"&v_str3="+str3
													 +"&v_str4="+gs_date2;
	gcds_data03.Reset(); 
}

/******************************************************************************
	Description : 선조회 조건
******************************************************************************/
function ln_Jikwi(){
	var str1 = gcem_yyyy_mm_1.Text;  //지급구분
	var str2 = gcem_yyyy_mm_2.Text;  //급여항목구분
	var str3 = fn_trim(gclx_select_ec01az.BindColVal);

	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p060001_s2?v_str1="+str1
	                         +"&v_str2="+str2
												   +"&v_str3="+str3;
	gcds_data02.Reset(); 
}

/******************************************************************************
	Description : 그리드 Format 
******************************************************************************/
function ln_JikwiFormat(){
	var str_Format=""
	 + "<FC> Name='지급항목' ID=PAYCDNM BgColor='#f5f5f5'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 SumBgColor=#C3D0DB SumText='합계' align=left  </FC> "
	+" <FC> Name='계' ID='GUBUNSUM'  BgColor='#f5f5f5'	Head HeadBgColor=#B9D4DC Width=90   SumBgColor=#C3D0DB	 SumText=@sum  </FC> ";
	for( i=1;gcds_data02.countrow >= i; i++)	{
			str_Format+="<C> Name='" +gcds_data02.namevalue(i,"MINORNM")+"' ID='F"+i+"_AMT'  	Head HeadBgColor=#B9D4DC Width=90  SumBgColor=#C3D0DB align=RIGHT Edit=Numeric  SumText=@sum </C> ";
	}
	gcgd_create.Format=str_Format;
	//document.all.LowerFrame.style.visibility="hidden";
}

/*******************************************************************************
  Description : Grid 데이터를 Excel을 실행시켜 출력
******************************************************************************/
function ln_Excel(){
	if (gcds_data03.countrow<1) alert("다운로드하실 자료가 없습니다.");
	else gcgd_create.RunExcel('항목별급여현황');
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data02" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--직위 동적 그리드 포맷-->

<comment id="__NSID__"><object id="gcds_data03" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_data04" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<param name=DataID		value="gcds_data03">
	<param name=Logical		value="true">
	<param name=GroupExpr	value="PAYCDNM: PAYCD,PAYGRDNM,GUBUNSUM">
</object></comment><script>__ws__(__NSID__);</script>

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

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	gcds_data.InsertRow(1);
    gcds_data.NameValue(1,"MINORCD")="";
    gcds_data.NameValue(1,"MINORNM")="전체";
    gclx_select_ec01az.index=0;
	////document.all.LowerFrame.style.visibility="hidden";
	window.status="데이타 조회가 완료되었습니다.";
</script>

<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	window.status="데이타 조회가 완료되었습니다.";
	if(gcds_data02.countrow > 0)	{
		ln_JikwiFormat();
	}	else	{
		//document.all.LowerFrame.style.visibility="hidden";
	}
</script>

<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
	ft_cnt1.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data03" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data03.countrow <=0)
			alert("조회된 데이타가 없습니다.");
</script>

<script language="javascript" for="gcds_data04" event="onloadcompleted(row,colid)">
	if(row !=0)	{
	//콤마생성 문제로 시작 생성
	var str1=gcds_data03.Sum(5,0,0)+"";
	if(parseInt(str1.length/3) >1){
		var str2="";
		var j=0;
		if((str1.length%3) != 0){
			str2=str1.substring(0,str1.length%3)+",";
			j=str1.length%3;
		}

		for(var i=1; i <=(parseInt(str1.length/3)-1); i++){
			str2+=str1.substring(j,j+3)+",";
			j+=3;
		}
		str2+=str1.substring((str1.length-3),str1.length);
	}	else {
		var str2=str1;
	}
	//콤마생성 문제로 끝
		gcgd_create.ColumnProp('CrossTabSum', 'SumText')  = str2;
		gcgd_create.ColumnProp('CrossTabSum', 'SumTextAlign') = "right";
	}	else	{		}
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
\

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p060002_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()" >  
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	
	<table  cellpadding="1" cellspacing="0" border="0"      
	   style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
						<nobr>&nbsp;지급년월&nbsp;</nobr></td>
					<td style="border:0 solid #708090;border-right-width:0px;">&nbsp;
						<comment id="__NSID__"><object id=gcem_yyyy_mm_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:-2px;top:2px; width:50px; height:20px;" class=txtbox
				        validFeatures="ignoreStatus=yes" validExp="">
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
        		</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td> 
						<td><nobr>∼</nobr></td> 
						<td style="border:0 solid #708090;border-right-width:1px;"><nobr>
							<comment id="__NSID__"><object id=gcem_yyyy_mm_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				        style="position:relative; left:1px;top:2px; width:50px; height:20px;" class=txtbox
				        validFeatures="ignoreStatus=yes" validExp="">
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
							<nobr>&nbsp;&nbsp;직&nbsp;&nbsp;&nbsp;군&nbsp;&nbsp;</nobr></td>
						<td width="10" style="border:0 solid #708090;border-right-width:0px;"><nobr>
							<comment id="__NSID__"><object id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69   style="position:relative;left:4px;top:2px;font-size:12px;width:120px;height:200px;">
							<param name=ComboDataID			value="gcds_data"> 
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;</nobr>
						</td>   
			<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
		</tr>
	</table>		
		</td>
			</tr>
		  <tr><td height=3></td></tr>  
			<tr><td COLSPAN=2></td></tr>
			<tr> 
				<td colspan=2> 

      <table width="870" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td style="border-bottom-width:0px;" >
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  
						style="WIDTH: 874px; HEIGHT: 415px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"					VALUE="gcds_data04">
							<PARAM NAME="Editable"        VALUE="false">
							<PARAM NAME="BorderStyle"     VALUE="0">
							<PARAM NAME="Fillarea"				VALUE="true">
							<PARAM NAME="ViewSummary"			VALUE="1">
							<PARAM NAME="Format"					VALUE="  
								<C> Name='지급항목' ID=PAYCDNM  	HeadAlign=Center align=left HeadBgColor=#B9D4DC Width=90 SumBgColor=#C3D0DB SumText='합계'  </C> 
								<C> Name='계'				ID='GUBUNSUM' Head HeadBgColor=#B9D4DC Width=90   SumBgColor=#C3D0DB	SumText=@sum  </C> 
       					">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						 <fieldset id=ft_div1 style="width: 876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
						</fieldset>
					</td>
					<td width=3></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
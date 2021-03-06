
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 환율적용	
+ 프로그램 ID	:  A020006.html
+ 기 능 정 의	:  금강산 달러를 원화롤 변환
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.04.26
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 환율적용 방법  변경 
                 유형자산의 경우 환율으로 변환 하지 않고
								 현재의 금액을 그대로 사용함.
+ 수   정  자 :  정 영 식
+ 수 정 일 자 :  2006.11.15
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 년이월 데이터도 환율변환 적용함.
+ 수   정  자 :  정 영 식
+ 수 정 일 자 :  2010.03.04
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
    var stryyyy="";

    gcem_chgyy.text = gcurdate.substring(0,4)
	gcem_chgyymm1.text = gcurdate.substring(0,4)+"01";
	gcem_chgyymm2.text = gcurdate.substring(0,4) + gcurdate.substring(5,7);
	
	ln_Before();

	gclx_fdcode.bindcolval="03";
	gclx_fdcode2.bindcolval="03";

	ln_Rate('02',gcem_chgyymm2.text);
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
  	var stryyyy="";
	var strmm="";
    stryyyy=gcem_chgyy.text;
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020006_s1?v_str1="+gclx_fdcode.bindcolval
																		  +"&v_str2="+stryyyy;
																									 
 // prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();		
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Before(){
 
	//지점
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();

	gcds_comfield2.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield2.DataID);
	gcds_comfield2.Reset();

}

/******************************************************************************
	Description : 환율조회
******************************************************************************/
function ln_Rate(ercode,erstddat){
	gcds_exrate.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_exrate_s1?v_str1="+ercode+"&v_str2="+erstddat;
	//prompt('',gcds_exrate.DataID);
	gcds_exrate.Reset();

  	if(gcds_exrate.countrow>0){
		gcem_ermmlast.text=gcds_exrate.namevalue(gcds_exrate.rowposition,"ERMMLAST");
		gcem_eravg.text=gcds_exrate.namevalue(gcds_exrate.rowposition,"ERAVG");
	}else{
		alert("환율이 등록되지 않았습니다. 확인 바랍니다.");
    	gcem_ermmlast.text=0;
		gcem_eravg.text=0;
	}
}

/******************************************************************************
	Description : 실행
******************************************************************************/
function ln_Run(){
	
	if(ln_Chk()){
	
		//금강산 달러환율
		//2007.11.23 정영식 막음 
		//a020006_t1 내에서 환율을 조회해서 적용함.
		/* 
		gcds_exrate.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_exrate_s1?v_str1=02&v_str2=";
		prompt("",gcds_exrate.DataID);
		return;
		gcds_exrate.Reset();
    	*/
		gcds_data02.ClearAll();
		ln_SetDataHeader();

		ln_Data();
		gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020006_t1?";
		prompt("gcds_data02",gcds_data02.text);
		gctr_data01.post();
	}

}

	
/******************************************************************************
	Description : 체크
  parameter   : 
******************************************************************************/
function ln_Chk(){
	if (gclx_fdcode2.bindcolval!="03"){
		alert("금강산 건만 환율 변환 가능합니다.");
		return false;
	}else{
		return true;
	}

  	if(gcem_chgyymm1.text==""||gcem_chgyymm2.text==""){
    	alert("변환년월을 입력하십시요.");
		return false;
	}

}
/******************************************************************************
	Description : Dataset Head 설정 
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data02.countrow<1){
		var s_temp = "FDCODE:STRING,CHGYY:STRING,CHGMM:STRING,CHGGB:STRING,WRDT:STRING,WRID:STRING,CHGYYMMFR:STRING,CHGYYMMTO:STRING,"
		 		   + "UPDT:STRING,UPID:STRING";
		gcds_data02.SetDataHeader(s_temp);
	}
}
/******************************************************************************
	Description : Data 지정
  parameter   : 
******************************************************************************/
function ln_Data(){

  	var stryyyy="";
	var strmm="";
	//2007.11.23 정영식 추가
	var stryymm_fr="";
	var stryymm_to="";

  	stryyyy=gcem_chgyymm2.text;
	strmm=stryyyy.substring(4,6);
	stryyyy=stryyyy.substring(0,4);

  	stryymm_fr = gcem_chgyymm1.text;
	stryymm_to = gcem_chgyymm2.text;

  	gcds_data02.Addrow();
	gcds_data02.namevalue(gcds_data02.rowposition,"FDCODE")=gclx_fdcode2.bindcolval;
	gcds_data02.namevalue(gcds_data02.rowposition,"CHGYY")=stryyyy;
	gcds_data02.namevalue(gcds_data02.rowposition,"CHGMM")=strmm;
	gcds_data02.namevalue(gcds_data02.rowposition,"CHGGB")='Y';
	gcds_data02.namevalue(gcds_data02.rowposition,"WRDT")=gs_date;
	gcds_data02.namevalue(gcds_data02.rowposition,"WRID")=gs_userid;
	gcds_data02.namevalue(gcds_data02.rowposition,"CHGYYMMFR")=stryymm_fr;
	gcds_data02.namevalue(gcds_data02.rowposition,"CHGYYMMTO")=stryymm_to;
	gcds_data02.namevalue(gcds_data02.rowposition,"UPDT")=gs_date;
	gcds_data02.namevalue(gcds_data02.rowposition,"UPID")=gs_userid;
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 지점 -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 지점 -->
<comment id="__NSID__"><object  id=gcds_comfield2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id=gcds_exrate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 전표 Detail 넘기기 -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020006_t1(I:USER=gcds_data02)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("검색된 데이터가 없습니다.");
	}else{
	}
</script>

<script language=JavaScript for=gcem_chgyymm2 event=onLastChar(char)>
  if(gcem_chgyymm2.text.substring(4,6)=="00"){
		gcem_chgyymm1.text = gcem_chgyymm2.text;  
	}
  ln_Rate('02',gcem_chgyymm2.text);  
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data01" event="onfail()">
	//alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a020006_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
	</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td width="80px" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"  align=center><nobr>지점구분</nobr></td>
					<td style="width:200px;" align=left ><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
								<param name=ComboDataID    value="gcds_comfield">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			     value=false>
								<param name=ListExprFormat value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					 </td> 
					
					<td width="80" align=center  style="border:1 solid #708090;border-top-width:0px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"><nobr>변환년도</nobr></td>
					<td>&nbsp;
						<comment id="__NSID__"><object  id=gcem_chgyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:40px;height:20px;position:relative;left:-5px;top:2px" onKeydown="if(event.keyCode==13) ln_Query()">		
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=Format        value="YYYY">
							<param name=PromptChar    value="_">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=false>

						</object></comment><script>__ws__(__NSID__);</script> 
          
					</td>
					<td width="10"	align=RIGHT style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;"></td>
					<td width="150" align=RIGHT	style="border:0 solid #708090;border-right-width:0px;"></td>
					<td width="10"	align=RIGHT style="border:0 solid #708090;border-right-width:0px;"></td>
					<td><nobr></nobr></td>
				</tr>
			</table>
		</td>
	</tr>  	
	<tr><td colspan=2 height=3> 
		</td>
	</tr> 
	
  <tr> 
    <td colspan="2" align=left style="padding-left:0px;"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:567px;height:210">
						<comment id="__NSID__"><object  id=gcgd_code01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:567px; HEIGHT:437px;border:1 solid #777777;" viewastext class="txtbox">
              				<PARAM NAME="DataID"			VALUE="gcds_data01">
              				<PARAM NAME="Editable"		VALUE="false">
              				<PARAM NAME="BorderStyle" VALUE="0">
							<param name="SortView"    value="Left">
							<param name="ColSizing"  value="true">
							<param name="FillArea"   value="True">
							<param name="IndWidth"   value="0">
							<PARAM NAME="Format"			VALUE="
								<C> Name='지점'	    ID=FDCODE	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center	sort=true  show=false</C>
								<C> Name='지점'	    ID=FDNAME	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center	sort=true</C>
								<C> Name='변환년도'	ID=CHGYY	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center	sort=true</C>
								<C> Name='변환월'	  	ID=CHGMM	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center   sort=true</C>
								<C> Name='순번'	    ID=CHGSEQ	HeadAlign=Center HeadBgColor=#B9D4DC Width=50    align=center	Edit=none </C>
								<C> Name='적용'	    ID=CHGGB	HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center	Edit=none </C>
								<C> Name='작업일자'	ID=WRDT     HeadAlign=Center HeadBgColor=#B9D4DC Width=100   align=center   Edit=none Mask='XXXX/XX/XX' sort=true </C>
							">
            			</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:0px;width:569px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
          			<td width=0><nobr>&nbsp;</nobr></td>
					<td style="">
						<table border="0" cellpadding="0" cellspacing="0" style="width:300px; height:215px;">
							<tr>
								<td valign=middle width=250 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;&nbsp;&nbsp;환율적용&nbsp;&nbsp;&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<img src="../../Common/img/btn/com_b_execute.gif"		style="cursor:hand" onClick="ln_Run()">
								</td>									
							</tr>
							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>지점</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:150px;">
											<param name=ComboDataID    value="gcds_comfield2">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value=FDNAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>		
							</tr>
							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>변환년월(FR)</nobr></td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
									<object  id=gcem_chgyymm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:1px;left:0px;width:50px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="####-##">
									<param name=PromptChar	  value="_">
									<param name=Enable        value=true>
									</object></comment><script>__ws__(__NSID__);</script> 
								</td>								
							</tr>

							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>변환년월(TO)</nobr></td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
									<object  id=gcem_chgyymm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:1px;left:0px;width:50px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="####-##">
									<param name=PromptChar	  value="_">
									</object></comment><script>__ws__(__NSID__);</script> 
								</td>								
							</tr>

							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>월말환율</nobr></td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
									<object  id=gcem_ermmlast classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:1px;left:0px;width:60px;height:20px;">
									<param name=Alignment		value=2>
									<param name=Numeric			value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength		value=10>
									<param name=MaxDecimalPlace	value=5>
									<param name=ReadOnly   value="true">
                  					<param name=ReadOnlyBackColor   value="#CCFFCC">
									</object></comment><script>__ws__(__NSID__);</script> 
								</td>								
							</tr>

							<tr>
								<td style="height:25px;width:205px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>평균환율</nobr></td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;<comment id="__NSID__">
									<object  id=gcem_eravg classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									style="position:relative;top:1px;left:0px;width:60px;height:20px;">
									<param name=Alignment		value=2>
									<param name=Numeric			value=true>
									<param name=IsComma			value=true>
									<param name=MaxLength		value=10>
									<param name=MaxDecimalPlace	value=5>
									<param name=ReadOnly   value="true">
                  					<param name=ReadOnlyBackColor   value="#CCFFCC">
									</object></comment><script>__ws__(__NSID__);</script> 
								</td>								
							</tr>

							<tr>
								<td style="height:302px;border:1 solid #708090;border-top-width:0px;" >&nbsp;</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
										<B><font  color=#3366ff>[#참고]<BR><P>
										  변환년월(TO)의 월말환율, 평균환율을 기준으로 변환됩니다. <P>
										  <!-- 적용기간은 기본적으로 당해년도<BR> 1월부터 현재년월까지 설정됩니다.&nbsp;
											<BR>만약, 년 중 특정월을만 변환할려면 변환년월(FR)과 변환년월(TO)를 <BR> 수정하여 실행하십시요.</font></b> -->
                      					  환율변환 후 [원단위 보정] ==> <BR>  [외환차손/차익 반영] ==> <BR>  [상위집계 반영]을 하여야 합니다.<BR><BR><BR><BR><BR><BR><BR><BR><BR>
								</td>
							</tr>
						
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
	<tr><td colspan=2 height=3> 
		</td>
	</tr> 

</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code01>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=CMTYPE    Ctrl=txt_cmtype       Param=value</C>
		<C>Col=CMNAM		 Ctrl=txt_cmnam        Param=value</C>
		<C>Col=CMLEN		 Ctrl=gcem_cmlen			 Param=text </C>
		<C>Col=DSUDT		 Ctrl=gcem_dsudt01		 Param=text</C>
		<C>Col=CMREMARK	 Ctrl=txt_cmremark		 Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcbn_code02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_code02>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=CDCODE    Ctrl=txt_cdcode      Param=value</C>
		<C>Col=CDNAM		 Ctrl=txt_cdnam       Param=value</C>
		<C>Col=PSEQ      Ctrl=txt_pseq        Param=value</C>
		<C>Col=DSUDT		 Ctrl=gcem_dsudt02		Param=text </C>
		<C>Col=GBCD      Ctrl=txt_gbcd        Param=value</C>
		<C>Col=CDREMARK	 Ctrl=txt_cdremark		Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 